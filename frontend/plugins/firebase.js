// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// import { getAuth } from "firebase/auth";
// import { getAnalytics } from "firebase/analytics";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//     apiKey: process.env.FIREBASE_API_KEY,
//     authDomain: process.env.FIREBASE_AUTH_DOMAIN,
//     projectId: process.env.FIREBASE_PROJECTID,
//     storageBucket: process.env.FIREBASE_STORAGEBUCKET,
//     messagingSenderId: process.env.FIREBASE_MESSAGINGSENDERID,
//     appId: process.env.FIREBASE_APPID,
//     measurementId: process.env.FIREBASE_MEASUREMENTID
// };
const firebaseConfig = {
    apiKey: "AIzaSyAY_3Si7KS5mPYz7a1pilG6vbFqLuNVz0o",
    authDomain: "bestpra-auth.firebaseapp.com",
    projectId: "bestpra-auth",
    storageBucket: "bestpra-auth.appspot.com",
    messagingSenderId: "1036427310673",
    appId: "1:1036427310673:web:9731c3873564a966fc6a70",
    measurementId: "G-DJD4Y5RVW6"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);