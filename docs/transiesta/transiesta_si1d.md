Basic TranSIESTA calculation
=========================
## Contents
1. Example 1: Perfect Si chain
2. Example 2: Imperfect Si chain


<center><img src="img/06/1.png" width="80%" height="50%"></center>

앞서 개요에서 설명했듯이 SIESTA 및 TranSIESTA 프로그램을 통해서 양자수송 특성을 계산하는 과정을 위와 같다. 이번 장에서 TranSIESTA 프로그램을 통해 Si chain (1D) 모델에 대해 평형상태 및 비평행상태의 전자수송 특성 계산과정을 제시한 단계에 따라서 소개하겠다.


## Example 1: Perfect Si chain

<center><img src="img/06/06-002.JPG" width="90%" height="90%"></center>

먼제 위와 같이 균일한 Si chain에 대해서 **평형상태**의 양자수송 특성 계산을 진행한다. 

### Step 1. Electrode calculation

<center><img src="img/06/06-003.JPG" width="60%" height="60%"></center>

TranSIESTA 계산을 위해서는 우선 전극에 대한 전자구조 계산을 통해 전극 구조의 `.TSHS` 파일을 얻는 과정이 필요하다. 이는 Hamiltonian 및 overlap 행렬의 정보를 담고 있으며, 추후 scattering 영역의 계산에서 필요한 surface Green function을 만들 때 사용된다.

```
$ cd 1.Electrodes/input
```

- RUN.fdf
```
#------------------------------------------------------
# FDF for 1d Si chain
#------------------------------------------------------ 
SystemName       1D Si GGA system
SystemLabel        Si1D_Elec
%include STRUCT.fdf
%include BASIS.fdf
%block kgrid_Monkhorst_Pack
 1    0    0    0.0
 0    1    0    0.0
 0    0   50    0.0
%endblock kgrid_Monkhorst_Pack
SolutionMethod        diagon
XC.functional         GGA
XC.authors            PBE
MeshCutoff            90.0 Ry
SaveHS                T
DM.UseSaveDM          true     # to use continuation files
TS.HS.Save 	          true
```
- STRUCT.fdf
```
NumberOfAtoms         2      
NumberOfSpecies       1       
LatticeConstant       4.8 Ang  

%block ChemicalSpeciesLabel
  1  14  Si 
%endblock ChemicalSpeciesLabel

%block LatticeVectors          
 5.00000  0.00000  0.00000
 0.00000  5.00000  0.00000 
 0.00000  0.00000  1.00000
%endblock LatticeVectors

AtomicCoordinatesFormat   ScaledCartesian  

%block AtomicCoordinatesAndAtomicSpecies
 0.00000  0.00000  0.00000  1 
 0.00000  0.00000  0.50000  1 
%endblock AtomicCoordinatesAndAtomicSpecies
```

Input 파일이 준비되면 TranSIESTA를 실행한다.

```
$ cd ../
$ qsub slm_transiesta_run
```
계산에 끝나면 OUT 폴더에 `.TSHS`가 생성된 것을 확인할 수 있을 것이다. 


### Step 2. Scatter region calculation

<center><img src="img/06/scatter.JPG" width="80%" height="80%"></center>

Electrode 계산을 끝내고 scatter region에 대한 계산을 하기 위해 2.perfection 폴더에 들어간다. 이 다음 1.Electrode 폴더에 생성된 `Si1D_Elec.TSHS` 파일을 2.perfection의 input폴더에 넣어준다. 

```
$ cd ../2.PerfectChain
$ cp ../1.Electrode/OUT/Si1D_Elec.TSHS input/
```
input폴더의 TS.fdf에서 1.Electrode에서 가져온 파일의 이름을 다음과 같이 `HS Si1D_Elec.TSHS` 로 적고 eletrode의 계산에 쓰인 atom수 2개를 `used-atom 2`로 수정한다.
```
$ cd INPUT
$ vi TS.fdf
```
TS.fdf
```
…
%block TS.Elecs
  Left
  Right
%endblock TS.Elecs

%block TS.Elec.Left
  HS Si1D_Elec.TSHS
  chem-pot Left
  semi-inf-dir -a3
  elec-pos begin 1
  used-atoms 2
%endblock TS.Elec.Left

%block TS.Elec.Right
  HS Si1D_Elec.TSHS
  chem-pot Right
  semi-inf-dir +a3
  elec-pos end -1
  used-atoms 2
%endblock TS.Elec.Right
…
```

slm_transiesta_run을 이용해 Transiesta를 계산한다
```
$ qsub slm_transiesta_run
```
계산에 끝나면OUT 폴더에 `.TSHS`와 `.TSDE`가 생성된 것을 확인할 수 있을 것이다.

### Step 3. Post-processing

<center><img src="img/06/06-005.JPG" width="60%" height="60%"></center>

 Transiesta  OUTPUT에서 `.TSHS`파일은 TBTrans을 계산에 필요한 파일이기 때문에 TBTrans를 계산하기 위해 OUTPUT폴더에서 이 파일들을 복사해 input폴더에 넣어준다. 그 다음 slm_transiesta_run_TBT을 이용해 TBTrans 계산을 해준다

```
$ cp OUT/Si1D_Perf.TSHS input/
$ qsub slm_transiesta_run_TBT
```

### Results: Transmission, Band, DOS, 

TBtrans 계산이 끝나면 TBtrans의 Output폴더(`TBtrans`)가 생성됐을 것이다. Transmission을 plot해보자.

```
$ cd TBtrans
$ python ../../show_trans.py Si1D_perf.AVTRANS_Left-Right
```
<center><img src="img/06/06-015.JPG" width="40%" height="40%"></center>

아래와 같이 전극의 density of states (DOS)나 band와 같은 전자구조와 transmission을 비교할 수 있다.

```
$ cd ../../1.Electrodes
$ xv2xsf

...

$ cp ../2.PerfectChain/TBtrans/Si1D_Perf.AVTRANS .
$python band+dos+T.py
```
<center><img src="img/06/06-016.JPG" width="60%" height="60%"></center>


## Example 2: Imperfect Si chain

<center><img src="img/06/06-009.JPG" width="90%" height="90%"></center>

이번에는 채널 구역의 중심 Si 원자가 위쪽 방향으로 이동된 비균질한 구조를 이용하여 평형상태 및 비평형상태의 전자수송 특성 계산을 한다.

### Equilibrium calculation (0V)

1.Electrode 폴더 OUT의 `Si1D_Elec.TSHS`를 INPUT에 복사한 후 TranSIESTA 계산을 한다.
```
$ cd ../3.ImperfectChain
$ cp ../1.Electrodes/OUT/Si1D_Elec.TSHS input/
```
이전과 마찬가지로 TS.fdf에서 electrode left와 right, used-atom을 수정해준 후 transiesta 계산을 한다.
```
$ cd ../
$ qsub slm_transiesta_run
```
OUT 폴더의 `Si1D_Perf.TSHS`를 input폴더로 복사해준 후 slm_transiesta_run_TBT을 이용해 TBTrans 계산을 해준다
```
$ cp OUT/Si1D_Perf.TSHS input/
$ qsub slm_transiesta_run_TBT
```

Silicon chain (1D)의 perfect구조와 imperfect구조의 0V 상황에서의 transmission을 비교해보자.

```
$ cd ../
$ cp ../2.PerfectChain/TBtrans/Si1D_Perf.TBT.AVTRANS_Left-Right ./Si1D_Perf.TBT.AVTRANS
$ cp ../3.ImperfectChain/TBtrans/Si1D_Imperf.TBT.AVTRANS_Left-Right ./Si1D_Perf.TBT.AVTRANS
$ python show_trans.py Si1D_Perf.TBT.AVTRANS Si1D_Perf.TBT.AVTRANS
```
<center><img src="img/06/06-018.JPG" width="60%" height="60%"></center>


### Non-equilibrium calculation (1V)

1.Electrode폴더 OUT의 `Si1D_Elec.TSHS`를 input에 복사한 후 TranSIESTA계산을 한다.

```
$ cd ../4.ImperfectChain_1V
$ cp ../1.Electrodes/OUT/Si1D_Elec.TSHS input/
$ qsub slm_transiesta_run
```

OUTPUT폴더의 `Si1D_Perf.TSHS`를 input에 복사한 후 TBTrans 계산을 한다  
```
$ cp OUT/Si1D_Perf.TSHS input/
$ qsub slm_transiesta_run_TBT
```

이번에는 Silicon chain에 1V를 걸어줄 것이다. 1V를 걸어줄 때에는 TS.fdf파일에서 TS.Voltage만 수정하면 된다.
1.Electrode폴더 OUT의 `Si1D_Elec.TSHS`를 input에 복사한 후 TranSIESTA계산을 한다.

```
$ cd ../5.ImperfectChain_1V
$ cd input
$ vi TS.fdf
-----------------------------------------
...
TS.Voltage    1.0 eV
TS.Forces     false
...
-----------------------------------------
$ cp ../1.Electrodes/OUT/Si1D_Elec.TSHS input/
$ qsub slm_transiesta_run
```

OUTPUT폴더의 `Si1D_Perf.TSHS`를 input에 복사한 후 TBTrans 계산을 한다  

```
$ cp OUT/Si1D_Perf.TSHS input/
$ qsub slm_transiesta_run_TBT
```

### Result: Imperfect Si chain 0V vs 1V

Silicon chain (1D) 0V, 1V의 perfect구조와 imperfect구조의 transmission을 비교하자.

```
$ cd ../
$ cp ../5.ImperfectChain_1V/TBtrans/Si1D_Perf.AVTRANS_Left-Right ./Si1D_Imperf_1V.TBT.AVTRANS
$ python show_trans.py Si1D_Perf.TBT.AVTRANS Si1D_Perf.TBT.AVTRANS
$ python show_trans.py Si1D_Perf.TBT.AVTRANS Si1D_Imperf.TBT.AVTRANS
$ python show_trans.py Si1D_Perf.TBT.AVTRANS Si1D_Perf_1V.TBT.AVTRANS
$ python show_trans.py Si1D_Perf.TBT.AVTRANS Si1D_Perf_1V.TBT.AVTRANS
```
<center><img src="img/06/06-017.JPG" width="80%" height="80%"></center>

