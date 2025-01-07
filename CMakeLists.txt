cmake_minimum_required(VERSION 3.22)

project(p2r) # C++ needed to build my project 

# Define a list of valid targets
set(VALID_TARGETS "tbb" "cuda" "alpaka" "hip" "kokkos" "stdpar" "sycl")

# Define a list of valid backends 
set(VALID_BACKENDS "nvidia" "amd" "cpu" "intel")

# Option to choose which target to build
set(BUILD_TARGET "tbb" CACHE STRING "Choose the target to build :${VALID_TARGETS})")

# Option to choose which backend build
set(BACKEND "nvidia" CACHE STRING "Choose the backend to build :${VALID_BACKENDS}. Note: some backends may not be supported by the target.)")

# Set the executable name based on the chosen target
set(EXECUTABLE_NAME "p2r_${BUILD_TARGET}")


# Set p2r options
set(NITER "5" CACHE STRING "number of iteration for p2r")
set(bsize "32" CACHE STRING "Size of AOSOA for p2r")
set(nevts "100" CACHE STRING "Number of events")
set(ntrks "8192" CACHE STRING "Number of tracks")
set(nthreads "96" CACHE STRING "Number of threads used for TBB CPU implementation")

# Validate the chosen target
set_property(CACHE BUILD_TARGET PROPERTY STRINGS ${VALID_TARGETS})

# Add source directories based on the chosen target
if(BUILD_TARGET IN_LIST VALID_TARGETS)
    add_subdirectory(p2r_${BUILD_TARGET})
else()
    message(FATAL_ERROR "Invalid value for BUILD_TARGET. Please choose one of: ${VALID_TARGETS}")
endif()
