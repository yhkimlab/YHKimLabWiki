##리눅스 커맨드 요약

| 커멘드 | 의미 | 
|:---:|:---:|
| conda info | 설치된 콘다의 버젼확인 |
| conda update conda | 콘다 업데이트 |
| conda install PACKAGENAME | 패키지이름의 콘다를 설치 |
| spyder | package를 실행(예 spyder) |
| conda install PACKAGENAME | 프로그램 업데이트 |
| COMMANDNAME --help | 커맨드 사용 설명 | 
| conda install --help | 커맨드 사용 설명 |
| conda create --name py35 python=3.5 | py35로 python 3.5 환경을 생성 |
| WINDOWS : activate py35 | 사용할 환경 활성화 |
| LINUX, macOs : source activate py35 | 사용할 환경 활성화 |
| conda env list | 나의 사용환경 리스트 확인 | 
| conda list --revisions | 현재 환경에 대한 변경 내역 확인 | 
| conda list --revision 2 | 이전버전 환경 복구 | 
| conda list --explicit > bio-env.txt | 환경을 텍스트로 복사 |
| conda env remove --name bio-env | 환경과 모든것을 삭제 | 
| WINDOWS: deactivate | 현재 환경 비활성화 |
| macOS, LINUX: source deactivate | 현재 환경 비활성화 | 
| conda env create --file bio-env.txt | 텍스트 파일로 부터 환경 생성 | 
| conda search PACKAGENAME | conda를 사용하여 패키지 검색 |
| https://docs.anaconda.com/anaconda/packages/pkg-docs | 아나콘다에서 패키지의 리스트 확인 |
| conda install jupyter | 주피터 패키지 설치 | 
| jupyter-notebook | 주피터 실행 | 
| conda install --name bio-env toolz | 다른 환경에서 새로운 패키지 설치 |
| conda update scikit-learn | 패키지 업데이트 | 
| conda install --channel conda-forge boltons | 채널을 통해 패키지 설치 | 
| pip install boltons | PyPl 로 부터 패키지 설치 | 
| conda remove --name bio-env toolz boltons | 어떤 환경으로 부터 패키지 삭제 | 
| conda create --name py34 python=3.4 | 다른버전의 파이썬을 py34 이름으로 설치 | 
| Windows: activate py34 | 다른버전의 파이썬으로 전환 |
| Linux, macOS: source activate py34 | 다른버전의 파이썬으로 전환 |
| Windows: where python | 파이썬의 현재 위치와 버전 확인 |
| Linux, macOS: which -a python | 파이썬의 현재 위치와 버전 확인 |
| python --version | 파이썬의 버전 확인 | 
