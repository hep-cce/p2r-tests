rm -r build/*
cd build
# CUDA - OK!
#cmake ../ -DBUILD_TARGET=cuda -DNITER=10 -DCUDA_ARCH=80

## Alpaka CUDA - OK!
#cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=~/PPS/p2r-tests/alpaka/install/\
#       -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_CUDA_COMPILER=nvcc\
#       -Dalpaka_ACC_GPU_CUDA_ENABLE=on -DCMAKE_CUDA_ARCHITECTURES=80\
#       -Delementsperthread=1 -Dthreadsperblock=32\
#       -DNITER=1 -Dnevts=10

# Kokkos CUDA - OK! 
#Kokkos_source="/home/kkwok/PPS/p2r-tests/kokkos"
#cmake ../ -DBUILD_TARGET=kokkos -DCMAKE_CXX_COMPILER=$PWD/../kokkos/bin/nvcc_wrapper -DCMAKE_CXX_FLAGS="-lineinfo"\
#           -DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_CONSTEXPR=On -DKokkos_ENABLE_CUDA_LAMBDA=On  -DKokkos_ARCH_AMPERE80=On
#cmake ../ -DBUILD_TARGET=kokkos -DCMAKE_CXX_FLAGS="-lineinfo" -DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_CONSTEXPR=On -DKokkos_ENABLE_CUDA_LAMBDA=On  -DKokkos_ARCH_AMPERE80=On

# stdpar CUDA - OK build 
#cmake ../ -DBUILD_TARGET=stdpar -DNITER=1 -DCUDA_ARCH=80

# sycl CUDA - OK 
#cmake ../ -DBUILD_TARGET=sycl -DNITER=1 -DCUDA_ARCH=80 -DCUDA_PATH="/soft/compilers/cuda/cuda-11.6.2/" -DSYCL_PATH="/home/kkwok/sycl_workspace/llvm/build/bin/"


# HIP AMD - OK!
#cmake ../ -DBUILD_TARGET=hip -DNITER=10 -DHIP_ARCH=gfx908

## Alpaka HIP - weird bug 
#cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=~/PPS/p2r-tests/alpaka/install/\
#       -DCMAKE_CXX_COMPILER=hipcc -Dalpaka_CXX_STANDARD=17\
#       -Dalpaka_ACC_GPU_HIP_ENABLE=ON -DCMAKE_HIP_ARCHITECTURES=gfx908\
#       -Delementsperthread=1 -Dthreadsperblock=32\
#       -DNITER=1 -Dnevts=10

## Kokkos HIP - OK! 
#cmake ../ -DBUILD_TARGET=kokkos -DCMAKE_CXX_COMPILER=/soft/compilers/rocm/rocm-5.6.1/hip/bin/hipcc\
#          -DKokkos_ENABLE_HIP=ON -DKokkos_ARCH_VEGA908=On -DCMAKE_CXX_STANDARD=17

# sycl HIP - need to rebuild compiler for 5.6.1 
#cmake ../ -DBUILD_TARGET=sycl -DBACKEND=amd -DNITER=1 -DHIP_ARCH=gfx908  -DSYCL_PATH="/home/kkwok/sycl_workspace/llvm/build_hip/bin/"


## TBB CPU - OK!
#cmake ../ -DBUILD_TARGET=tbb -DNITER=10 -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc

## Kokkos CPU - OK! 
#cmake ../ -DBUILD_TARGET=kokkos -DKokkos_ENABLE_OPENMP=ON -DCMAKE_CXX_STANDARD=17 -DCMAKE_CXX_COMPILER=g++ -Dkokkos-threads=32 

## Alpaka CPU - OK! 
#cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=~/PPS/p2r-tests/alpaka/install/\
#       -DCMAKE_CXX_COMPILER=g++ -Dalpaka_CXX_STANDARD=17\
#       -Dalpaka_ACC_CPU_B_TBB_T_SEQ_ENABLE=ON\
#       -Delementsperthread=1 -Dthreadsperblock=32

## stdpar CPU - OK! 
#cmake ../ -DBUILD_TARGET=stdpar -DBACKEND=cpu -DNITER=5 

## SYCL CPU - OK!
#cmake ../ -DBUILD_TARGET=sycl -DBACKEND=cpu -DNITER=1 

make VERBOSE=1
cd ../
