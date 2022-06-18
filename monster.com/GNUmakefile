JobSolutions.pdf:
PNG=$(wildcard *.png)

%.pdf: %.Rmd  $(PNG)
	pandoc -t pdf -f markdown -o $@ $< -V geometry:margin=.5in

%.html: %.Rmd  $(PNG)
	pandoc -t html -f markdown -s -o $@ $<

