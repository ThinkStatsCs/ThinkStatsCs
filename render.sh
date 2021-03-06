#!/bin/sh

# cd /Users/janmartinek/Documents/Projekty/diplomka

rm -rf out
mkdir out
cp book.tex out/book.tex
cp -r figs out

# non-breaking spaces after prepositions
vlna -l -m -n out/book.tex

# copy assets
for file in ./assets/*
do
	filenameWithExt=$(basename "$file")
	cp $file out/$filenameWithExt
done

# quotes
sed "s/\`\`/\"\`/g" out/book.tex > out/book.tmp
sed "s/''/\"'/g" out/book.tmp > out/book.tmp2
rm out/book.tmp
mv out/book.tmp2 out/book.tex


cd out
pdflatex book.tex
xindy -L czech -C utf8 -M texindy -M page-ranges book.idx
pdflatex book.tex

open book.pdf
