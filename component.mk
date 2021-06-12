#
# Component Makefile
#

# Include Folders
COMPONENT_ADD_INCLUDEDIRS := \
    tensorflow/.. \
    tensorflow/lite/micro/tools/make/downloads/flatbuffers/include \
    tensorflow/lite/micro/tools/make/downloads/gemmlowp \
    tensorflow/lite/micro/tools/make/downloads/ruy

# Source Folders
COMPONENT_SRCDIRS := \
    tensorflow/lite/c \
    tensorflow/lite/core/api \
    tensorflow/lite/kernels \
    tensorflow/lite/kernels/internal \
    tensorflow/lite/micro \
    tensorflow/lite/micro/kernels

# Check the submodule is initialised
COMPONENT_SUBMODULES := 
