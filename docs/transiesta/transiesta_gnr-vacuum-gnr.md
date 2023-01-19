GNRs-vacuum-GNRs junction model
=========================
## Contents
1. Junction 모델링
2. 수렴성 테스트
3. 비평형 상태 계산

그동안은 matrix Green's function을 기반으로 평형상태의 양자수송 특성을 계산하는 법에 대해서 다루었었다. 그러나 전압이 인가된 비평형 상황에서의 계산에서는 non-equilibrium Green's function (NEGF)의 도입이 필요하다. 이번 장에서는 위와 같은 graphene nanoribbons (GNRs)-vacuum-GNRs로 이루어진 비균질 모델에 대해서 junction을 정의하고 보다 정확한 계산을 위해서 수렴성 테스트를 진행하는 법을 소개하고 마지막으로 비평형 상태의 양자수송 특성을 계산하는 방법에 대해서 다룬다.


## Junction modeling

<center><img src="img/1.png" width="80%" height="80%"></center>

우리가 다룰 GNRs-vacuum-GNRs 구조는 위와 같이 양쪽으로 반-무한히 이어진 GRNs 전극 영역과 그 사이에 vacuum 영역으로 구분할 수 있다. 계산을 엄밀히 진행하기 위해서는 이전 **Junction modeling** 강의에서 언급했듯이 scattering 영역과 electrode 영역을 구분해야한다. 이를 위해서 다음과 같은 순서로 electrode/scattering 영역을 결정하여 junction 모델을 만들어보자.

1. Electrode의 principal cell 결정
2. Buffer layer 테스트를 통한 scattering 영역 결정


### Step 1: Electrode의 principal cell 결정

<center><img src="img/2.png" width="80%" height="80%"></center>

위와 같이 전극의 구조는 

```
python show_trans.py  5-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right 6-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right 7-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right
```

```
python show_trans.py  5-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right 6-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right 7-unit/OUT_tbt/scattering.TBT.AVTRANS_Left-Right
```



### Step 3: Post-processing
TBTrans를 이용하여 transmission을 구한다.
```
$ cp OUT/siesta.TSHS input/.
$ qsub slm _siesta_run_tbt
```

<center><img src="img/Si_transmission_SZP.png" width="60%" height="60%"></center>


## Exercise 2: K-point test
Si-SiO<sub>2</sub>-Si junction 모델은 3차원이므로 electrode 계산과 scattering 계산에서 k<sub>x</sub>, k<sub>y</sub>, k<sub>z</sub> k-points 증가시키며 transmission이 수렴되는 것을 확인한다.

- Electrode calculation
```
$ vi 1.elec_left/input/KPT.fdf
# 3 x 3 x 3 k-points
%block kgrid_Monkhorst_Pack
3   0   0   0.0
0   3   0   0.0
0   0   3   0.0
%endblock kgrid_Monkhorst_Pack

# 6 x 6 x 6 k-points
%block kgrid_Monkhorst_Pack
6   0   0   0.0
0   6   0   0.0
0   0   6   0.0
%endblock kgrid_Monkhorst_Pack

# 15 x 15 x 15 k-points
%block kgrid_Monkhorst_Pack
15  0   0   0.0
0   15  0   0.0
0   0   15   0.0
%endblock kgrid_Monkhorst_Pack
```

- Scattering region calculation
```
vi 3.total/input/KPT.fdf
# 3 x 3 x 1 k-points
%block kgrid_Monkhorst_Pack
3   0   0   0.0
0   3   0   0.0
0   0   1   0.0
%endblock kgrid_Monkhorst_Pack

# 6 x 6 x 1 k-points
%block kgrid_Monkhorst_Pack
6   0   0   0.0
0   6   0   0.0
0   0   1   0.0
%endblock kgrid_Monkhorst_Pack

# 15 x 15 x 15 k-points
%block kgrid_Monkhorst_Pack
15  0   0   0.0
0   15  0   0.0
0   0   1   0.0
%endblock kgrid_Monkhorst_Pack
```

Electrode, scatering region 계산 후 tbtrans를 통해 transmision을 비교하면 다음과 같다. 

<center><img src="img/Si_kpt_transmission.png" width="60%" height="60%"></center>

## Exercise 3: Basis test

위에서 구한 수렴된 k-points (`6 x 6 x 6`, `6 x 6 x 1`)를 이용하여 Basis size에 따라 transmission 그래프를 확인하여 적절한 basis를 찾는다. 계산시 electrode, Transiesta, TBtrans 계산 모두 동일한 basis size로 해야한다. input 폴더안의 `BASIS.fdf` 파일에서 옵션을 바꿔가며 baiss test를 진행한다.
``` 
 $ vi BASIS.fdf
 PAO.BasisSize    SZ          # SZP or DZ, DZP, TZP
```
basis에 따른 transmission 그래프는 다음과 같다.  

<center><img src="img/Si_basis_transmission.png" width="60%" height="60%"></center>



