ROOT_DIR ?= $(shell git rev-parse --show-toplevel)
UNTRACKED ?= $(shell test -z "$(shell git ls-files --others --exclude-standard "$(ROOT_DIR)")" || echo -untracked)
VERSION ?= $(shell git describe --tags --dirty --always)$(UNTRACKED)

APPS ?= node_exporter
.PHONY: $(APPS)

BUILD_DIR ?= ./build/$(VERSION)

$(BUILD_DIR):
	mkdir -p $@

SRC_DIR ?= ./src

$(APPS):
	$(MAKE) -C ./$@ artifacts

tar: $(BUILD_DIR) $(APPS)
	for app in $(APPS); do \
		mkdir -p "$(BUILD_DIR)/apps/$$app"; \
		cp -vr "./$$app/$(BUILD_DIR)"/* "$(BUILD_DIR)/apps/$$app"; \
		done
	cp ./install.sh "$(BUILD_DIR)/apps/"
	tar -C "./$(BUILD_DIR)/apps" -zcvf "$(BUILD_DIR)/apps.tar.gz" .
