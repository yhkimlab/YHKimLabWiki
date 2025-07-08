모든-전자 계산
===============================
## Contents
1. 모든-전자 계산

## 1. 모든-전자 계산


이번 장에서는 원자에 대해 밀도범함수론(density functional theory) 기반의 **모든-전자(all-electron) 계산**을 하는 법을 다룬다. 우선, `ATOM`이 설치된 위치에서 `/Tutorial/All_electron/`에 위치한 다음 파일을 살펴보자:

`Si.ae.inp`:  

```bash
ae Si Ground state all-electron	# 계산 종류 (ae : All-electron) / 시스템 이름
   Si   ca			            # 원소기호 / Exchange correlation 종류 (ca : non-realistic)
       0.0
    3    2			            # 핵(core) 오비탈 (1s, 2s, 2p) / 원자가(valence) 오비탈 (3s, 3p)
    3    0      2.00		    # 주 양자수(n) / 방위 양자수(l) / 전자 수
    3    1      2.00

12345678901234567890123456789012345678901234567890      Ruler
```

전체-전자 계산을 수행하기 위해서는 `/Tutorial/Utils/` 위치에 있는 `ATOM` 프로그램에 대한 쉘 스크립트를 사용해야한다. 다음과 같은 명령어로 계산을 수행한다.  

```bash
$ sh ../Utils/ae.sh si.ae.inp
=> si.ae 폴더 생성
```

생성된 `si.ae` 위치에 가면 다음과 같은 결과 파일들이 생성되어 있다:

- `INP`: 계산에 사용된 입력 파일 사본

- `OUT`: 계산 결과 정보를 담은 출력 파일

- `AECHARGE`: 전자 밀도(**4πr²**를 곱한 형태)
  - 1열: 반지름 `r`  
  - 2/3열: total charge의 up/down 성분  
  - 4열: core charge의 총합 (**4πr²**를 곱한 형태)

- `CHARGE`: `AECHARGE`와 동일

- `RHO`: 전자 밀도(**4πr²**를 곱셈 X)

- `AEWFNR0` ~ `AEWFNR3`  
  - 원자가 전자에 대한 온전자 파동함수
  - `AEWFNR0`: s 오비탈  
  - `AEWFNR1`: p 오비탈  
  - `AEWFNR2`: d 오비탈  
  - `AEWFNR3`: f 오비탈  


`OUTPUT` 파일을 살펴보면 다음과 같은 계산 결과 정보를 알수 있다:


**오비탈 고유값**:  
```
 O  output data for orbitals
 ----------------------------

 nl    s      occ         eigenvalue    kinetic energy      pot energy

 1s   0.5    2.0000     -37.38043698       0.00000000    -121.94707005
 2s   0.5    2.0000      -1.22878700       0.00000000     -19.62006430  &v
 2p  -0.5    1.6667      -0.19348921       0.00000000     -15.84881200  &v
 2p   0.5    3.3333      -0.19126456       0.00000000     -15.80651303  &v
---------------------------- &v
```

**전체 에너지**:  
```
 total energies
 --------------

 sum of eigenvalues        =      -78.17847848
 kinetic energy from ek    =        0.00000000
 el-ion interaction energy =     -362.23733215
 el-el  interaction energy =       80.06698735
 vxc    correction         =      -21.19720455
 virial correction         =        0.84352124
 exchange + corr energy    =      -16.10878372
 kinetic energy from ev    =      145.12208352
 potential energy          =     -298.27912853
 ---------------------------------------------
 total energy              =     -153.15704500
```

또한 `gnuplot`를 사용하여 계산 결과를 시각할 수 있다. `.gplot`, `.gps` 형식 파일은 이를 위한 파일들이다. 해당 명령어를 통해서 원자가 전자의 파동함수를 시각화해보자:

```bash
$ gnuplot -persist ae.gplot //gplot 파일들을 불러오면 다양한 그래프들을 볼 수 있다.
```

> 오비탈 파동함수의 노드(node) 수가 n-l-1를 만족하는지 확인해보자

- `charge`: Charge density (separated core and valence contributions)
- `vcharge`: Valence charge density (same normalization).
- `ae`: Orbital valence wavefunctions (radial part multiplied by r)