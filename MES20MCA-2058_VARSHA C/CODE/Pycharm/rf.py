from mlxtend.evaluate import confusion_matrix
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.datasets import make_classification

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score

import numpy
dataset = numpy.loadtxt("dataset.txt", delimiter="\t")
# split into input (X) and output (Y) variables
import numpy as np
X=[]
Y=[]

X = dataset[:,0:2]
y = dataset[:,2]
print (y)
clf_entropy = DecisionTreeClassifier(
    criterion="entropy", random_state=100,
    max_depth=3, min_samples_leaf=5)
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size = 0.3, random_state = 100)
# Performing training
clf_entropy.fit(X, y)

y_pred = clf_entropy.predict(X_test)

print("Confusion Matrix: ",
      confusion_matrix(y_test, y_pred))

print("Accuracy : ",
      accuracy_score(y_test, y_pred) * 100)


clf = RandomForestClassifier(max_depth=2, random_state=0)
clf.fit(X, y)
# RandomForestClassifier(...)
def predictfn(val):
    res=clf.predict([val])
    return res[0]

# print(predictfn([10.094	,2337.5485876091343]))