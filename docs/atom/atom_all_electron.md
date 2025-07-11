전(全)전자 계산
===============================
## Contents
1. 전(全)전자 계산

---
## 1. 전전자 계산

이번 장에서는 원자에 대해 밀도범함수론(density functional theory) 기반의 **전전자(all-electron) 계산** 방법을 다룬다. 전반적인 `ATOM`에 프로그램 사용에 대한 자세한 설명 및 메뉴얼은 다음 링크를 참조한다.  

- `ATOM` user manual: <https://siesta-project.org/SIESTA_MATERIAL/Pseudos/Code/atom-4.2.0.pdf>  
- Wiki webpage: <https://docs.siesta-project.org/projects/atom/en/latest/tutorial/index.html>  
  

우선, `ATOM`이 설치된 위치에서 `/Tutorial/All_electron/`에 위치한 다음 파일을 살펴보자:

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

• `INP`: 계산에 사용된 입력 파일 사본  
• `OUT`: 계산 결과 정보를 담은 출력 파일  
• `AECHARGE`: 전자 밀도(multiplied by 4πr²)  
• `CHARGE`: `AECHARGE`와 동일  
• `RHO`: 전자 밀도
• `AEWFNR0` ~ `AEWFNR3`: 원자가 전자에 대한 온전자 파동함수(s, p, d, f 오비탈 순)
  


`OUT` 파일을 살펴보면 다음과 같은 계산 결과 정보를 알수 있다:  


**오비탈 고유값**:  
```
Si output data for orbitals
 ----------------------------

 nl    s      occ         eigenvalue    kinetic energy      pot energy

 1s   0.0    2.0000    -130.36911240     183.01377616    -378.73491463
 2s   0.0    2.0000     -10.14892694      25.89954259     -71.62102169
 2p   0.0    6.0000      -7.02876268      24.42537874     -68.74331203
 3s   0.0    2.0000      -0.79662742       3.23745215     -17.68692611  &v
 3p   0.0    2.0000      -0.30705179       2.06135782     -13.62572515  &v
 ---------------------------- &v
```

**전체 에너지**:  
```
 total energies
 --------------

 sum of eigenvalues        =     -325.41601319
 kinetic energy from ek    =      574.97652987
 el-ion interaction energy =    -1375.79704736
 el-el  interaction energy =      263.53000478
 vxc    correction         =      -51.65548902
 virial correction         =        1.40722950
 exchange + corr energy    =      -39.09342414
 kinetic energy from ev    =      574.97651364
 potential energy          =    -1151.36046672
 ---------------------------------------------
 total energy              =     -576.38395308
```

또한 `gnuplot`를 사용하여 계산 결과를 시각할 수 있다. `.gplot`, `.gps` 형식 파일은 이를 위한 파일들이다. 해당 명령어를 통해서 원자가 전자의 파동함수를 시각화해보자:  

```bash
$ gnuplot -persist ae.gplot //gplot 파일들을 불러오면 다양한 그래프들을 볼 수 있다.
```

> 오비탈 파동함수의 노드(node) 수가 n-l-1를 만족하는지 확인해보자  


시각화 가능한 다른 결과 파일들:  
• `charge`: Charge density (separated core and valence contributions)  
• `vcharge`: Valence charge density (same normalization)  
• `ae`: Orbital valence wavefunctions (radial part multiplied by r)  