// Import the functions you need from the SDKs you need
// import { getAuth } from "firebase/auth";
// import { getAnalytics } from "firebase/analytics";
// import { initializeApp, getApps, getApp } from "firebase/app";
// import { getAuth } from "firebase/auth";
// // import firebase from 'firebase'

import { initializeApp } from 'firebase/app'

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries


// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: process.env.ApiKey,
    authDomain: process.env.authDomain,
    projectId: process.env.projectId,
    // storageBucket: process.env.storageBucket,
    // messagingSenderId: process.env.messagingSenderId,
    // appId: process.env.appId,
    // measurementId: process.env.measurementId
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);

// const getFirebaseApp = () => {
//     if(getApps().length === 0) {
//         return initializeApp(firebaseConfig);
//     } else {
//         return getApp();
//     }
// };
// const app = getFirebaseApp();
// export const auth = getAuth(app);

// if(!firebase.apps.length) {
//     firebase.initializeApp(firebaseConfig)
// }

// export const auth = firebase.auth
// export default firebase

