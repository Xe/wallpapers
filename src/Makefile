ORIGS=$(wildcard ./orig/*.jpeg)
JXLS=$(ORIGS:./orig/%.jpeg=./jxl/%.jxl)
JPEGS=$(ORIGS:./orig/%.jpeg=./jpeg/%.jpeg)

jpeg/%.jpeg: orig/%.jpeg
	convert $< -quality 85 $@

jxl/%.jxl: orig/%.jpeg
	cjxl --quality=85 --effort=9 --brotli_effort=11 --lossless_jpeg=0 $< $@

all: ${JXLS} ${JPEGS}
