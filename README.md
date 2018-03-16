# Scripts and HMM profiles to find restriction-modification (R-M) systems in prokaryotes
HMM profiles are divided according to Type and function (methyltransferases and restriction endonucleases). 

## Add `Go_HMM.sh`
Runs hmmsearch on a proteome file (*.prt file) and parses the output into convenient hits.

## Add `get.hits.awk`
Extracts hits from an hmmsearch output file

## Add `RM_HMMs`
Contains a catalogue of protein families represented as HMM profiles that can be scanned with HMMER3 to identify all types of R-M systems (including fused Type IIG, and Type IV REases).
