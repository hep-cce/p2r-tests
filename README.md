# p2r-tests

 `p2r` is a test code taken from a HEP tracking algorithm to compare the performance and experience of implementing different portability solutions.

## Table of Contents

- [Installation with CMAKE](#installation-with-CMAKE)
  - [p2r run parameters](#p2r-run-parameters)
  - [NVIDIA backends](#NVIDIA-backends)
  - [HIP(AMD) backends](#HIP(AMD)-backends)
  - [CPU backends](CPU-backends) 
- [Installation with spack](#installation-with-spack)
- [Citing p2r](#Citing p2r)

## Installation with CMAKE
```
git clone https://github.com/kakwok/p2r-tests.git
cd p2r-tests
mkdir build && cd build
cmake ../ -DBUILD_TARGET=[tbb|cuda|alpaka|hip|kokkos|stdpar|sycl] -DBACKEND=[nvidia|amd|cpu] ## See below for examples in each combination
make VERBOSE=1
cd ../
```
### p2r run parameters
You can set the following run parameters for each of the implementations:

 - `NITER` "5"  "number of iteration for p2r
 - `bsize` "32"  "Size of AOSOA for p2r
 - `nevts` "100"  "Number of events
 - `ntrks` "8192" "Number of tracks
 - `nthreads` "96"  "Number of threads used for TBB CPU implementation

Notes: 
 - `ntrks*nevts` needs to be divisible by `bsize`.
 - `bsize` can significantly impact performance.
 - To increase the program length, increase the value of `NITER`.

### NVIDIA backends

 - CUDA Implementation  
   ```
   cmake ../ -DBUILD_TARGET=cuda -DCUDA_ARCH=80 
   ```
 - Kokkos Implementation 
   ```
    cmake ../ -DBUILD_TARGET=kokkos -DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_CONSTEXPR=On -DKokkos_ENABLE_CUDA_LAMBDA=On  -DKokkos_ARCH_AMPERE80=On
   ```
 - Alpaka Implementation 
   ```
    cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=path_to_alpaka/\
              -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_CUDA_COMPILER=nvcc\
              -Dalpaka_ACC_GPU_CUDA_ENABLE=on -DCMAKE_CUDA_ARCHITECTURES=80
   ```
 - stdpar Implementation 
   ```
   cmake ../ -DBUILD_TARGET=stdpar -DNITER=1 -DCUDA_ARCH=80
    ```
 - SYCL Implementation 
   ```
   cmake ../ -DBUILD_TARGET=sycl -DNITER=1 -DCUDA_ARCH=80\
            -DCUDA_PATH=path_to_cuda\
            -DSYCL_PATH=path_to_sycl
   ```
### HIP(AMD) backends

 - HIP Implementation 
   ```
   cmake ../ -DBUILD_TARGET=hip -DHIP_ARCH=gfx908
   ```
 - Kokkos Implementation
   ```
    cmake ../ -DBUILD_TARGET=kokkos -DCMAKE_CXX_COMPILER=path_to_hipcc\
              -DKokkos_ENABLE_HIP=ON -DKokkos_ARCH_VEGA908=On -DCMAKE_CXX_STANDARD=17
   ``` 
 - Alpaka Implementation
   Note: Builds OK for Alpaka v1.2.0 and rocm/5.6.1, but have runtime problem on MI-100
   ```
    cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=path_to_alpaka/\
              -DCMAKE_CXX_COMPILER=hipcc \
              -Dalpaka_ACC_GPU_HIP_ENABLE=ON -DCMAKE_HIP_ARCHITECTURES=gfx908\ 
   ```
### CPU backends

 - TBB implementation
```
cmake ../ -DBUILD_TARGET=tbb -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -Dnthreads=96
```
 - Kokkos implementation
```
 cmake ../ -DBUILD_TARGET=kokkos -DKokkos_ENABLE_OPENMP=ON -DCMAKE_CXX_STANDARD=17 -DCMAKE_CXX_COMPILER=g++ -Dkokkos-threads=32
```
 - Alpaka Implementation
```
 cmake ../ -DBUILD_TARGET=alpaka -DCMAKE_BUILD_TYPE=Release -Dalpaka_ROOT=path_to_alpaka\
       -DCMAKE_CXX_COMPILER=g++ -Dalpaka_CXX_STANDARD=17\
       -Dalpaka_ACC_CPU_B_TBB_T_SEQ_ENABLE=ON\
```
 - stdpar implementation
```
cmake ../ -DBUILD_TARGET=stdpar -DBACKEND=cpu
```
 - SYCL implementation
```
cmake ../ -DBUILD_TARGET=sycl -DBACKEND=cpu
```
## Installation from spack 

### Getting spack
### External packages
### Installation commands

## Citing p2r

The results of `p2r` together with the sister project `p2z` is published in the following article:
```
@article{10.3389/fdata.2024.1485344,
    author={Ather, Hammad  and Berkman, Sophie  and Cerati, Giuseppe  and Kortelainen, Matti J.  and Kwok, Ka Hei Martin  and Lantz, Steven  and Lee, Seyong  and Norris, Boyana  and Reid, Michael  and Reinsvold Hall, Allison  and Riley, Daniel  and Strelchenko, Alexei  and Wang, Cong },
    title={Exploring code portability solutions for HEP with a particle tracking test code},
    journal={Frontiers in Big Data},
    volume={7},
    year={2024},
    url={https://www.frontiersin.org/journals/big-data/articles/10.3389/fdata.2024.1485344},
    doi={10.3389/fdata.2024.1485344},
    issn={2624-909X}
}
```
