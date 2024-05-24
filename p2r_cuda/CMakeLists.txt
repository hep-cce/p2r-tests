# Enable CUDA language
enable_language(CUDA)

# Set the project name for target2
project(p2r_cuda)

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(TARGET_SOURCES
    propagate-tor-test_cuda_uvm.cu 
)
set(CUDA_ARCH "80" CACHE STRING "CUDA architecture version")
set(CMAKE_CUDA_ARCHITECTURES ${CUDA_ARCH})

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add the executable for target2
add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

# Specify the CUDA compiler options
target_compile_options(${EXECUTABLE_NAME} PRIVATE
    $<$<COMPILE_LANGUAGE:CUDA>:--expt-relaxed-constexpr>
    $<$<COMPILE_LANGUAGE:CUDA>:--extended-lambda>
    $<$<COMPILE_LANGUAGE:CUDA>:-O3>
    $<$<COMPILE_LANGUAGE:CUDA>:--default-stream per-thread>
)

# Pass the NITER value to the source code
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${nevts})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${ntrks})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")
