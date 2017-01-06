sources=$(wildcard *.md)
htmls=$(sources:.md=.html)

all: $(htmls)

%.html : %.md skeleton.htm md2html
	./md2html $<

