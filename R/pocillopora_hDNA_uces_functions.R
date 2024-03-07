#pocillopora_hDNA_uces_functions.R
#author: "Mike Connelly"
#date: "02/15/2024"


# Basic phylogenetic tree visualization
###------------------------------------------------------------------------------------
gg_tree <- function(treefile) {
  ggtree(treefile) + 
    geom_tiplab() +
    geom_treescale(width = 0.01, x = 0.05) +
    geom_rootedge(rootedge = 0.01)
}