## Inspiration:
## https://training.galaxyproject.org/training-material/topics/ecology/tutorials/de-novo-rad-seq/tutorial.html
## and also 
## https://github.com/nreid/RADseq_tutorial/blob/master/01b_Lacewings_stacksdenovo.md
## https://github.com/evansbenj/Reduced-Representation-Workshop/blob/master/9_Stacks_and_Phylogenies.md

## stacks installation
#wget https://catchenlab.life.illinois.edu/stacks/source/stacks-2.65.tar.gz
#tar zxvf stacks-2.65.tar.gz 
#cd stacks-2.65/
#cat README 
#./configure
#make
#sudo make install 
  
mkdir ex5_RADseq_stacks
cd ex5_RADseq_stacks
## get example data
## get data from NCBI with SRA toolkit
#fastq-dump -A SRR034310
## there is also fasterq-dump
wget https://zenodo.org/record/1134547/files/Barcode_SRR034310.txt
wget https://zenodo.org/record/1134547/files/Details_Barcode_Population_SRR034310.txt
## demultiplexing
process_radtags  -o . -e sbfI -f SRR034310.fastq -b Barcode_SRR034310.txt 


mkdir reads
mv *fq reads/
mkdir stacks_temp/

cd reads/
## long command!!!
ustacks -f sample_CAAC.fq -o ../stacks_temp/ 
## OR
for file in *fq; do ustacks -f $file  -o ../stacks_temp/; done

cd ../

## create file with a map
#nano map.txt
#sample_CCCC	freshwater
#sample_CCAA	freshwater
#sample_CCTT	freshwater
#sample_CCGG	freshwater
#sample_CACA	freshwater
#sample_CAAC	freshwater
#sample_CATG	freshwater
#sample_CAGT	freshwater
#sample_CTCT	oceanic
#sample_CTAG	oceanic
#sample_CTTC	oceanic
#sample_CTGA	oceanic
#sample_GGGG	oceanic
#sample_GGAA	oceanic
#sample_GGTT	oceanic
#sample_GGCC	oceanic


cstacks -P stacks_temp/ -M map.txt -p 8
sstacks -P stacks_temp/ -M map.txt -p 8
tsv2bam -P stacks_temp/ -M map.txt -t 8
gstacks -P stacks_temp/ -M map.txt -t 8

## or like this for 
nano map_all_diff.txt 
#sample_CCCC	CCCC
#sample_CCAA	CCAA
#sample_CCTT	CCTT
#sample_CCGG	CCGG
#sample_CACA	CACA
#sample_CAAC	CAAC
#sample_CATG	CATG
#sample_CAGT	CAGT
#sample_CTCT	CTCT
#sample_CTAG	CTAG
#sample_CTTC	CTTC
#sample_CTGA	CTGA
#sample_GGGG	GGGG
#sample_GGAA	GGAA
#sample_GGTT	GGTT
#sample_GGCC	GGCC


populations -P 2_ustacks/ -M map_all_diff.txt -r 1  --phylip 
sed '18d' 2_ustacks/populations.fixed.phylip >populations.fixed.phylip
iqtree2 -s populations.fixed.phylip -bb 1000 