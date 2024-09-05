rm -r build/*
cd build
# CUDA - OK!
#cmake ../ -DBUILD_TARGET=cuda -DNITER=10 -DCUDA_ARCH=80

# HIP CUDA - OK?
#cmake ../ -DBUILD_TARGET=hip -DNITER=10 -DHIP_ARCH=gfx908

## Alpaka CUDA - OK!
#cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=~/PPS/p2r-tests/alpaka/install/\
#       -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_CUDA_COMPILER=nvcc\
#       -Dalpaka_ACC_GPU_CUDA_ENABLE=on -DCMAKE_CUDA_ARCHITECTURES=80\
#       -Delementsperthread=1 -Dthreadsperblock=32\
#       -DNITER=1 -Dnevts=10

# Kokkos CUDA - OK! 
#Kokkos_source="/home/kkwok/PPS/p2r-tests/kokkos"
#cmake ../ -DBUILD_TARGET=kokkos -DCMAKE_CXX_COMPILER=$Kokkos_source/bin/nvcc_wrapper -DCMAKE_CXX_FLAGS="-lineinfo"\
#        -DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_CONSTEXPR=On -DKokkos_ENABLE_CUDA_LAMBDA=On  -DKokkos_ARCH_AMPERE80=On

# stdpar CUDA - OK build 
#cmake ../ -DBUILD_TARGET=stdpar -DNITER=1 -DCUDA_ARCH=80

# sycl CUDA - OK 
cmake ../ -DBUILD_TARGET=sycl -DNITER=1 -DCUDA_ARCH=80 -DCUDA_PATH="/soft/compilers/cuda/cuda-11.6.2/" -DSYCL_PATH="/home/kkwok/sycl_workspace/llvm/build/bin/"

make VERBOSE=1
cd ../
