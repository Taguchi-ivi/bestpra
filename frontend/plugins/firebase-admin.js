import admin from 'firebase-admin';

if (!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert({
            project_id: process.env.projectId,
            private_key: process.env.privateKey.replace(/\\n/g, '\n'),
            client_email: process.env.clientEmail,
        }),
        databaseURL: '<my database url, removed for this post>',
    });
}

const auth = admin.auth();

export { auth };