#https://github.com/jaejinchoi/FFP.git

mkdir FFP/
cd 1_pep_all
for file in *fa; do FFP_bin_2v.4.0 -a -s 13 -n $file ../FFP/$file; done
cd ../
JSD_matrix_bin.2v.4.0 -s -t 6 ./FFP/* > 12_items_s13.matrix
### BIONJ installation
#wget http://www.atgc-montpellier.fr/download/binaries/bionj/BIONJ.tar.gz
#tar zxvf BIONJ.tar.gz 
#chmod +x BIONJ_linux 

./BIONJ_linux 12_items_s13.matrix 12_mammals_ffp_tree.newick
cat 16_items_tree.newick