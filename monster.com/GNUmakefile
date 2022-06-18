JobSolutions.pdf:
PNG=$(wildcard *.png)

%.pdf: %.Rmd  $(PNG)
	pandoc -t pdf -f markdown -o $@ $< -V geometry:margin=.5in
