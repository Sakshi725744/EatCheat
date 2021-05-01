import RPi.GPIO as GPIO 
GPIO.setwarnings(False) 
GPIO.setmode(GPIO.BOARD) 
GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(11, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

from datetime import datetime,date
from picamera import PiCamera
from time import sleep
import os
import pyrebase
import firebase_admin
from firebase_admin import credentials, firestore, storage

config = {
    'apiKey': "AIzaSyB01dl3AHDjcHTGH1sxqOfAdVKXDKIhKLY",
    'authDomain': "frizzy-f3e0d.firebaseapp.com",
    'databaseURL': "https://frizzy-f3e0d-default-rtdb.firebaseio.com",
    'projectId': "frizzy-f3e0d",
    'storageBucket': "frizzy-f3e0d.appspot.com",
    'messagingSenderId': "761244762063",
    'appId': "1:761244762063:web:e11e681829fa41edb11cba",
    'measurementId': "G-YXKKCSEN98"
}
cred=credentials.Certificate('path_to_json.json')

firebase_admin.initialize_app(cred, {
    'apiKey': "AIzaSyB01dl3AHDjcHTGH1sxqOfAdVKXDKIhKLY",
    'authDomain': "frizzy-f3e0d.firebaseapp.com",
    'databaseURL': "https://frizzy-f3e0d-default-rtdb.firebaseio.com",
    'projectId': "frizzy-f3e0d",
    'storageBucket': "frizzy-f3e0d.appspot.com",
    'messagingSenderId': "761244762063",
    'appId': "1:761244762063:web:e11e681829fa41edb11cba",
    'measurementId': "G-YXKKCSEN98"})

db = firestore.client()

firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
auth = firebase.auth()

email = "example@gmail.com"
password = "abcd1234"
camera = PiCamera()

while True: 
  try:
    if GPIO.input(10) == GPIO.HIGH:
        print("food pushed")
        now = datetime.now()
        dt = now.strftime("%d%m%Y%H:%M:%S")
        food = dt+".jpg"
        camera.capture(food)
        print(food+" saved")
        storage.child(food).put(food)
        user = auth.sign_in_with_email_and_password(email, password)
        url = storage.child("fried.jpeg").get_url(user['idToken'])
        print(url)
        image = {'img':url,'addedOn': str(date.today())}
        db.collection('images').add(image)
        print("Image sent")
        os.remove(food)
        print("File Removed")
        sleep(2)
    elif GPIO.input(11) == GPIO.HIGH:
        print("barcode pushed")
        now = datetime.now()
        dt = now.strftime("%d%m%Y%H:%M:%S")
        barcode = dt+".jpg"
        camera.capture(barcode)
        print(barcode+" saved")
        storage.child(barcode).put(barcode)
        user = auth.sign_in_with_email_and_password(email, password)
        url = storage.child(barcode).get_url(user['idToken'])
        print(url)
        image = {'img':url,'addedOn': str(date.today())}
        db.collection('barcodes').add(image)
        print("Image sent")
        os.remove(barcode)
        print("File Removed")
        sleep(2)
  except:
        camera.close()
	
