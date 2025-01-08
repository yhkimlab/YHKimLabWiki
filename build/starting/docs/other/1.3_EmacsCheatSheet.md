## Emacs 명령어

> '+'는 동시에 입력하는 표시이다.  
>  **굵은** 표시는 사용자가 임의로 변경할 이름이다.  
>  그 외에 명령어는 차례로 누른다.

### 시작 및 종료
- emacs : 쉘 환경에서 emacs 실행
- emacs **filename** : 쉘 환경에서 emacs를 통해 **파일** 실행 
- emacs -nw **filename** : 쉘 환경에서 emacs을 통해 **파일** 실행 (윈도우 창 없이)
- Ctrl+x Ctrl+f **filedirectoty**: Emacs 내부에서 **파일** 실행
- Ctrl+x Ctrl+c : emacs 종료

### 커서 이동

- Ctrl+f : 오른쪽으로 한 글자 이동
- Ctrl+b : 왼쪽으로 한 글자 이동
- Ctrl+p :위로 한 글자 이동
- Ctrl+n : 아래로 한 글자 이동
- Ctrl+a : 줄 첫 글자로 이동
- Ctrl+e : 줄 마지막 글자로 이동
- Esc+f : 오른쪽으로 한 단어 이동
- Esc+b : 왼쪽으로 한 단어 이동
- Esc+a : 문장 첫 단어로 이동
- Esc+e : 문장 마지막 단어로 이동
- Esc+v : 위 페이지로 이동
- Ctrl+v : 아래 페이지로 이동
- Ctrl+l : 커서가 화면 중간에 올 수 있게 페이지 이동
- Ctrl+U **20** Ctrl+N : **20** 줄 앞으로 이동
- Ctrl+x l : 현 커서 위치에 있는 줄 번호
- Esc+g g **999** : **999**번 째 줄 이동

### 지우기
- Delete : 오른쪽 글자 지우기
- Ctrl+d : 왼쪽 글자 지우기
- Esc Delete : 오른쪽 단어 지우기
- Esc d : 왼쪽 단어 지우기
- Ctrl+k : 줄 안에서 오른쪽 나머지 지우기
- Esc 0 Ctrl+k : 줄 안에서 왼쪽 나머지 지우기

### 복사, 자르기 및 붙여넣기
- Alt+w -> Ctrl+y : (지정된 블럭을) 복사, 붙여넣기
- Ctrl+w -> Ctrl+y : (지정된 블럭을) 자르기, 붙여넣기
- Ctrl+x u : 되돌리기
- Ctrl+g : 실행 중이거나 부분적으로 입력한 명령어 취소

### 블럭 지정  
- Ctrl+Space : 블럭으로 지정
- Esc+h : 현재 문단을 블럭으로 지정
- Ctrl+x h : 문서 전체를 블럭으로 지정
- Ctrl+x Ctrl+x : 블럭을 지정하는 커서의 위치를 블럭 반대편으로 이동 (ex. 앞에서 뒤로)

### 검색 및 바꾸기
- Ctrl+s **patterntext** : **특정 패턴** 검색. 커서 이동
- Ctrl+r **patterntext** : **특정 패턴** 검색. 커서 이동
- Ctrl+s Enter Enter : 검색한 다음 결과로 커서 이동
- Ctrl+s Ctrl+s : 최근 찾은 결과 찾기
- Esc % **oldstring** Enter **newstring** Enter : **이전 단어**를 **다른 단어**로 대체  
> - y : 값 바꾸기  
> - n : 바꾸지 않기  
> - q : 바꾸지 않고 모드 나가기  
> - ! : 남은 값 모두 바꾸기  

### 중복 실행
- Ctrl+u **number** **command** : **특정 횟수**만큼 **특정 명령어**을 반복 실행  
- Esc+**number** **command** : **특정 횟수**만큼 **특정 명령어**을 반복 실행  

### 윈도우 분할
- Ctrl+x 1 : 싱글 윈도우
- Ctrl+x 2 : 수평 윈도우 추가
- Ctrl+x 3 : 수직 윈도우 추가
- Ctrl+x o : 나눠진 윈도우로 스위치
- Ctrl+x 0 : 현재 윈도우 닫기
- Ctrl+x 1 : 다른 윈도우 닫기

### 불러오기 및 저장
-  Ctrl+x Ctrl+f **filename** : 편집을 위한 새로운 **파일** 생성