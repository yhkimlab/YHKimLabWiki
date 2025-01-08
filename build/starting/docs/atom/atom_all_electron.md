All-electron calculations
===============================
## Contents
1. All-electron calculation

## All-electron calculations

바닥 상태의 Si 원자를 예시로 `ATOM`의 입력파일을 살펴보겠다. 보통 `ATOM` 입력 파일의 확장자는 `.inp`로 표시한다. 설치된 *`ATOM` 위치*에서 `/Tutorial/All_electron`에 다음과 같은 파일이 있다.
`Si.ae.inp`
```bash
ae Si Ground state all-electron	# 계산 종류 (ae : All-electron) / 시스템 이름
   Si   ca			            # 원소기호 / Exchange correlation 종류 (ca : non-realistic)
       0.0
    3    2			            # 핵(core) 오비탈 (1s, 2s, 2p) / 원자가(valence) 오비탈 (3s, 3p)
    3    0      2.00		    # 주 양자수(n) / 방위 양자수(l) / 전자 수
    3    1      2.00

12345678901234567890123456789012345678901234567890      Ruler
```
`/Tutorial/Utils/` 위치에 `ATOM` 프로그램 계산을 위한 쉘 스크립트들이 있다. 다음과 같은 명령어로 All-electron 계산을 수행한다.
```bash
$ sh ../Utils/ae.sh si.ae.inp
=> si.ae 폴더 생성
```
생성된 `si.ae` 위치에 가면 결과 파일들이 생성되어 있다. 결과 파일들에 대한 자세한 설명은 `Atom User Manual` 참조하길 바란다. 
<br>`.gplot`, `.gps` 형식 파일은 `gnuplot`과 관련한 결과 파일들이다. 
<br>`gnuplot` 패키지가 설치되어 있다면 다음과 같은 명령어로 그래프를 생성할 수 있다.
<br>(`-persist` 옵션을 추가하지 않으면 그래프가 유지되지 않는 현상이 있다)
```bash
$ gnuplot -persist ae.gplot //gplot 파일들을 불러오면 다양한 그래프들을 볼 수 있다.
```
