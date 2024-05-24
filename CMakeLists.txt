cmake_minimum_required(VERSION 3.12)

project(p2r) # C++ needed to build my project 

# Define a list of valid targets
set(VALID_TARGETS "tbb" "cuda")

# Option to choose which target to build
set(BUILD_TARGET "tbb" CACHE STRING "Choose the target to build :${VALID_TARGETS})")

# Set the executable name based on the chosen target
set(EXECUTABLE_NAME "p2r_${BUILD_TARGET}")

# Set p2r options
set(NITER "5" CACHE STRING "number of iteration for p2r")

set(CUDA_ARCH "80" CACHE STRING "CUDA arch")

# Validate the chosen target
set_property(CACHE BUILD_TARGET PROPERTY STRINGS ${VALID_TARGETS})

# Add source directories based on the chosen target
if(BUILD_TARGET IN_LIST VALID_TARGETS)
    add_subdirectory(p2r_${BUILD_TARGET})
else()
    message(FATAL_ERROR "Invalid value for BUILD_TARGET. Please choose one of: ${VALID_TARGETS}")
endif()



