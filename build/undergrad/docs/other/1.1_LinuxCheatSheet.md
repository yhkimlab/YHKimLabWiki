## 유닉스/리눅스(Unix/Linux) 기본 명령어

**유닉스/리눅스** 기반의 운영체제는 쉘(shell)을 통해서 사용자의 명령이 커널로 전달되어 작동한다. 가장 기본적으로 이용되는 쉘이 `bash`인데 본 장에서는 기초적인 `bash` 언어에 대해서 알아본다.

### pwd (print working directory)

현재 작업중인 디렉토리 정보 출력한다.

```bash
$ pwd
/YHKlab/tmp
```


### ls (list)

디렉토리 목록 확인한다.

```bash
$ ls
dir1  dir2  dir3
```


### cd (change directory)

지정된 경로 이동한다. 경로를 지정하는 방법에 대해서는 아래와 같이 크게 두 가지 방식이 있다.

#### 절대 경로 지정
> **cd**: 홈 디렉토리로 이동

```bash
$ cd /YHKlab/tmp/dir1
$ pwd
/YHKlab/tmp/dir1
```

#### 상대 경로 지정
> **cd ../ **: 하위 디렉토리로 이동
> **cd - **: 이전 디렉토리로 이동

```bash
$ pwd
/YHKlab/tmp/dir1
$ cd ../
$ pwd
/YHKlab/tmp
$ cd -
$ pwd
/YHKlab/tmp/dir1
```


### cp (copy)

파일 혹은 디렉토리를 복사한다.
> 디렉토리를 복사할때는 -r 옵션을 추가

```bash
$ ls
dir  file1  file2  file3
$ cp file1 file_copy
$ ls
dir  file_copy  file1  file2  file3 
$ cp -r dir dir_copy
$ ls
dir  dir_copy  file_copy  file1  file2  file3 
```


### mv (move)

파일 및 디렉토리 이동한다.

```bash
$ pwd
/YHKlab
$ ls
dir  file1  file2  file3 
$ mv file1 dir/.
$ cd dir
$ pwd
/YHKlab/dir
$ ls
file1
```
파일 및 디렉토리 이름 변경하는 기능을 한다.
```
$ mv file1 file_changed_name
$ ls
file_changed_name
```


### mkdir (make directory)

디렉토리 생성한다.
> -p 옵션을 주면 하위 디렉토리까지 한 번에 생성 가능

```bash
$ mkdir new_dir_name
$ ls
new_dir_name
```

### rm (remove)

파일 혹은 디렉토리를 제거한다.
> 디렉토리를 제거할때는 -r 옵션을 주어야함

```
$ ls
file  dir
$ rm file
$ ls
dir
$ rm -r dir
$ ls

```

### cat (concatenate)

파일의 내용을 출력한다.
```
$ ls
file1  file2
$ cat file1
Hellow
$ cat file2
World
```

`cat` 명령어를 통해 두 파일의 내용을 합칠 수도 있다.

#### 새로운 파일 작성
```
$ cat file1 file2 > file_new
$ cat file_new
Hellow World
```
```
$ cat file2 file1 > file_new
$ cat file_new
World Hellow
```

#### 기존 파일에 덮어쓰기
```
$ cat file1 >> file2 
$ cat file2
Hellow World
```
```
$ cat file2 >> file1
$ cat file1
World Hellow
```

## 기타 명령어

지금까지 가장 기초적인 `bash` 명령어에 대해서 알아보았다. 그 외 기타 명령어는 다음을 참조하자.

| 커멘드 | 의미 | 
|:---:|:---:|
| control + c | 현재 커맨스를 정지 |
| control + insert | 복사 |
| shift + insert | 붙여넣기 | 
|  ls  | 리스트 파일표시 |
| ls -al | 리스트 파일 세부표시 |
| pwd | 현재 디렉토리 표시 |
| rm flle_name | 파일 삭제 |
| rm -r file_name | 파일강제삭제 |
| rm -rf file_name | 파일강제삭제, 질문무시 |
| cp -file1 file2 | 파일 복사 |
| cp -r dir1 dir2 | 파일(폴더) 복사 |
| mv file1 file2 | 파일 이름 변경 |
| mkdir | 디렉토리 생성 | 
| ln -s /path/to/file_name link_name | 링크 파일 생성 |
| touch file_name | 파일생성 |
| chmod 777 /data/test.c | 서버에 접근가능한 사용자에게 rwx 권한을 위임 |
| grep 'patten' files  |  파일안에 패턴을 모두 검색 |
| locate file | 파일 검색 |
| find /home/ -name "index" | home 폴더안에 index 로 시작하는 파일이름 검색 |
| find /home -size +100000k | 100000k 보다 큰 파일을 home 폴더에서 검색 | 
| ssh user@host | 사용자로 host에 연결 | 
| du -sh | 디렉토리의 파일 용량 확인 | 
| cd .. | 현재디렉토리 보다 상위로 이동 |
| cd | home 디렉토리로 이동 |
| cd /test | /test 디렉토리로 이동 | 
| tar -xsf | 압축풀기 | 
| display file_name.png | 그림 파일 보기 | 
| !! | 이전 커맨드 반복 | 
| control + D | 현재 세션 로그아웃 | 


