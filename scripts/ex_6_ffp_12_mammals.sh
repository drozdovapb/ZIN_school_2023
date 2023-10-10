#https://github.com/jaejinchoi/FFP.git

mkdir ex6_FFP/; mkdir ex6_FFP/FFP
cd 1_pep_all
for file in *fa; do FFP_compress -a -s 13 -n $file ../ex6_FFP/FFP/$file; done
cd ../ex6_FFP/
JSD_matrix -s -t 1 ./FFP/* > 12_items_s13.matrix
### BIONJ installation
#wget http://www.atgc-montpellier.fr/download/binaries/bionj/BIONJ.tar.gz
#tar zxvf BIONJ.tar.gz 
#chmod +x BIONJ_linux 

./BIONJ_linux 12_items_s13.matrix 12_mammals_ffp_tree.newick
cat 16_items_tree.newick