import jwtDecode from 'jwt-decode'
// import cookieparser from 'cookie-parser'
// const cookieParser = require('cookie-parser')
const cookieParser = require('cookieparser')

export function getUserFromCookie(req) {
    if (process.server && process.static) return
    if (!req.headers.cookie) return

    if (req.headers.cookie) {
        const parsed = cookieParser.parse(req.headers.cookie)
        const accessTokenCookie = parsed.access_token
        if (!accessTokenCookie) return

        const decodeToken = jwtDecode(accessTokenCookie)
        if(!decodeToken) return

        // console.log(decodeToken)
        return decodeToken
    }
}
