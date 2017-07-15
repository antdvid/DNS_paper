PAPER=DNS
REFSLIB=.
BIBS=$(REFSLIB)/refs.bib
FIGS=Figures/*.eps
DVIPS=dvips -o $(PAPER).ps
PS2PDF=ps2pdf
CAPTIONS=

.IGNORE:
$(PAPER).pdf: $(PAPER).tex
	pdflatex $(PAPER).tex
	bibtex $(PAPER)
	pdflatex $(PAPER).tex

git-clean:
	git clean -f -d -x
clean:
	rm -f *.dvi *.ps *.bbl *.aux *.log 
html:   $(PAPER).pdf
	tth -i -t -e2 $(PAPER).tex
