// import { auth } from "../plugins/firebase-admin";
import { getAuth } from "firebase/auth"

// import admin from "firebase-admin";
// import jwtDecode from 'jwt-decode'
// import cookieparser from 'cookie-parser'
// const cookieParser = require('cookie-parser')
const cookieParser = require('cookieparser')

export function getUserFromCookie(req) {


    // console.log('level1---------')
    if (process.server && process.static) return
    // console.log('level2---------')
    if (!req.headers.cookie) return

    // console.log('level3---------')
    if (req.headers.cookie) {
        // console.log('level4---------')
        const parsed = cookieParser.parse(req.headers.cookie)
        // console.log('level5---------')
        // console.log(parsed)
        const accessTokenCookie = parsed.access_token
        console.log('level6---------')
        // console.log(accessTokenCookie)
        if (!accessTokenCookie) return

        // console.log('level7---------')
        // console.log(accessTokenCookie)
        // const decodeToken = jwtDecode(accessTokenCookie)
        // auth()
        getAuth().verifyIdToken(accessTokenCookie)
            .then((decodedToken) => {
                // const uid = decodedToken.uid;
                console.log('ここにdecode出力')
                console.log(decodedToken)

                // console.log('level8---------')
                if(!decodedToken) return

                // console.log('level9---------')
                // console.log(decodeToken)
                return decodedToken
            })
            .catch((error) => {
                // Handle error
                console.log(error)
            });
        // console.log('level8---------')
        // if(!decodeToken) return

        // console.log('level9---------')
        // console.log(decodeToken)
        // return decodeToken
    }
}

export function getUserFromSession(req) {
    return req.session ? req.session.userId : null
}
