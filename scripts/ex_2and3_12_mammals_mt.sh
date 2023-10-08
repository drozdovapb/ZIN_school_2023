mkdir ex2_3_12mammals_mt
cd ex2_3_12mammals_mt

## fully automated download: yes, it works, but it's too long
#esearch -email  -db nuccore -query "Felis catus mitochondrial genome" | efetch -format fasta_cds_na 
#esearch -email  -db nuccore -query "cat mitochondrial genome" | efetch -format fasta_cds_na 

## download amino acids!
esearch -email  -db nuccore -query NC_002503 | efetch -format fasta_cds_aa > Physeter_catodon_mt_prot.fa 
esearch -email  -db nuccore -query NC_001941 | efetch -format fasta_cds_aa > Ovis_aries_mt_prot.fa 
esearch -email  -db nuccore -query NC_001640 | efetch -format fasta_cds_aa > Equus_caballus_mt_prot.fa 
esearch -email  -db nuccore -query NC_001700 | efetch -format fasta_cds_aa > Felis_catus_mt_prot.fa 
esearch -email  -db nuccore -query NC_002008 | efetch -format fasta_cds_aa > Canis_lupus_familiaris_mt_prot.fa 
esearch -email  -db nuccore -query NC_029849 | efetch -format fasta_cds_aa > Myotis_lucifugus_mt_prot.fa 
esearch -email  -db nuccore -query NC_025952 | efetch -format fasta_cds_aa > Mus_spretus_mt_prot.fa  
esearch -email  -db nuccore -query NC_005089 | efetch -format fasta_cds_aa > Mus_musculus_mt_prot.fa  
esearch -email  -db nuccore -query MN935776 | efetch -format fasta_cds_aa > Marmota_marmota_mt_prot.fa  
esearch -email  -db nuccore -query NC_005943 | efetch -format fasta_cds_aa > Macaca_mulatta_mt_prot.fa  
esearch -email  -db nuccore -query NC_000891 | efetch -format fasta_cds_aa > Ornithorhynchus_anatinus_mt_prot.fa  
esearch -email -db nuccore -query NC_003322 | efetch -format fasta_cds_aa > Vombatus_ursinus_mt_prot.fa  

## rename for easier
for file in *mt_prot.fa
do sed -e 's/.*ND1.*/>ND1/' $file | sed -e 's/.*ND2.*/>ND2/' | sed -e 's/.*ND3.*/>ND3/' | sed -e 's/.*ND4].*/>ND4/' | sed -e 's/.*ND4L].*/>ND4L/' | sed -e 's/.*ND5.*/>ND5/' |  sed -e 's/.*ND6.*/>ND6/' | sed -e 's/.*COX1.*/>COX1/' | sed -e 's/.*COX2.*/>COX2/'  | sed -e 's/.*COX3.*/>COX3/' | sed -e 's/.*ATP6.*/>ATP6/'  | sed -e 's/.*ATP8.*/>ATP8/' | sed -e 's/.*CYTB.*/>CYTB/' >$file.renamed.fa
done
## now add species names
for file in *mt_prot.fa.renamed.fa
do export species_name=$(basename $file _mt_prot.fa.renamed.fa)
~/apt/bbmap/rename.sh in=$file prefix="$species_name" addprefix=true out=$species_name.mt_prots.fa ignorejunk=true
done

## CYTB
grep CYTB *mt_prots.fa --no-filename | cut -c2- >cytb_names.txt
for file in *.mt_prots.fa
do ~/apt/bbmap/filterbyname.sh in=$file out=$file.CYTB.aa.fa include=t names=cytb_names.txt overwrite=true ignorejunk=true
done

## finally we have multifast
cat *CYTB.aa.fa > CYTB.aa.fa
## align
mafft --auto CYTB.aa.fa >CYTB.aa.aln
## we could also trim, but it's really not needed here
## build tree
iqtree2 -s CYTB.aa.aln -alrt 1000 -abayes -o Ornithorhynchus_anatinus_CYTB,Vombatus_ursinus_CYTB --redo

## and exercise 3, all proteins

## now  let's make it automatic
cat one_gene_tree.sh 
#grep $gene$ *mt_prots.fa --no-filename | cut -c2- >$gene_names.txt
#for file in *.mt_prots.fa; do ~/apt/bbmap/filterbyname.sh in=$file out=$file.$gene.aa.fa include=t names=$gene_names.txt overwrite=true ignorejunk=true; done
#cat *$gene.aa.fa > $gene.aa.fa
#mafft --auto $gene.aa.fa >$gene.aa.aln
i#qtree2 -s $gene.aa.aln -alrt 1000 -abayes -o Ornithorhynchus_anatinus_$gene,Vombatus_ursinus_$gene --redo

## run through each protein
export gene=COX1; ./one_gene_tree.sh
export gene=ND2; ./one_gene_tree.sh
export gene=ND3; ./one_gene_tree.sh
export gene=ND4; ./one_gene_tree.sh
export gene=ND4L; ./one_gene_tree.sh
export gene=ND5; ./one_gene_tree.sh
export gene=ND6; ./one_gene_tree.sh
export gene=COX2; ./one_gene_tree.sh
export gene=COX3; ./one_gene_tree.sh
export gene=ATP6; ./one_gene_tree.sh
export gene=ATP8; ./one_gene_tree.sh
export gene=ND1; ./one_gene_tree.sh
export gene=CYTB; ./one_gene_tree.sh

for file in *aln; do cut -d_ -f1,2 $file >mt_proteins_alns/$file; done
iqtree2 -s mt_proteins_alns -alrt 1000 -abayes -o Ornithorhynchus_anatinus,Vombatus_ursinus --redo
