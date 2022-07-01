# %%
from sklearn.datasets import make_classification
from sklearn import tree
from sklearn.model_selection import train_test_split

X, t = make_classification(100, 5, n_classes=2, shuffle=True, random_state=10)
X_train, X_test, t_train, t_test = train_test_split(X, t, test_size=0.3, shuffle=True, random_state=1)
# %%
model = tree.DecisionTreeClassifier()
model = model.fit(X_train, t_train)
# # %%
# predicted_value = model.predict(X_test)
# print(predicted_value)
# # %%
# tree.plot_tree(model)
# # %%
# zeroes = 0
# ones = 0
# for i in range(0, len(t_train)):
#     if t_train[i] == 0:
#         zeroes += 1
#     else:
#         ones += 1
# # %%
# print(zeroes)
# print(ones)
# # %%
# val = 1 - ((zeroes / 70) * 2 + (ones / 70) * 2)
# print("Gini :", val)
#
# match = 0
# UnMatch = 0
#
# for i in range(30):
#     if predicted_value[i] == t_test[i]:
#         match += 1
#     else:
#         UnMatch += 1
#
# accuracy = match / 30
# print("Accuracy is: ", accuracy)


