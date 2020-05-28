PART=.
FILES=$(shell find $(PART) -name "*.md" -not -name "README.md" -not -name "00_title.md" | sort)
PANDOC=pandoc -s 00_title.md $(FILES) -f markdown -V lang=cs-CZ --number-sections

all: pdf

pdf:
	$(PANDOC) \
		--variable papersize=a4paper \
		-o main.pdf

# html:
# 	$(PANDOC) \
# 		--katex \
# 		-t html \
# 		--css github.css \
# 		-o docs/index.html
