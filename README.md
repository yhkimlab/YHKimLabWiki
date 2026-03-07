KAIST EE YHKim Lab wiki site

https://yhkimlab.github.io/YHKimLabWiki/site/


```bash
# conda terminal
git pull
```

필요한 라이브러리 설치

```bash
pip install mkdocs mkdocs-material mkdocs-material mkdocs-mermaid2-plugin mkdocs-glightbox mkdocs-git-revision-date-localized-plugin mkdocs-jupyter
# material = theme
# 나머지 =plugin
```

mkdocs.yaml이 있는 폴더에서

```bash
mkdocs build
mkdocs serve    # 로컬에서 확인용
```

```bash
git add .
git commit -m "   " # " " 안쪽에 수정사항 기입
git push --set-upstream origin origin/master
```