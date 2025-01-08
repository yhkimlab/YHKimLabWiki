Basic SIESTA Calculation
====================================
## Contents
1. SIESTA 개요
2. Example: 분자 계산


## SIESTA 개요
### 이론적배경
**a. `SIESTA`에서는 `Kohn-Sham 방정식`을 푸는 시뮬레이션을 진행한다. `Kohn-sham 방정식`은 아래와 같다.**

![03_001](img/03/03_001.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }

- `Pseudopotential` 은 **계산의 편의를 위해 원자의 핵심부 전자들을 하나의 포텐셜로 치환하는 것**을 의미한다. 아래 그림과 같이 pseudopotential은 원자와의 일정 거리(rc) 이상에서 실제 전자의 파동함수와 같도록 만들어 준다.

![03_002](img/03/03_002.jpg){: style="display:block; height:300px; margin-left:auto; margin-right:auto;" }

- 계산 상에서 간소화로 인해 야기되는 무시된 `single-particle problem`은 LDA(Local Density approximation)나 GGA(Generalized Gradient Approximation)와 같은 exchange-correlation 함수로 고려한다.
- Kohn-sham 방정식에서 파동함수는 `SZ`(single zeta), `DZ`(double zeta), `TZ`(triple zeta), `DZP`(double zeta polarized), `DZDP`(double zeta double polarized)…와 같은 `basis`로서 표현된다.
- 앞서 언급된, Basis의 결정으로 Basis 의 숫자가 결정되며 이는 **계산의 정확도와 관련**이 있다.

**b. `Kohn-Sham DFT(Density Functional Theory)`은 화학적 및 재료특성을 예측할 수 있는 가장 널리 사용되는 전자구조 이론이다.** 양자 역학에서 원자의 전자 구성을 파동 함수로 설명되는데 수학적 의미에서 이러한 파동 함수는 주어진 원자의 전자를 설명하는 basis 함수로 사용된다. 이러한 basis를 사용하여 여러 개의 원자 오비탈의 계수를 곱한 값의 선형확장(linear expansion)으로 분자 오비탈을 표현한다. **DFT 계산은 이러한 가정인 LCAO(linear combination of atomic orbitals)에 기초**하고 있다. 계산에서 사용되는 `SCF(self-consistent-field)` 계산의 알고리즘은  아래의 그림과 같다. 그림과 같은 **SCF loop의 iteration method**을 통해 변분법에 따른 *안정된 에너지를 가지는 역학적에너지와 포텐셜 에너지의 합*을 뜻하는 연산자 `Hamiltonian`을 구할 수 있다. 이를 통해 *band structure, DOS(Density Of States), PDOS(Projected Density Of States)* 등 다양한 물질특성을 분석할 수 있다.

![03_003](img/03/03_003.jpg){: style="display:block; height:500px; margin-left:auto; margin-right:auto;" }

알고리즘에서 H(Hamiltonian)은 LCAO(linear combination of atomic orbitals)로 구성되며 SCF loop를 통해 안정된 에너지를 가지는 H를 구할 수 있다. 이를 통해 Bandstructure, (P)DOS 등 다양한 물질특성을 분석할 수 있다.


### SIESTA 계산과정

- 위와 같은 DFT 계산을 위해서는 아래와 같은 입력(input) 파일과 실행(executable) 파일이 필요하다. 
<br>**Input** 파일은 `*.fdf`( *RUN.fdf , STRUCT.fdf , KPT.fdf , BASIS.fdf* ) 와 `*.psf` 가 필요하다.
- `fdf 파일`은 파일을 실행시키는데 필요한 정보들을 가지고 있는 파일이며 `psf파일`은 pseudopotential 정보를 가지고 있는 파일을 뜻한다.
- 이러한 input 파일을 통해 band structure, PDOS, eigenvalue 등의 결과를 알 수 있다. 
- SIESTA 는 아래 그림과 같은 과정으로 진행된다.

![03_004](img/03/03_004.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }



## Example: 분자 계산




### Exercise 1: CH4 분자 계산 준비

DFT 계산을 위해서는 먼저 계산하려는 구조의 최적화가 필요하다.

*A. 구조 최적화는 다음과 같은 방식으로 진행된다.*

![03_005](img/03/03_005.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }

- Step 1. 분자 구조를 추측하여 구조최적화 계산을 한다.
- Step 2. 위의 계산결과를 바탕으로 구조최적화 조건 없이 구조 계산을 실행한다.

*B. STRUCT 파일 구성* 

 - 사이트(예시 - https://materialsproject.org)에서 원하는 원자 구조를 받는다.
 <br> 또한 python 라이브러리를 통한 다운로드가 가능하다. (2024-01-10)



![Screenshot](img/0-05.png)
![Screenshot](img/0-15.png){: style="display:block; height:300px; margin-left:auto; margin-right:auto;" }

<br>

- `POSCAR` 파일로 다운 받은 경우(권장)

```bash
poscar2fdfd.py (fileName).poscar
```


<br>

- `CIF` 파일로 다운 받은 경우

<br>
계산을 하기위해 위에서 받은 cif파일을 fdf파일로 바꿔줘야한다.

```bash
$ vaspkit
1
105
struct.cif // cif 파일의 이름
```

위 순서대로 입력하고 enter를 치면 cif 파일에서 POSCAR 파일이 생성된다.

```bash
$ poscar2fdf.py POSCAR 
```

위 명령어를 치면 POSCAR 파일을 fdf 파일로 변환해준다.

이로서 구조최적화를 하기 전 기본적인 STRUCT.fdf 파일을 만들 수 있다.

<br><br><br>

```bash
$ vi STRUCT.fdf
NumberOfAtoms    5           # Number of atoms
NumberOfSpecies  2           # Number of species
%block ChemicalSpeciesLabel
 1 6 C
 2 1 H
%endblock ChemicalSpeciesLabel
LatticeConstant      40.000000000 Ang
%block LatticeVectors
    1.000000000     0.000000000     0.000000000
    0.000000000     1.000000000     0.000000000
    0.000000000     0.000000000     1.000000000
%endblock LatticeVectors
AtomicCoordinatesFormat ScaledCartesian
%block AtomicCoordinatesAndAtomicSpecies
    -0.000196800    -0.000196800    -0.000178525    1    1
     0.025718150    -0.006302475    -0.007980825    2    2
    -0.006302475     0.025718150    -0.007980825    2    3
    -0.002297125    -0.002297125     0.027402550    2    4
    -0.017873200    -0.017873200    -0.012210550    2    5
%endblock AtomicCoordinatesAndAtomicSpecies
```

<br><br>


*C. `*.psf` (pseudopotential) 파일은 
<A href = "https://departments.icmab.es/leem/SIESTA_MATERIAL/Databases/Pseudopotentials/periodictable-intro.html" target = "self" > default pseudopotential (ChemicalSpeciesLabel.psf) for each atomic species. </A>
에서 다운 받거나 직접 만들 수 있다.* 

 

`LDA`는 Non relatively, `GGA`는 relatively 계산된 파일이다. 자세한 사항은 Tutorial의 `Siesta-1-A-(2) 슈도포텐셜 생성`을 참고하자.



<br><br>계산에 필요한 pseudopotential 파일(`*.psf`)과 `BASIS.fdf`, `KPT.fdf`,  `slm_siesta_run`파일은 폴더에 정리해 두었다. <br>`slm_siesta_run`파일은 `/(home)/(user)/bin/`에서도 찾을 수 있다.

*D. 계산을 위한 폴더 만들기*

```sh
├─CH4
│  │  slm_siesta_run
│  └─input
│       BASIS.fdf
│       C.psf
│       H.psf
│       KPT.fdf
│       RUN.fdf
│       STRUCT.fdf
```

계산을 위해 다음과 같은 배치로 파일을 넣어주어야 한다. 이를 수행하기 위한 명령어는 아래와 같다.

```bash
$ mkdir ch4(폴더이름) 
$ cd ch4
slm_siesta_run을 ch4 폴더에 복사
$ mkdir input(폴더이름)
$ cd input 
C.psf, H.psf, RUN.fdf, STRUCT.fdf, KPT.fdf, BASIS.fdf 파일을 input 폴더에 복사
$ cd ..
$ sbatch slm_siesta_run
```

### Exercise 2: CH4 분자 구조 최적화

Exercise 1에서 주어진 `STRUCT.fdf` 파일은 이미 최적화가 완료된 파일이다. 
<br>이번에는 CH4의 틀린 구조를 입력으로 넣고 계산을 통해 올바른 구조가 도출되게 됨을 확인해 볼 것이다.  
CH4는 결합의 길이가 모두 같음이 알려져 있다. Exercise 1의 `STRUCT.fdf`파일도 결합 길이가 모두 같으므로 H 하나의 결합길이를 임의로 늘린 `STRUCT.fdf`파일을 입력으로 사용할 것이다.

```bash
NumberOfAtoms    5           # Number of atoms
NumberOfSpecies  2           # Number of species
%block ChemicalSpeciesLabel
 1 6 C
 2 1 H
%endblock ChemicalSpeciesLabel
LatticeConstant      40.000000000 Ang
%block LatticeVectors
    1.000000000     0.000000000     0.000000000
    0.000000000     1.000000000     0.000000000
    0.000000000     0.000000000     1.000000000
%endblock LatticeVectors
AtomicCoordinatesFormat ScaledCartesian
%block AtomicCoordinatesAndAtomicSpecies
    -0.000206800    -0.000206800    -0.000188525    1    1
     0.025718150    -0.006302475    -0.007980825    2    2
    -0.006302475     0.025718150    -0.007980825    2    3
    -0.002297125    -0.002297125     0.027402550    2    4
    -0.017873200    -0.017873200    -0.012210550    2    5
%endblock AtomicCoordinatesAndAtomicSpecies
```
<br>
우선적으로 부정확한 STRUCT.fdf의 구조를 보도록 하자. 
<br><br> 
1) fdf파일을 xcrysen을 통해 분자구조 확인
<br> 


```bash
$ cd (input directory)
$ fdf2xcrysden.py STRUCT.fdf
```

<br>다음과 같은 에러가 발생하는 경우 STRUCT.fdf 파일에 LatticeVectors block이 없는 것이다.
```bash
    if cell.shape == (3,3):
       ^^^^^^^^^^
AttributeError: 'list' object has no attribute 'shape'
```

<br>2) fdf파일을 xyz로 바꾸고 xcrysen을 통해 분자구조를 확인

```bash
$ cd (input directory)
$ fdf2xyz.py STRUCT.fdf # STRUCT.fdf 파일을 xyz 파일로 변환
                        # ./STRUCT.xyz 파일 생성
$ xyz2xcrysden.py STRUCT.xyz
```
<br><br><br>

**Display-Unit of Repetition-Translational asymmetric unit 선택**  
이를 반드시 해줘야 원자 구조를 알아볼 수 있다.

![03_011](img/03/03_011.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }


<br><br>Distance 선택 후 원자 두개를 선택한 후 Done을 선택하면 Distance를 알 수 있다.

![03_012](img/03/03_012.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }

<br><br>Angle 선택 후 원자 세개를 선택한 후 Done을 선택하면 Angle을 알 수 있다.

![03_013](img/03/03_013.jpg){: style="display:block; height:400px; margin-left:auto; margin-right:auto;" }

<br><br>이 방법을 통해 input에 들어가 있는 STRUCT.xyz의 결합 길이를 보도록 하자.

![03_010](img/03/03_017.png){: style="display:block; height:600px; margin-left:auto; margin-right:auto;" }

그림에서 볼 수 있듯이 CH4 분자의 왼쪽 H가 다른 분자보다 0.001 Ang 더 짧음을 알 수 있다.  
<br><br>
이 STRUCT.fdf파일을 input 폴더에 넣는다. 계산을 위해 RUN.fdf와 BASIS.fdf를 수정해준다.

```bash
$ cd input
$ vi RUN.fdf
MD.NumberCGstep을 300으로 바꾼다.
$ vi BASIS.fdf
PAO.BasisSize를 SZ로 바꾼다.
$ cd ..
$ sbatch slm_siesta_run
```

MD.NumberCGstep은 계산의 최대 iteration 횟수를 설정해주는 것이다. 
<br>여기서는 300번 계산을 돌려도 값이 수렴하지 않으면 프로그램을 끝낸다. 
<br>BasisSize는 빠른 구조확인을 위해 정확도는 떨어지지만 빠른 SZ로 설정해준다.
<br>계산을 완료하면 OUT폴더에 계산이 끝난 파일인 Test.xyz를 확인할 수 있다. 
<br>**이 파일이 구조 최적화 된 결과이다.** Test.xyz를 xcrysden으로 계산된 구조를 확인해보도록 하자. 
<br>그 전에 **Test.xyz에는 Cell정보가 포함되어 있지 않다.** 따라서 xcrysden으로 바로 읽어올 수 없다. 
<br>input에 있는 STRUCT.xyz파일의 Cell정보를 Test.xyz에 복사해준다.

![03_010](img/03/03_010.jpg)

Cell정보 복사가 완료되면 xcrysden으로 Test.xyz의 분자구조를 확인해보자.

```bash
$ cd (Output directory)
$ xyz2xcrysden.py Test.xyz
```

![03_010](img/03/03_018.png){: style="display:block; height:800px; margin-left:auto; margin-right:auto;" }

input의 결합길이가 0.001 Ang 차이났던 것과 달리 계산된 결과는 0.0001 Ang 수준으로 차이가 줄었다. 
<br>**따라서 최적화된 구조가 형성되었음을 확인해볼 수 있다.**
<br><br> ※ *C와 H간 분자간 길이가 1.2 Ang으로 Exercise 3의 결과와 거의 일치함도 확인해볼 수 있다.*
<br><br>

### Exercise 3: CH4 분자 basis 확인

 구조최적화를 위와 같이 진행 한 후에는 Basis 확인를 통해 사용한 Basis가 적절한지 테스트를 한다. 
 <br>Basis 테스트는 구조최적화가 완료된 구조에서 각 Basis 별로 계산을 진행하여 안정된 에너지를 가지는 Basis를 선택하면 된다. 
 <br><br>

- Siesta code
```bash
$ cd input
$ vi BASIS.fdf
아래 그림의 PAO.BasisSize를 SZ, DZ, TZ, DZDP 등으로 테스트 한다.
```

![03_014](img/03/03_014.jpg){: style="display:block; height:100px; margin-left:auto; margin-right:auto;" }
<br>

- xyz 파일보기 -Basis 별 bonding length 과 Reference(Handy, Nicholas C., Christopher W. )

```bash
$ cd OUT
1) $ Control + Alt + F
Test.xyz 파일을 바탕화면에 옮기고 Vesta 툴을 사용하여 xyz 파일을 볼 수 있다.

2) $ xyz2xcrysden.py Test.xyz 
```
<br>
Murray, and Roger D. Amos. "Study of methane, acetylene, ethene, and benzene using Kohn-Sham theory." The Journal of Physical Chemistry 97.17 (1993): 4392-4396.) 와 비교
<br><br>

![03_015](img/03/03_015.jpg){: style="display:block; height:250px; margin-left:auto; margin-right:auto;" }

|   | SZ | DZ | TZ | DZP | DZDP |
|---|:---:|:---:|:---:|:---:|---:|
| `Bonding length [Ang]` | 1.20100 | 1.10876 | 1.11050 | 1.10977 |	1.10861 |
| `Bonding angle [degree]` | 109.4398 |	109.1358 | 109.1567 |	109.4914 | 109.3702|

<br><br>

### Exercise 4: CH3 전자밀도

**a. spin에 따른 전자밀도를 보는 방법은 아래와 같다.**
<br> Spin 에 따른 전자밀도를 시각화 하기 위해서는 RUN.fdf 에서 아래와 같은 코드를 추가하여야한다

```bash
# 기존 Run.fdf
%include STRUCT.fdf
%include BASIS.fdf
%include KPT.fdf
#General system specifications
SystemName          CH3 molecule
SystemLabel         ch3
#Density functional
XC.functional   GGA
XC.authors      PBE
#Real space grid 
MeshCutoff    400.0 Ry
# Convergence of SCF 
MaxSCFIterations   100
DM.MixingWeight    0.25
DM.NumberPulay     5
# Type of solution (diagon is the  default for less than 100 atoms)
SolutionMethod diagon
#Geometrical optimization
MD.TypeOfRun         CG
MD.NumCGsteps        100
MD.MaxCGDispl         0.1 Bohr
MD.MaxForceTol        0.02 eV/Ang

```
```bash
#추가 코드
#Spin polarization 
 SpinPolarized .ture.

#3DPlos
 SaveRho .true.
%block LocalDensityOfStates
 -6.00 -3.00 eV
%endblock LocalDensityOfStates

WriteCoorXmol        .true.  # SystemLavel.xyz 
WriteMDXmol    .true.

```

**b. siesta code**

```bash
$ mkdir Ch3 (Ch3폴더 생성)
slm-siesta_run 파일을 여기에 복사
$ mkdir input
$ cd input 
ch3input, c.psf, H.psf 파일을 여기에 복사
$ cp ch3input RUN.fdf
$ cd ..
$ sbatch slm-siesta_run
& cd OUT
rho2xsf 파일을 여기에 복사
$ rho2xsf
$ ch3
$ A
$ -2 -2 -2
$ 5 0 0
$ 0 5 0
$ 0 0 5
$ 100 100 100
$ RHO
$ BYE #temp_xsf 폴더 생성
$ xcrysden –-xsf *.XSF # 입력하면 XCrySDen 창이 열린다.
```
<br>
Tool-Data Grid(up, down 선택)-Isovalue 범위 설정-submit으로 charge density를 아래와 같이 그릴 수 있다.

![03_016](img/03/03_016.jpg){: style="display:block; height:300px; margin-left:auto; margin-right:auto;" }
<br> ※ 수정 : 그림의 isovalue는 **왼쪽이 0.05일 때, 오른쪽이 0.12 일 때** 이다.

rho2xsf 에 입력되는 문장의 의미는 다음과 같다.

```bash
A           : Ang or Bohr
-2 -2 -2    : 원점
5 0 0
0 5 0 
0 0 5       : x y z 방향 벡터를 통해 구성되는 시스템의 크기를 정의
100 100 100 : 방향에 따른 grid points 정의
RHO         : 변환되는 grid 파일 
```

### 참고문헌
SIESTA homepage (<http://www.icmab.es/siesta/>)