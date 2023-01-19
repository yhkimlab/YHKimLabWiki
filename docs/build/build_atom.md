Buiding ATOM
===============================
## Contents
1. Prerequisites
2. Compiling `xmlf90` and `libGridXC`
3. Compiling `ATOM`

## Prerequisites

`ATOM` 프로그램을 통해 `SIESTA`에 이용되는 원자의 `psf` 파일을 만들 수 있다. 그 외에도 `ATOM`은 다음과 같은 목적에 이용된다.  
- 특정 전자 배치에 대한 All-electron DFT (density functional theory) 계산 수행  
- ab-initio pseudopotentials 생성  
- 만들어진 pseudopotential를 통해 원자핵이 미치는 효과 계산  
`ATOM`를 설치하기 앞서 다음과 같은 패키지를 준비해야한다.  

`xmlf90` : <https://launchpad.net/xmlf90/+download> (1.5.0. 버전)

`libGridXC` : <https://launchpad.net/libgridxc/+download> (0.7.3 버전)

리눅스 환경에 다운로드한 후 압축을 풀어주는 명령어는 다음과 같다.

```bash
$ wget https://launchpad.net/xmlf90/trunk/1.5/+download/xmlf90-1.5.4.tar.gz // 1.5.4버전
$ wget https://launchpad.net/libgridxc/trunk/0.7/+download/libgridxc-0.7.6.tgz // 0.7.6버전
$ tar xvzf xmlf90-1.5.0.tgz
$ tar xvzf libgridxc-0.7.3.tgz
```


## Compiling `xmlf90` and `libGridXC`

압축을 풀어준 위치에서 다음과 같은 과정을 통해 컴파일을 진행한다.

`xmlf90` :

```bash
$ cd xmlf90-1.5.0
$ mkdir Gfortran
$ cd Sys
$ cp gfortran.make ../Gfortran/fortran.mk
```

라이브러리를 생성하기 전에 fortran.mk을 다음과 같이 수정해준다.

```bash  
LDFLAGS=-mkl=cluster
AR=/usr/bin/ar
```

이후 make명령어로 라이브러리를 빌드해준다.

```bash  
$ cd ../Gfortran
$ sh ../config.sh
$ make
```
`xmlf90.mk` 생성확인

`libgridxc` :

```bash
(설치한 위치로 돌아와서)
$ cd libgridxc-0.7.3
$ mkdir Gfortran
$ cd Gfortran
$ cp ../extra/fortran.mk .
$ sh ../src/config.sh
$ make clean
$ make
```

마찬가지로 make를 하기 전 fortran.mk을 다음과 같이 수정해준다.

```bash  
LDFLAGS=-mkl=cluster
AR=/usr/bin/ar
```

`gridxc.mk` 생성확인

## Compiling `ATOM`

`ATOM`를 위한 라이브러리가 준비되었으니 이제 `ATOM`을 설치한다.  
`ATOM` : <https://departments.icmab.es/leem/SIESTA_MATERIAL/Pseudos/Code/downloads.html> (4.2.7 버전)  
리눅스 환경에 설치하고 다음과 같은 커맨드로 압축을 풀어준다.  
`ATOM` :
```bash
$ tar xvzf atom-4.2.7-100.gz
```
`ATOM`도 마찬가지로 컴파일을 해야 한다. 압축을 풀어준 위치에서 컴파일을 진행한다.

`ATOM` :
```bash
$ cd atom-4.2.7-100
$ cp arch.make.sample arch.make
$ vi arch.make
(파일이 열리면 아래 부분에 ROOT를 수정한다)
XMLF90_ROOT= <설치한 xmlf90 위치>/xmlf90-1.5.0/Gfortran
GRIDXC_ROOT= <설치한 libgridxc 위치>/libgridxc-0.8.5/Gfortran
include $(XMLF90_ROOT)/xmlf90.mk
include $(GRIDXC_ROOT)/gridxc.mk
$ make
```
`ATOM` 프로그램이 준비되었다.
