library(ranger)
library(pROC)
library(xgboost)
library(caret)

trainIndex <- createDataPartition(train$id, p = .8, 
                                  list = FALSE, 
                                  times = 1)
trainDATA=data.matrix(train[trainIndex,4:6])
trainLABEL=data.matrix(train[trainIndex,ncol(train)])
testDATA=data.matrix(train[-trainIndex,4:6])
testLABEL=data.matrix(train[-trainIndex,ncol(train)])
model <- xgboost(data = trainDATA, label = trainLABEL,
                 nrounds = 50, objective = "binary:logistic",eta=0.95,early_stopping_rounds = 100,
                 eval_metric="logloss")

preds = predict(model, trainDATA)
pred = ifelse(preds>0.39,1,0)
out = cbind.data.frame(pred=pred,actual=as.factor(trainLABEL))

auc <- roc(as.factor(trainLABEL),preds)
print(auc)
plot(auc, ylim=c(0,1), print.thres=TRUE, main=paste('AUC:',round(auc$auc[[1]],2)))

#performance on test data
preds = predict(model, testDATA)
pred = ifelse(preds>(0.39),1,0)
out = cbind.data.frame(pred=pred,actual=testLABEL)

auc <- roc(as.factor(testLABEL),preds)
print(auc)
plot(auc, ylim=c(0,1), print.thres=TRUE, main=paste('AUC:',round(auc$auc[[1]],2)))

#actual test
test=data.matrix(test)
preds = predict(model, test[,4:6])
pred = ifelse(preds>(0.39),1,0)

sample_submission$is_duplicate=pred
write_csv(sample_submission,"First.csv")
