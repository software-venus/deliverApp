importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
	apiKey : "AIzaSyDy-wZBBYCQPeytgBPjL6ZtI6tsOvto09E" , 
	authDomain : "delivertrackapp.firebaseapp.com" , 
	projectId : "delivertrackapp" , 
	storageBucket : "delivertrackapp.firebasestorage.app" , 
	messagingSenderId : "443709792692" , 
	appId : "1:443709792692:web:3b8d76ffb2d2e1bfc152e1" , 
	measurementId : "G-SEB02BM0PJ" 
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});