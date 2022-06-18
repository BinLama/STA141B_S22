JobSolutions.pdf:
PNG=$(wildcard *.png)

%.pdf: %.Rmd  $(PNG)
	pandoc -t pdf -f markdown -o $@ $< -V geometry:margin=.5in

# https://groups.google.com/g/pandoc-discuss/c/ZvlZCMaUsq4?pli=1 for the max-width fix.
%.html: %.Rmd  $(PNG) GNUmakefile
	pandoc -t html5 -f markdown -s -o $@ $< -V include-before='<style>body{max-width: 95%}</style>'


#-V margin-left=3 -V margin-right=3 -V margin-top=3 -V margin-bottom=3

