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

clean:
	rm -f $(PAPER).bbl $(PAPER).blg $(PAPER).aux $(PAPER).dvi $(PAPER).log
