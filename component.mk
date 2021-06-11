#
# Component Makefile
#

# Include Folders
COMPONENT_ADD_INCLUDEDIRS := \
	tensorflow/.. \
	tensorflow/lite/micro/tools/make/downloads/flatbuffers/include

# Source Folders
COMPONENT_SRCDIRS := \
	tensorflow/lite/core/api \
	tensorflow/lite/micro \
	tensorflow/lite/micro/kernels

# Check the submodule is initialised
COMPONENT_SUBMODULES := 
