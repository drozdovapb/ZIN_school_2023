## Clouded leopards
## https://doi.org/10.1016/j.cub.2006.08.066

#In the manuscript, they have pieces of several mt genes. Let's see if it reproduces by cytb only

#- Get data
efetch -db popset -id 126256205 -format fasta >felidae_cytb.fa
# Rename
cut -d ' ' -f 1,2,3 felidae_cytb.fa | sed -e 's/ /_/g' > felidae_cytb.renamed.fa
# Align
mafft --auto felidae_cytb.renamed.fa >felidae_cytb.aln
# View alignment and trim
alv cytb_arvicolinae.trim2.aln
#trimal -in felidae_cytb.aln -out felidae_cytb.trim.aln -automated1`
trimal -in felidae_cytb.aln -out felidae_cytb.trim.aln -nogaps
# Build tree
iqtree2 -s felidae_cytb.trim.aln -o EF437592.1_Felis_catus -alrt 1000 -abayes

#Is the result similar to the article?