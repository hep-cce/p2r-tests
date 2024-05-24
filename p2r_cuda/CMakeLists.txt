enable_language(CUDA)

# Add source files 
set(TARGET_SOURCES
    propagate-tor-test_cuda_uvm.cu 
)

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")

# Add executable 
find_package(CUDA)
cuda_add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES}
                    OPTIONS --expt-relaxed-constexpr
                    --extended-lambda
                    -O3
                    --default-stream per-thread -std=c++17
                    -DNITER=${NITER}
)

#add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})
##set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNITER=${NITER}")
#
#target_compile_options(${EXECUTABLE_NAME} INTERFACE
#    "$<$<AND:$<COMPILE_LANGUAGE:CUDA>,$<CUDA_COMPILER_ID:NVIDIA>>:--expt-relaxed-constexpr>"
#)
#set(CMAKE_NVCC_FLAGS "${CMAKE_NVCC_FLAGS} --expt-relaxed-constexpr --extended-lambda -O3 --default-stream per-thread -std=c++17")
#
#
## Set the output name for the executable
#set_target_properties(${EXECUTABLE_NAME} PROPERTIES OUTPUT_NAME ${EXECUTABLE_NAME})

#set_property(TARGET ${EXECUTABLE_NAME} PROPERTY CUDA_ARCHITECTURES ${CUDA_ARCH})
set(CMAKE_CUDA_ARCHITECTURES 80)
