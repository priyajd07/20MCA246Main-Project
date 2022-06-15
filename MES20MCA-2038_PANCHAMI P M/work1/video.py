
capture=Button(top,text="Camera",command=upload,padx=10,pady=5)
capture.configure(background='#364156', foreground='white', font=('calibri', 10, 'bold'))
capture.pack(side=TOP, pady=50)





# camera = cv2.VideoCapture(0)
#
# while True:
#     success, img = camera.read()
#     cv2.imshow("Webcam", img)
#     if cv2.waitKey(1) == ord('q'):
#         break