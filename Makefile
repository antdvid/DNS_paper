PAPER=DNS
REFSLIB=.
BIBS=$(REFSLIB)/refs.bib
FIGS=Figures/*.eps
DVIPS=dvips -o $(PAPER).ps
PS2PDF=ps2pdf
CAPTIONS=

.IGNORE:
$(PAPER).pdf: $(PAPER).ps
	$(PS2PDF) $(PAPER).ps

$(PAPER).ps: $(PAPER).dvi
	$(DVIPS) $(PAPER)

$(PAPER).dvi: $(PAPER).bbl $(PAPER).aux $(FIGS) $(CAPTIONS)
	latex $(PAPER)
	latex $(PAPER)

$(PAPER).bbl: $(BIBS) $(PAPER).aux
	bibtex $(PAPER)
	latex $(PAPER)

$(PAPER).aux: $(PAPER).tex
	latex $(PAPER)

git-clean:
	git clean -f
clean:
	rm -f *.dvi *.ps *.bbl *.aux *.log 
html:   $(PAPER).pdf
	tth -i -t -e2 $(PAPER).tex
