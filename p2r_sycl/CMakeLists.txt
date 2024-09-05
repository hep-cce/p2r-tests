# Set the project name for target
project(p2r_sycl)

set(CUDA_PATH "" CACHE STRING "path to CUDA")
set(SYCL_PATH "" CACHE STRING "path to CLANG")

# Set the compiler to nvc++
set(CLANG ${SYCL_PATH}clang++)
set(CMAKE_C_COMPILER ${CLANG}) 
set(CMAKE_CXX_COMPILER ${CLANG})

set(TARGET_SOURCES
   propagate-tor-test_sycl.cpp
)

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add the executable for target2
add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

#set compiler options for CUDA
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --cuda-path=${CUDA_PATH}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsycl")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsycl-targets=nvptx64-nvidia-cuda")

# Pass the NITER value to the source code
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")
