ORIGS=$(wildcard ./orig/*.jpeg)
JXLS=$(ORIGS:./orig/%.jpeg=./jxl/%.jxl)
JPEGS=$(ORIGS:./orig/%.jpeg=./jpeg/%.jpeg)

jpeg/%.jpeg: orig/%.jpeg
	convert $< -quality 85 $@

jxl/%.jxl: orig/%.jpeg
	cjxl --lossless_jpeg=0 --quality 85 $< $@

all: ${JXLS} ${JPEGS}
