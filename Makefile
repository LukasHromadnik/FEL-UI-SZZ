FILES=$(shell find . -name "*.md" -not -name "README.md" -not -name "00_title.md")
PANDOC=pandoc -s 00_title.md $(FILES) -f markdown -V lang=cs-CZ

all: pdf

pdf:
	$(PANDOC) \
		--variable papersize=a4paper \
		-o main.pdf

html:
	$(PANDOC) \
		--katex \
		-t html \
		--css github.css \
		-o docs/index.html \
		-V title:""
