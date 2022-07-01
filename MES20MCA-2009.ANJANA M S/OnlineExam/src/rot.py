from scipy.ndimage import rotate

import cv2
img = cv2.imread(r"D:\mes kuttipuram\online classroom\src\static\pic\as.jpg")
print(img)
try:
    img = rotate(img, 90)
    cv2.imwrite(r"D:\mes kuttipuram\online classroom\src\static\pic\bbb.jpg", img)
except Exception as e:
    print("=====", e)
