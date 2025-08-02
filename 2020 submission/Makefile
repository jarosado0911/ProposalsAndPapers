## frontiers Makefile
### Usage: make
### Questions: grein@temple.edu
## Note: On OSX can use make open to build and open pdf in default PDF viewer
LATEX=pdflatex
LATEXMK=latexmk
LATEXMKOPT=-pdf
OS=$(shell uname -s)

MAIN=xsede
PERF=performance
SOURCES=$(MAIN).tex $(PERF).tex Makefile references.bib $(shell ls inc/*.tex)
FIGURES:=$(shell find inc/img/* -type f)

all: $(MAIN).pdf $(PERF).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) -pdf $(MAIN)

$(PERF).pdf: $(PERF).tex .refresh $(SOURCES) $(FIGURES)
	$(LATEXMK) -pdf $(PERF)

force:
	touch .refresh
	rm $(MAIN).pdf
	rm $(PERF).pdf
	$(LATEXMK) -pdf $(MAIN)
	$(LATEXMK) -pdf $(PERF)

clean:
	$(LATEXMK) -C $(MAIN)
	$(LATEXMK) -C $(PERF)
	rm -f $(MAIN).pdf
	rm -f $(PERF).pdf
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
	$(LATEXMK) -C $(MAIN)
	$(LATEXMK) -C $(PERF)

debug:
	$(LATEX) $(MAIN)
	$(LATEX) $(PERF)

open: $(MAIN).pdf
ifeq ($(OS),Darwin)
	open $(MAIN).pdf
endif

.PHONY: clean force once all open
