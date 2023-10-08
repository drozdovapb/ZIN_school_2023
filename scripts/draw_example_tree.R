library(ggtree) 
library(ggimage)

## read tree
newick.tree <- read.tree("families_alns.treefile")

ggtree(newick.tree) + 
  geom_tiplab(fontface="italic")



## more beautiful representation
newick.tree$tip.label <- gsub("_", " ", newick.tree$tip.label)

## phylopic images
tips <- newick.tree$tip.label
tipsimg <- ggimage::phylopic_uid(tips)
tips.upd <- newick.tree$tip.label
tips.upd[6] <- "Eptesicus"
tips.upd[8] <- "Marmota monax"
tips.upd[10] <- "Mus musculus"
tipsimg <- ggimage::phylopic_uid(tips.upd)
tipsimg$name <- tips
## save time and also edit if necessary
#write.csv(tipsimg, "tipsimg.csv")
#tipsimg <- read.csv("tipsimg.csv")

pBeauTree <- 
ggtree(newick.tree) + 
  geom_tiplab(fontface="italic") + 
  geom_treescale(x=0, y=11) + 
  xlim(0,.4)

pBeauTree
    
pBeauTree %<+% tipsimg + 
  geom_tiplab(aes(image=uid), geom="phylopic", offset = .075)

