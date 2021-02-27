include ../Makefile

TMP_DIR ?= /tmp

OS ?= linux
# armv6 for rpi2 (I think)
# armv7 for rpi3
ARCH ?= armv6
NODE_EXPORTER_VERSION ?= 1.1.1
NODE_EXPORTER_ID ?= node_exporter-$(NODE_EXPORTER_VERSION).$(OS)-$(ARCH)
NODE_EXPORTER_TARGZ_NAME ?= $(NODE_EXPORTER_ID).tar.gz
NODE_EXPORTER_TARGZ ?= $(TMP_DIR)/$(NODE_EXPORTER_TARGZ_NAME)
NODE_EXPORTER_BIN ?= $(BUILD_DIR)/$(NODE_EXPORTER_ID)/node_exporter


$(NODE_EXPORTER_TARGZ):
	wget -O $(NODE_EXPORTER_TARGZ) https://github.com/prometheus/node_exporter/releases/download/v$(NODE_EXPORTER_VERSION)/$(NODE_EXPORTER_TARGZ_NAME)

# can't have name node_exporter because it would clash with a rule in the parent Makefile
binary: $(NODE_EXPORTER_TARGZ) $(BUILD_DIR)
	tar -C $(TMP_DIR) -zxvf $(NODE_EXPORTER_TARGZ) $(NODE_EXPORTER_ID)/node_exporter
	mv "$(TMP_DIR)/$(NODE_EXPORTER_ID)/node_exporter" "$(BUILD_DIR)/node_exporter"

COPIES ?= node_exporter.service
$(COPIES): $(BUILD_DIR)
	cp -v "$(SRC_DIR)/$@" "$(BUILD_DIR)/"

artifacts: $(COPIES) binary
