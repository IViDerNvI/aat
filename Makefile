PDFLATEX = xelatex
MAIN_TEX = main.tex
OUTPUT = main.pdf
SECTIONS = $(wildcard sections/*.tex)
LATEXINDENT = latexindent
CHECKTEX = chktex

all: clean $(OUTPUT)

$(OUTPUT): $(MAIN_TEX) $(SECTIONS)
	$(PDFLATEX) $(MAIN_TEX)
	$(PDFLATEX) $(MAIN_TEX)

clean:
	@echo "Cleaning up..."
	@rm -rf *.aux *.log *.out *.toc *.pdf *.bbl *.blg *.bak* *.fdb_latexmk *.fls *.xdv *.fls

format: $(MAIN_TEX) $(SECTIONS) lint
	@echo "Formatting LaTeX files..."
	@find . -name "*.tex" -exec $(LATEXINDENT) -w -q -l {} \;
	@echo "Formatting completed."
	@echo "Cleaning up..."
	@find . -name "*.bak*" -delete

lint:
	@echo "Linting LaTeX files..."
	@$(CHECKTEX) $(MAIN_TEX)
	@echo "Linting completed."

setup:
	@echo setup developer environment
	@bash ./scripts/setup.sh

.PHONY: all clean