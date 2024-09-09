cmake_minimum_required(VERSION 3.12)
project(p2r_kokkos CXX) # C++ needed to build my project 
#find_package(Kokkos REQUIRED) # fail if Kokkos not found

# Set the C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#Find Kokkos
add_subdirectory(kokkos)

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

set(TARGET_SOURCES
    propagate-tor-test_kokkos_local_tvr.cpp
)

# Pass the NITER value to the source code
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE NITER=${NITER})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE bsize=${bsize})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE nevts=${nevts})
add_compile_definitions(${EXECUTABLE_NAME} PRIVATE ntrks=${ntrks})

add_executable(${EXECUTABLE_NAME} ${TARGET_SOURCES})

message(TARGET_SOURCES="${TARGET_SOURCES}")
message(EXECUTABLE_NAME="${EXECUTABLE_NAME}")
message(BUILD_TARGET="${BUILD_TARGET}")
message(NITER="${NITER}")

#add_compile_options(-maxrregcount=92)
add_compile_options(-maxrregcount=83)
#add_compile_options(--lineinfo)
#add_compile_options(-ftree-vectorizer-verbose=6)
#add_compile_options(-fopenmp-simd)
add_compile_options(-ffast-math)
add_compile_options(-march=native)
add_compile_options(-O3)

set(CMAKE_BUILD_TYPE Debug)

target_link_libraries(p2r_kokkos Kokkos::kokkos)             ## JLSE build

install(TARGETS p2r_kokkos
    RUNTIME DESTINATION bin
)
# build my executable from the specified source code
# Add the executable for target2
#add_executable(p2r_kokkos "./src/propagate-tor-test_kokkos_local_tvr.cpp")
#add_executable(p2r_kokkos "./src/propagate-tor-test_kokkos.cpp")
#add_executable(p2r_kokkos "./src/propagate-tor-test_kokkos_local.cpp")
#add_executable(p2r_kokkos "./src/propagate-tor-test_kokkos_local_tempBsize_tvr.cpp")
#add_executable(p2r_kokkos "./src/propagate-tor-test_kokkos_local_tempBsize_notvr.cpp")

# declare dependency on Kokkos, build p2r together with Kokkos, inheriting all the kokkos flags
#target_link_libraries(p2r_kokkos PRIVATE Kokkos::kokkos)    ## standalone build
#target_link_libraries(p2r_kokkos Kokkos::kokkos)             ## JLSE build
