## build 방법

모든 mkdocs.yml의 https://yhkimlab.github.io/YHKimLabWiki/site 부분을 http://localhost:8100 로 바꿔준다.

```bash
    python build.py
```

## test 방법

site 폴더에 들어가서 

```bash
    python -m http.server 8100
```

이후 웹브라우저에서 
localhost:8100 으로 접속

## deploy 시

모든 mkdocs.yml의 http://localhost:8100 부분을 https://yhkimlab.github.io/YHKimLabWiki/site 로 바꿔준다.