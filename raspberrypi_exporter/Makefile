include ../Makefile

TMP_DIR ?= /tmp

RASPBERRYPI_EXPORTER_REPO ?= github.com/glynternet/raspberrypi_exporter
RASPBERRYPI_EXPORTER_VERSION ?= 0.0.1
RASPBERRYPI_EXPORTER_ID ?= raspberrypi_exporter-$(RASPBERRYPI_EXPORTER_VERSION)
RASPBERRYPI_EXPORTER_TARGZ_NAME ?= raspberrypi_exporter-$(RASPBERRYPI_EXPORTER_VERSION).tar.gz
RASPBERRYPI_EXPORTER_TARGZ ?= $(TMP_DIR)/$(RASPBERRYPI_EXPORTER_TARGZ_NAME)

$(RASPBERRYPI_EXPORTER_TARGZ):
	wget -O $(RASPBERRYPI_EXPORTER_TARGZ) https://$(RASPBERRYPI_EXPORTER_REPO)/archive/$(RASPBERRYPI_EXPORTER_VERSION).tar.gz

# can't have name raspberrypi_exporter because it would clash with a rule in the parent Makefile
script: COMPONENT=raspberrypi_exporter
timer: COMPONENT=raspberrypi_exporter.timer
service: COMPONENT=raspberrypi_exporter.service
script timer service:
	COMPONENT=$(COMPONENT) $(MAKE) get-from-tar

get-from-tar: $(RASPBERRYPI_EXPORTER_TARGZ) $(BUILD_DIR)
	echo $(COMPONENT)
	tar -C $(TMP_DIR) -zxvf $(RASPBERRYPI_EXPORTER_TARGZ) $(RASPBERRYPI_EXPORTER_ID)/$(COMPONENT)
	mv "$(TMP_DIR)/$(RASPBERRYPI_EXPORTER_ID)/$(COMPONENT)" "$(BUILD_DIR)/$(COMPONENT)"

artifacts: service timer script
