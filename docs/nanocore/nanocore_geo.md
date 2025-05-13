### Geometry optimization

`SIESTA` 프로그램은 **켤레기울기법** (conjugate-gradients, `CG`)을 통해 단위격자 내부에 원자의 위치에 따라 발생하는 힘 또는 응력 (strees)을 최소로 하는 최적화된 구조를 찾는다. `NanoCore`는 `Siesta` 클라스에 `set_option` 함수를 통해 `CGsteps` 옵션을 변경해주고, 시뮬레이션을 실행하는 `run` 함수에서 입력 변수를 `Optimization`으로 바꿔 `CG`을 통한 **geometry optimization**을 수행할 수 있다.

이전 장의 이어서 다음 코드을 진행한다.

```python
# Geometry optimizations by CG method
import os

# Set options for CG 
nCGstep = 50
sim.set_option('CGsteps', nCGstep)
```
`set_optioion` 함수를 통해 `CGsteps`가 50으로 설정되었다. 이제 `sim.run(mode='Optimization')` 명령어를 통해 `CG`가 활성화된 최적화 계산을 수행할 수 있다. 단, 최적화된 구조를 `xyz` 형식의 출력파일로 얻기 위해서는 `SIESTA` 프로그램에서 `WriteCoorXmol .true.`라는 코드를 명시해야한다. `NanoCore`는 현재 이 부분에 대한 옵션이 비활성화 되어 있으니 임의로 이 부분을 수정한다.

`/NanoCore/siesta2.py` :
```
 347         ## OUT OPTIONS ##
 348         #file.write("\n#(9) Output options\n\n")
 349         #file.write("WriteCoorInitial      F      # SystemLabel.out\n")
 350         #file.write("WriteKpoints          F      # SystemLabel.out\n")
 351         #file.write("WriteEigenvalues      F      # SystemLabel.out [otherwise ~.EIG]\n")
 352         #file.write("WriteKbands           T      # SystemLabel.out, band structure\n")
 353         #file.write("WriteBands            T      # SystemLabel.bands, band structure\n")
 354         #file.write("WriteMDXmol           F      # SystemLabel.ANI\n")
 355         file.write("WriteCoorXmol        .true.  \n")
```

이제 계산을 수행하여 **Geometry optimization**을 진행한다.

```python
os.system('mkdir GEO')
os.chdir('GEO')

print('Geometry optimization')
sim.run(mode='Optimization')
os.chdir('..')
```
계산된 출력파일들이 `/GEO` 디텍토리에 안에 생성되었다.


### 최적화된 구조을 이용하기 위한 작업

**Geometry optimization** 과정을 통해 얻은 원자들의 위치에 대한 정보는 `siesta.xyz` 출력파일에 담겨 있다. 그러나 `SIESTA`의 `CG` 계산을 통해 얻은 출력파일은 격자 (cell)에 대한 정보를 담고 있지 않아 온전하지 않다.

```
    2

C      -0.015112   -0.008725   -0.000000
C       1.241133    0.716568    0.000000
```
두번째 줄이 격자에 대한 정보가 들어가야할 위치이다. 이 위치에 격자벡터의 성분 길이와 각 성분 간의 각도을 입력하면 된다. `NanoCore`는 `get_cell()`과 `convert_xyz2abc` 함수를 통해 이에 대한 정보를 얻을 수 있다. 다음 과정을 통해 온전한 `xyz`형식의 출력파일을 얻는다.

```python
# Get number of lines of cell-undefined xyz_file
def file_len(filename):
    with open(filename) as f:
        for i, l in enumerate(f):
            pass
    return i+1
tlines = file_len('siesta.xyz')


# Get optimized atomic informations from cell-undefined xyz_file
file_info1 = []
file_info2 = []

os.chdir('GEO')
f = open('siesta.xyz','r')
for i in range(tlines):
    line = f.readline()
    words = line.split()  
    file_info1.append(line)
    file_info2.append(words)
f.close()
os.chdir('..')

# Get cell informations for cell-undefined xyz_file
cell = atoms.get_cell()
a,b,c,alpha,beta,gamma = convert_xyz2abc(cell[0], cell[1], cell[2])


# Write full-information xyz_file
xyz_file = open('STRUCT.xyz', 'w')
for i in range(len(file_info1)):
    if i == 0:
        xyz_file.write(file_info1[i])
    elif i == 1:
        xyz_file.write("%4s %10.5f %10.5f %10.5f %10.5f %10.5f %10.5f\n" %("CELL",a,b,c,alpha,beta,gamma))
    else:
        xyz_file.write(file_info1[i])
xyz_file.close()
```

`STRUCT.xyz` 파일이 생성되었다. 파일을 열어보면,

```
    2
CELL    2.50948    2.50948   15.00000   90.00000   90.00000   60.00000
C      -0.015112   -0.008725   -0.000000
C       1.241133    0.716568    0.000000
```
두번째 줄에 격자정보에 대한 정보가 추가된 것을 확인할 수 있다. **Geometry optimization**을 마친 `STRUCT.xyz` 파일은 `NanoCore`의 `io.read_xyz` 함수를 통해 다음 계산에서 이용할 수 있다.

```python
from NanoCore import *
optimized_atom = io.read_xyz('STRUCT.xyz')
```
