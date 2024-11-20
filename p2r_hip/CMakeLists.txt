# Enable CUDA language
enable_language(HIP)

# Set the project name for target2
#project(p2r_hip LANGUAGES CXX HIP)
project(p2r_hip LANGUAGES HIP)

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set the HIP compiler to hipcc
set(CMAKE_C_COMPILER hipcc)
set(CMAKE_CXX_COMPILER hipcc)
set(CMAKE_HIP_COMPILER hipcc)

set(TARGET_SOURCES
    propagate-tor-test_hip_local_uvm.hip
)
set(HIP_ARCH "gfx908" CACHE STRING "HIP architecture version")
set(CMAKE_HIP_PLATFORM "nvidia" CACHE STRING "HIP platform: nvidia/amd")
set(CMAKE_HIP_ARCHITECTURES ${HIP_ARCH})

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add the executable for target2
add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

set_property(TARGET ${EXECUTABLE_NAME} PROPERTY HIP_ARCHITECTURES ${HIP_ARCH})

# set linker language
set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINKER_LANGUAGE HIP)
set_target_properties(${EXECUTABLE_NAME} PROPERTIES HIP_STANDARD 17)

# Pass the NITER value to the source code
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
target_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")

install(TARGETS p2r_hip
    RUNTIME DESTINATION bin
)
