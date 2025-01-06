# Set the project name for target
project(p2r_stdpar)

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set the compiler to nvc++
set(CMAKE_C_COMPILER nvc++)
set(CMAKE_CXX_COMPILER nvc++)

set(TARGET_SOURCES
   propagate-tor-test_pstl.cpp 
)
# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add the executable for target2
add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

#set compiler options for CUDA
if(BACKEND STREQUAL "nvidia") 
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdpar=gpu")
    set(nvcc_CUDA_ARCH "cc${CUDA_ARCH}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=${nvcc_CUDA_ARCH}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=cuda11.7")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=managed")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=fma")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=fastmath")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=autocollapse")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=loadcache:L1")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -gpu=unroll")
elseif(BACKEND STREQUAL "cpu") 
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdpar=multicore")
endif()

# Pass the NITER value to the source code
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")

install(TARGETS p2r_stdpar
    RUNTIME DESTINATION bin
)
