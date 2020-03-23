#! /bin/bash

#translate DNA to amino acids
~/software/test/BIOL435/translate.py DRA.fas > DRA.aa.fas

#mafft alignment
mafft DRA.aa.fas > DRA.aa.mafft.aln.fas 

#reverse translate aamino acids to codons
~/software/test/BIOL435/reverseTranslateAlignment.py DRA.aa.mafft.aln.fas DRA.fas > DRA.codon.fas

#builds a codon alignment tree
raxmlHPC-PTHREADS -f a -p 12345 -x 12345 -s DRA.codon.fas -n codon -# 100 -m GTRGAMMA -T 4 

#builds a amino acid aligned tree
raxmlHPC-PTHREADS -f a -p 12345 -x 12345 -s DRA.aa.mafft.aln.fas -n protein -# 100 -m PROTCATWAG -T 4

#draws the codon tree
xvfb-run python ~/software/test/BIOL435/drawTree.py RAxML_bipartitions.codon DRA_codon 

#draws the amino acid trees
xvfb-run python ~/software/test/BIOL435/drawTree.py RAxML_bipartitions.protein DRA_protein
