#!/bin/bash
# This script helps to creating ptbr dictionary (wordlist)
# with and without special characters like à á ç and so on 
# created this tool because everytime I need a ptbr wordlist,
# I had to check how to compile hunspell files, so, here is
# a script to do this and save me time.
# @dogasantos
############################################################
echo "[*] Downloading pt-br hunspell files"
wget "https://raw.githubusercontent.com/titoBouzout/Dictionaries/master/Portuguese%20(Brazilian).aff"
wget "https://raw.githubusercontent.com/titoBouzout/Dictionaries/master/Portuguese%20(Brazilian).dic"

echo "[*] Downloading hunspell unmunch source"
wget "https://raw.githubusercontent.com/hunspell/hunspell/master/src/tools/unmunch.cxx"
wget "https://raw.githubusercontent.com/hunspell/hunspell/master/src/tools/unmunch.h"

echo "[*] Compiling unmunch"
g++ -o unmunch unmunch.cxx

if [ -f unmunch ]; then
	echo "[*] Compiling dictionary file"
	./unmunch Portuguese\ \(Brazilian\).dic Portuguese\ \(Brazilian\).aff 2> /dev/null > ptbr
	echo "[*] Sorting"
	cat ptbr |sort > ptbr.txt 2>/dev/null
	rm -rf ptbr 2>/dev/null
	# just in case
	iconv -t utf-8 ptbr.txt > ptbr.utf8.txt  2>/dev/null
	rm -rf ptbr.txt 2>/dev/null
	
	if [ -f ptbr.utf8.txt ]; then
		echo "[*] Done"
	else
		echo "[x] Something went wrong"
	fi
else
	echo "[x] Check unmunch"
fi

