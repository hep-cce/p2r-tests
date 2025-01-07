project(p2r_tbb LANGUAGES CXX)

# Add source files 
set(TARGET_SOURCES
   propagate-tor-test_tbb.cpp
)
# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add executable 
add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Tbb options
target_compile_options(${EXECUTABLE_NAME} PRIVATE -O3 -fopenmp -ffast-math -march=native)
#add_compile_options(-O3 -fopenmp -ffast-math -march=native)

# Pass the NITER value to the source code
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE nthreads=${nthreads})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")

# Find the TBB library
find_package(TBB REQUIRED)

# Link TBB library
target_link_libraries(${EXECUTABLE_NAME} PRIVATE TBB::tbb)

install(TARGETS p2r_tbb
    RUNTIME DESTINATION bin
)
