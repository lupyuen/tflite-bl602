
# Component Makefile
#

# Include Folders
COMPONENT_ADD_INCLUDEDIRS := \
	tensorflow/.. \
	tensorflow/lite/micro/tools/make/downloads/flatbuffers/include

# Object Files (*.o)
COMPONENT_OBJS := $(patsubst %.c,%.o, $(COMPONENT_SRCS))

# Source Folders
COMPONENT_SRCDIRS := tensorflow/lite/micro

# TensorFlow Makefile
# Based on https://github.com/lupyuen/bl_iot_sdk/blob/tflite/customer_app/sdk_app_tflite/Makefile

# root directory of tensorflow
TENSORFLOW_ROOT := 
MAKEFILE_DIR := $(BL60X_SDK_PATH)/components/3rdparty/tflite-bl602/tensorflow/lite/micro/tools/make

# For some invocations of the makefile, it is useful to avoid downloads. This
# can be achieved by explicitly passing in DISABLE_DOWNLOADS=true on the command
# line. Note that for target-specific downloads (e.g. CMSIS) there will need to
# be corresponding checking in the respecitve included makefiles (e.g.
# ext_libs/cmsis_nn.inc)
DISABLE_DOWNLOADS :=

ifneq ($(DISABLE_DOWNLOADS), true)
  # The download scripts require that the downloads directory already exist for
  # improved error checking. To accomodate that, we first create a downloads
  # directory.
  $(shell mkdir -p ${MAKEFILE_DIR}/downloads)

  # Directly download the flatbuffers library.
  DOWNLOAD_RESULT := $(shell $(MAKEFILE_DIR)/flatbuffers_download.sh ${MAKEFILE_DIR}/downloads)
  ifneq ($(DOWNLOAD_RESULT), SUCCESS)
    $(error Something went wrong with the flatbuffers download: $(DOWNLOAD_RESULT))
  endif

  DOWNLOAD_RESULT := $(shell $(MAKEFILE_DIR)/pigweed_download.sh ${MAKEFILE_DIR}/downloads)
  ifneq ($(DOWNLOAD_RESULT), SUCCESS)
    $(error Something went wrong with the pigweed download: $(DOWNLOAD_RESULT))
  endif

  include $(MAKEFILE_DIR)/third_party_downloads.inc
  THIRD_PARTY_DOWNLOADS :=
  $(eval $(call add_third_party_download,$(GEMMLOWP_URL),$(GEMMLOWP_MD5),gemmlowp,))
  $(eval $(call add_third_party_download,$(RUY_URL),$(RUY_MD5),ruy,))
  $(eval $(call add_third_party_download,$(PERSON_MODEL_URL),$(PERSON_MODEL_MD5),person_model_grayscale,))
  RESULT := $(shell $(MAKEFILE_DIR)/person_detection_int8_download.sh ${MAKEFILE_DIR}/downloads $(CO_PROCESSOR))
  ifneq ($(RESULT), SUCCESS)
    $(error Something went wrong with the person detection int8 model download: $(RESULT))
  endif
endif
