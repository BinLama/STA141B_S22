%.html:  %.Rmd
	pandoc -t html -f markdown -o $@ $<

%.html:  %.md
	pandoc -t html -f markdown -o $@ $<


%.pdf:  %.Rmd
	pandoc -t pdf -f markdown -o $@ $<