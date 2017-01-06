sources=$(wildcard *.md)
htmls=$(sources:.md=.html)

all: $(htmls)
	echo $(htmls)

%.html : %.md skeleton.htm
	./md2html $<

