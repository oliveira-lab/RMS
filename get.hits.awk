#!/usr/bin/awk -f

#########################################################################
# File Name: get.hits.sh
# Author(s): Pedro H. Oliveira, Eduardo Rocha
# Institution: Institut Pasteur, Paris, France
# Mail: pcphco@gmail.com
# Created Time: Mon 28 Jan 2013 11:36:20 AM (GMT+1)
#########################################################################


#Extracts hits from an hmmsearch output file


BEGIN{
FIRST_FILE = ARGV[1]
OFS = "\t" 
currlen_thresh =  0.8	#Length threshold
eivalue_thresh = 0.001	#i-Evalue threshold
}

(FILENAME == FIRST_FILE && /^NAME/){
        id = $2
        next
}

(FILENAME == FIRST_FILE && /^LENG/){
        llen[id] = $2
        next
}

(FILENAME == FIRST_FILE){
next
}

/^Query:/{
	profile_len = llen[$2]
	descr = $2
}

/query HMM file/{
	acc = $NF
}
/^Description:/{
	descr = ""
	for (i=2; i<= NF; i++)
		descr = descr $i " "
}

/^>>/{
        id=$2;
#        descr = substr($0, index($0,$17))
#        id_syn=$11
        domain = 0
        currlen = 0
        curr_pval = ""
        getline; 
        getline; 
        getline; 
        while ($1!="Alignments") {
	        	ivalue = $6
	        	if (match(ivalue, "e")){
	        		nn=split(ivalue,vec,"e"); 
	        		ivalue = vec[1]*10^int(vec[2])
	        		}
                if (ivalue/1.0 < eivalue_thresh && length($0)>2){
                        currlen += ($8-$7+1)/profile_len
                        if (domain) {
                                curr_pval = curr_pval "&"
                                }
                        curr_pval = curr_pval ivalue
                        domain ++
                        }
                getline
        }    
        if (domain && currlen > currlen_thresh  )  
               print id, acc, id_syn, currlen, curr_pval, descr
}
