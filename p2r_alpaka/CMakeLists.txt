# Required CMake version.

cmake_minimum_required(VERSION 3.15)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

################################################################################
# Project.

set(_TARGET_NAME p2r_alpaka)
set(TARGET_SOURCES src/propagate-tor-test_alpaka_local.cpp)
#    src/propagate-tor-test_alpaka_local_sycl.cpp)
#    src/propagate-tor-test_alpaka.cpp)

project(p2r_alpaka)

#-------------------------------------------------------------------------------
# Find alpaka.

find_package(alpaka REQUIRED)

#-------------------------------------------------------------------------------
# Set common var

set(alpaka_CXX_STANDARD 17)
#-------------------------------------------------------------------------------
# Add executable.
add_compile_definitions(EXCLUDE_H2D_TRANSFER=1)
add_compile_definitions(EXCLUDE_D2H_TRANSFER=1)
# Pass the NITER value to the source code
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})

if(alpaka_ACC_GPU_CUDA_ENABLE)
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE elementsperthread=1)
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE threadsperblock=${bsize})
    #set(CMAKE_CUDA_ARCHITECTURES 70)
    #add_compile_definitions(num_streams=1)
    #set(CMAKE_BUILD_TYPE Debug)
    #set(CMAKE_BUILD_TYPE RelWithDebInfo)
    add_compile_options(-std=c++17)
    add_compile_options(-maxrregcount=64)
    add_compile_options(--use_fast_math)
##HIP flags
elseif (alpaka_ACC_GPU_HIP_ENABLE)
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE elementsperthread=1)
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE threadsperblock=${bsize})
    add_compile_options(-std=c++17)
    add_compile_options(-ffast-math)
    add_compile_options(-O3)
##CPU flags
elseif (Dalpaka_ACC_CPU_B_TBB_T_SEQ_ENABLE)
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE elementsperthread=${bsize})
    add_compile_definitions(${EXECUTABLE_NAME} PRIVATE threadsperblock=1)
    add_compile_options(-ffast-math)
    add_compile_options(-march=native)
    add_compile_options(-O3)
    #add_compile_options(-fopt-info-vec-missed)
    add_compile_options(-fopenmp-simd)
endif()

alpaka_add_executable(
    ${EXECUTABLE_NAME}
    ${TARGET_SOURCES}
)


message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")


target_link_libraries(
    ${_TARGET_NAME}
    PUBLIC alpaka::alpaka
)

install(TARGETS p2r_alpaka
    RUNTIME DESTINATION bin
)
