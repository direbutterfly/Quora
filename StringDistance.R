library(data.table)
library(RecordLinkage)
library(stringdist)
library(wordnet)
library(openNLP)
Sys.setenv(WNHOME ="/Users/disha.gupta1@ibm.com/Downloads/WordNet-2.1/dict")
setDict("/Users/disha.gupta1@ibm.com/Downloads/WordNet-2.1/dict")
setwd("/Users/disha.gupta1@ibm.com/Desktop/Quora")
train = fread("train_data.csv",header=FALSE)
trainlabels=fread("train_labels.csv",header = FALSE)
test = fread("test_data.csv")
sample_submission = fread("sample_submission.csv")

colnames(train)=c("id","question1","question2")
colnames(trainlabels)=c("id","is_duplicate")

for (i in 1:nrow(train)){
train$match[i] = levenshteinSim(unlist(train[i,2]),unlist(train[i,3]))
print(i)
}
fwrite(train,"train_data_dist_addfeatures.csv",row.names = F)
for (i in 1:nrow(test)){
  test$match[i] = levenshteinSim(unlist(test[i,2]),unlist(test[i,3]))
  print(i)
}
fwrite(test,"test_data_dist.csv",row.names = F)
