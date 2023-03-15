export const state = () => ({
    notifications: [],
    notificationHeader: [],
})

export const getters = {
    getNotifications(state) {
        return state.notifications
    },

    getNotificationHeader(state) {
        return state.notificationHeader
    },
}

export const actions = {
    getNotifications({ commit }, notifications ) {
        commit('setNotifications', notifications )
    },

    getNotificationHeader({ commit }, notificationHeader ) {
        commit('setNotificationHeader', notificationHeader )
    },
}


export const mutations = {
    setNotifications (state, payload) {
        state.notifications = payload
    },

    setNotificationsUpdate (state, payload) {
        const id = Number(payload)
        const result = state.notifications.map(notification => {
            if (notification.id === id) {
                notification.checked = true
            }
            return notification
        })
        state.notifications = result
    },

    setNotificationsAllUpdate (state) {
        const result = state.notifications.map(notification => {
                notification.checked = true
                return notification
        })
        state.notifications = result
    },


    setNotificationHeader (state, payload) {
        state.notificationHeader = payload
    },

    setNotificationHeaderUpdate (state, payload) {
        const id = Number(payload)
        const result = state.notificationHeader.map(notificationHeader => {
            if (notificationHeader.id === id) {
                notificationHeader.checked = true
            }
            return notificationHeader
        })
        state.notificationHeader = result
    },

    setNotificationHeaderAllUpdate (state) {
        const result = state.notificationHeader.map(notificationHeader => {
            notificationHeader.checked = true
            return notificationHeader
        })
    },
}