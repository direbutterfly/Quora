library(NLP)
library(openNLP)
library(tm)
common = function(a,b){
  a=remSW(a)
  b=remSW(b)
  return(length(intersect(strsplit(paste(a, collapse = " "), ' ')[[1]],strsplit(paste(b, collapse = " "), ' ')[[1]])))
}

diff = function(a,b){
  a=remSW(a)
  b=remSW(b)
  diff1=setdiff(strsplit(paste(a, collapse = " "), ' ')[[1]],strsplit(paste(b, collapse = " "), ' ')[[1]])
  diff2=setdiff(strsplit(paste(b, collapse = " "), ' ')[[1]],strsplit(paste(a, collapse = " "), ' ')[[1]])
  return(length(diff1)+length(diff2))
}

all = function(a,b){
  a=remSW(a)
  b=remSW(b)
  return(length(union(strsplit(paste(a, collapse = " "), ' ')[[1]],strsplit(paste(b, collapse = " "), ' ')[[1]])))
}

remSW = function(a){
  stopWords <- stopwords("en")
  a=tolower(a)
  a=gsub('[[:punct:] ]+',' ',a)
  return(unlist(strsplit(a, " "))[!(unlist(strsplit(a, " ")) %in% stopWords)])
}

