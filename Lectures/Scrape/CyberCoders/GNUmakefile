%.pdf: %.rmd
	pandoc -f markdown -t pdf -o $@ $< --pdf-engine=xelatex

%.html: %.rmd
	pandoc -f markdown -t html -s -o $@ $<
