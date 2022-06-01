import tkinter.ttk as ttk

from _thread import start_new_thread
import numpy as np
import cv2
# from  Detection.encode_faces import enf
import time
from tkinter import *
from tkinter import messagebox

WORD = re.compile(r'\w+')


from collections import Counter
# import mathp
#-----------------------------
#face expression recognizer initialization

fn=''


from scipy.spatial import distance as dist
import numpy as np
import argparse, cv2, os, time
	# , schedule

	#----------------------------Parse req. arguments------------------------------#
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--input", type=str, default="",
	help="path to (optional) input video file")
ap.add_argument("-o", "--output", type=str, default="",
	help="path to (optional) output video file")
ap.add_argument("-d", "--display", type=int, default=1,
	help="whether or not output frame should be displayed")
args = vars(ap.parse_args())
#------------------------------------------------------------------------------#






# if a video path was not supplied, grab a reference to the camera

# otherwise, grab a reference to the video file

	# start the FPS counter
def sd():
	cap = cv2.VideoCapture(0)
	()

	# loop over the frames from the video stream
	while True:



		(grabbed, frame) = cap.read()
		# if the frame was not grabbed, then we have reached the end of the stream
		if not grabbed:
			break

		# resize the frame and then detect people (and only people) in it
		frame = imutils.resize(frame, width=700)
	# 	results = detect_people(frame, net, ln,
	# 		personIdx=LABELS.index("person"))
    #
	# 	# initialize the set of indexes that violate the max/min social distance limits
	# 	serious = set()
	# 	abnormal = set()
    #
	# 	# ensure there are *at least* two people detections (required in
	# 	# order to compute our pairwise distance maps)
	# 	if len(results) >= 2:
	# 		# extract all centroids from the results and compute the
	# 		# Euclidean distances between all pairs of the centroids
	# 		centroids = np.array([r[2] for r in results])
	# 		D = dist.cdist(centroids, centroids, metric="euclidean")
	# 		print(D)
	# 		# loop over the upper triangular of the distance matrix
	# 		for i in range(0, D.shape[0]):
	# 			for j in range(i + 1, D.shape[1]):
	# 				# check to see if the distance between any two
	# 				# centroid pairs is less than the configured number of pixels
	# 				print(config.MIN_DISTANCE)
	# 				print(D[i, j],"++++++++++++++++++++++++++++++++++++==",i,j)
	# 				if D[i, j] <= 300:#config.MIN_DISTANCE:
	# 					# update our violation set with the indexes of the centroid pairs
	# 					serious.add(i)
	# 					serious.add(j)
	# 				# update our abnormal set if the centroid distance is below max distance limit
	# 				print(D[i, j],"======____++++++")
	# 				# if (D[i, j] <145): #config.MAX_DISTANCE):# and not serious:
	# 				# 	abnormal.add(i)
	# 				# 	abnormal.add(j)
	# 	if len(serious)>0:
	# 		import winsound
	# 		frequency = 2500  # Set Frequency To 2500 Hertz
	# 		duration = 1000  # Set Duration To 1000 ms == 1 second
	# 		for i in range(0,5):
	# 			winsound.Beep(frequency, duration)
	# 			print("Beep++++++++++++++++++++++++++++++++++++++++++++++")
    #
	# 	# loop over the results
	# 	for (i, (prob, bbox, centroid)) in enumerate(results):
	# 		# extract the bounding box and centroid coordinates, then
	# 		# initialize the color of the annotation
	# 		(startX, startY, endX, endY) = bbox
	# 		(cX, cY) = centroid
	# 		color = (0, 255, 0)
    #
	# 		# if the index pair exists within the violation/abnormal sets, then update the color
	# 		if i in serious:
	# 			color = (0, 0, 255)
	# 		elif i in abnormal:
	# 			color = (0, 255, 255) #orange = (0, 165, 255)
    #
	# 		# draw (1) a bounding box around the person and (2) the
	# 		# centroid coordinates of the person,
	# 		cv2.rectangle(frame, (startX, startY), (endX, endY), color, 2)
	# 		cv2.circle(frame, (cX, cY), 5, color, 2)
    #
	# 	# draw some of the parameters
	# 	Safe_Distance = "Safe distance: >{} px".format(config.MAX_DISTANCE)
	# 	cv2.putText(frame, Safe_Distance, (470, frame.shape[0] - 25),
	# 		cv2.FONT_HERSHEY_SIMPLEX, 0.60, (255, 0, 0), 2)
	# 	Threshold = "Threshold limit: {}".format(config.Threshold)
	# 	cv2.putText(frame, Threshold, (470, frame.shape[0] - 50),
	# 		cv2.FONT_HERSHEY_SIMPLEX, 0.60, (255, 0, 0), 2)
    #
	# 	# draw the total number of social distancing violations on the output frame
	# 	text = "Total serious violations: {}".format(len(serious))
	# 	cv2.putText(frame, text, (10, frame.shape[0] - 55),
	# 		cv2.FONT_HERSHEY_SIMPLEX, 0.70, (0, 0, 255), 2)
    #
	# 	text1 = "Total abnormal violations: {}".format(len(abnormal))
	# 	cv2.putText(frame, text1, (10, frame.shape[0] - 25),
	# 		cv2.FONT_HERSHEY_SIMPLEX, 0.70, (0, 255, 255), 2)
    #
	# #------------------------------Alert function----------------------------------#
    #
	# 	if len(serious) >= config.Threshold:
	# 		cv2.putText(frame, "-ALERT: Violations over limit-", (10, frame.shape[0] - 80),
	# 			cv2.FONT_HERSHEY_COMPLEX, 0.60, (0, 0, 255), 2)
	# 		if config.ALERT:
	# 			print("")
	# 			print('[INFO] Sending mail...')
	# 			Mailer().send(config.MAIL)
	# 			print('[INFO] Mail sent')
			#config.ALERT = False
	#------------------------------------------------------------------------------#

		cv2.imshow("Real-Time Monitoring/Analysis Window", frame)

		if cv2.waitKey(1) & 0xFF == 27:
			break
		# check to see if the output frame should be displayed to our screen
		# if args["display"] > 0:
		# 	# show the output frame
		# 	cv2.imshow("Real-Time Monitoring/Analysis Window", frame)
		# 	key = cv2.waitKey(1) & 0xFF
		#
		# 	# if the `q` key was pressed, break from the loop
		# 	if key == ord("q"):
		# 		break
		# update the FPS counter
		# fps.update()
		#
		# # if an output video file path has been supplied and the video
		# # writer has not been initialized, do so now
		# if args["output"] != "" and writer is None:
			# # initialize our video writer
			# fourcc = cv2.VideoWriter_fourcc(*"MJPG")
			# writer = cv2.VideoWriter(args["output"], fourcc, 25,
			# 	(frame.shape[1], frame.shape[0]), True)

		# if the video writer is not None, write the frame to the output video file
		# if writer is not None:
		# 	writer.write(frame)

	# stop the timer and display FPS information
	# fps.stop()
	# print("===========================")
	# print("[INFO] Elasped time: {:.2f}".format(fps.elapsed()))
	# print("[INFO] Approx. FPS: {:.2f}".format(fps.fps()))

	# close any open windows
	cv2.destroyAllWindows()

sd()
# def ff():
#
#    start_new_thread(sd, ())
#    # start_new_thread( mask_image,())
#
#
#
#
# ff()