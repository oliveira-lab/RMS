#!/bin/csh -f

#########################################################################
# File Name: Go_HMM.sh
# Author(s): Pedro H. Oliveira, Eduardo Rocha
# Institution: Institut Pasteur, Paris, France
# Mail: pcphco@gmail.com
# Created Time: Mon 28 Jan 2013 12:51:54 AM (GMT+1)
#########################################################################


#Runs hmmsearch on a proteome file (*.prt file) and parses the output into convenient hits
#Requires: Hmmer
#Usage: Go_HMM.sh <*.prt file> <*.hmm profile file>


if (! -e $2:r.$1:t:r.hmm.res) then
	hmmsearch --textw 240 $2 $1 > ! $2:r.$1:t:r.hmm.res
endif 

awk -f get.hits.awk $2 $2:r.$1:t:r.hmm.res | sort >! $2:r.$1:t:r.hmm.hits

exit
echo "Done!"
