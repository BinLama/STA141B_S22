%.html:  %.Rmd
	pandoc -s -t html -f markdown -o $@ $<

%.html:  %.md
	pandoc -s -t html -f markdown -o $@ $<


%.pdf:  %.Rmd
	pandoc -t pdf -f markdown -o $@ $<