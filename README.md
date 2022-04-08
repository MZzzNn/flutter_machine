# Flutter Machine App



This project help flutter developers to make simple machine learning App 
to classify anything by two options `(tflite  & firebase_ml_vision)` Package.

> **Machine learning** is a branch of Artificial Intelligence, helps systems to learn from experience like human beings. They learn from data and predict the output and improve themselves.

<p align="center">
<img src="assets/images/app.gif" width="200" alt="after Video Call">
</p>

## 1. Local Machine Model Using tflite Package

### Overview
- Go to [Kaggle](https://www.kaggle.com/) and download Cat and Dog datasets.
- Using the datasets, Make model using Google teachable machine
    - Go to [teachable machine](https://teachablemachine.withgoogle.com/) and Get Started.
    - Select image project & Standard Image Model.
    - create your classes' ex: `Class 1 to Dog, and Class 2 to Cat` and upload images to each class.
    - Train Model.
    - Export Model and Download it.
- Create new flutter project.
    - Add your model to your assets `labels.txt and model_unquant.tflite`..
    - Use this package [tflite](https://pub.dev/packages/tflite) Tensorflow lite package.


## 2. FireBase Using firebase_ml_vision Package

### Overview
<!-- - Go to [Firebase console](https://console.firebase.google.com/) and create new project.
    - Add Firebase to your Android or IOS project.
    - Go to machine learning and add your custom model.
-->
- Use this package [firebase_ml_vision](https://pub.dev/packages/firebase_ml_vision).

