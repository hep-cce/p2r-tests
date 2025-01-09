# p2r-tests

 `p2r` is a test code taken from a HEP tracking algorithm to compare the performance and experience of implementing different portability solutions.

## Table of Contents

- [Installation with CMAKE](#installation-with-CMAKE)
  - [p2r run parameters](#p2r-run-parameters)
  - [NVIDIA backends](#NVIDIA-backends)
  - [HIP(AMD) backends](#HIP-backends)
  - [CPU backends](#CPU-backends) 
- [Installation with spack](#installation-with-spack)
  - [External packages](#External-packages) 
  - [Installation commands](#Installation-commands) 
- [Citing p2r](#Citing-p2r)

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

 - `NITER` "5"  Number of iteration for p2r
 - `bsize` "32"  Size of AOSOA for p2r
 - `nevts` "100"  Number of events
 - `ntrks` "8192" Number of tracks
 - `nthreads` "96"  Number of threads used for TBB CPU implementation only

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
### HIP backends

   Current HIP backends are tested for AMD hardwares only. 

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
 - Kokkos implementation (via OpenMP)
```
 cmake ../ -DBUILD_TARGET=kokkos -DKokkos_ENABLE_OPENMP=ON -DCMAKE_CXX_STANDARD=17 -DCMAKE_CXX_COMPILER=g++ -Dkokkos-threads=32
```
 - Alpaka Implementation (via TBB)
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

 - Getting spack: (from a private fork before p2r is integrated in official spack) 

```
git clone -c feature.manyFiles=true --depth=2 https://github.com/kakwok/spack.git 
```

 - Set-up the environment:
```
. spack/share/spack/setup-env.sh  #For bash
```

   For details, see the official [spack documentation](https://spack.readthedocs.io/en/latest/getting_started.html)
    
### External packages

 - To avoid installing full stack of software dependencies, you may specify the location of the already-installed packages in your system (e.g. on an HPC machine). 
   These are called external packages.

 - The list of external packages are kept in this yaml file: `~/.spack/packages.yaml`
 
 - Examples of external packages used by `p2r`
```
packages:
  cuda:
    buildable: false
    externals:
    - spec: cuda@11.6.2
      prefix: /soft/compilers/cuda/cuda-11.6.2
  nvhpc:
    buildable: false
    externals:
    - spec: nvhpc@22.7
      prefix: /soft/compilers/nvhpc/Linux_x86_64/22.7
  hip:
    buildable: false
    externals:
    - spec: hip@5.6.1
      prefix: /soft/compilers/rocm/rocm-5.6.1
  intel-tbb:
    buildable: false
    externals:
    - spec: intel-tbb@2021.12.0
      prefix: /soft/compilers/oneapi/2024.04.15.001/oneapi/tbb/2021.12
```
 - The corresponding compilers are specified in the yaml file : `~/.spack/linux/compilers.yaml`
```
compilers:
- compiler:
    spec: gcc@=9.2.0
    paths:
      cc: /soft/compilers/gcc/9.2.0/linux-rhel7-x86_64/bin/gcc
      cxx: /soft/compilers/gcc/9.2.0/linux-rhel7-x86_64/bin/g++
      f77: /soft/compilers/gcc/9.2.0/linux-rhel7-x86_64/bin/gfortran
      fc: /soft/compilers/gcc/9.2.0/linux-rhel7-x86_64/bin/gfortran
    flags: {}
    operating_system: opensuse15
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
- compiler:
    spec: nvhpc@=22.7
    paths:
      cc: /soft/compilers/nvhpc/Linux_x86_64/22.7/compilers/bin/nvc
      cxx: /soft/compilers/nvhpc/Linux_x86_64/22.7/compilers/bin/nvc++
      f77: /soft/compilers/nvhpc/Linux_x86_64/22.7/compilers/bin/nvfortran
      fc:  /soft/compilers/nvhpc/Linux_x86_64/22.7/compilers/bin/nvfortran
    flags: {}
    operating_system: opensuse15
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
```
### Installation commands

 - With `spack`, the CMAKE options for `p2r` are pre-set to correct values for different implementations and backends. 
 - Installation commands are more uniform.
 - `kokkos` implementation is installed as a sub-module, please use `p2r-tests@kokkos` for all `p2r-kokkos` implementation, otherwise, use `p2r-tests@main`.
 - Note: Need to specify `gcc` versions for kokkos implementation by adding `%gcc@9.2.0`
 - Note: Need to specify compiler for `stdpar` by adding `%nvhpc@22.7`
 
#### NVIDIA backends

Use `cuda-arch` to specify the architecture. Example command

```
spack install p2r-tests@[main|kokkos] impl=[cuda|kokkos|alpaka|stdpar|sycl] backend=nvidia cuda-arch=80
```

### AMD backends

Use `hip-arch` to specify the architecture. Example command:

```
spack install p2r-tests@[main|kokkos] impl=[hip|kokkos|alpaka] backend=amd hip-arch=gfx908
```

### CPU backends:
```
spack install p2r-tests@[main|kokkos] impl=[tbb|kokkos|alpaka|stdpar|sycl] backend=cpu 
```

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
