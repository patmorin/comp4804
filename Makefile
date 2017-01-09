sources=$(wildcard *.md)
htmls=$(sources:.md=.html)

ipes=$(wildcard *.ipe)
svgs=$(ipes:.ipe=.svg)

all: $(htmls) $(svgs)

%.html : %.md skeleton.htm md2html
	./md2html $<

%.svg : %.ipe
	iperender -svg $< $@

