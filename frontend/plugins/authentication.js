import firebaseApp from '@/plugins/firebase'
import { getAuth, onAuthStateChanged } from 'firebase/auth'

export default function ({ route, redirect }){
    const auth = getAuth();
    onAuthStateChanged(auth, (user) => {
        if (user) {
            // User is signed in, see docs for a list of available properties
            // https://firebase.google.com/docs/reference/js/firebase.User
            const uid = user.uid;
            // ...
        } else {
            // User is signed out
            // ...
            if(route.path !== '/auth/signin') {
                redirect('/auth/signin')
            }
        }
    });

}

