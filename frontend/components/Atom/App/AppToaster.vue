
<template>
    <v-snackbar
        v-model="setSnackbar"
        transition="slide-x-reverse-transition"
        class="toaster"
        right
        top
        text
        :color="toast.color"
        :timeout="toast.timeout"
    >
        <div class="ml-5 font-weight-bold">
            {{ toast.msg }}
        </div>
        <template #action="{ attrs }">
            <v-btn
                v-bind="attrs"
                :color="toast.color"
                @click="resetToast"
                icon
            >
                <v-icon>
                    mdi-alpha-x-circle
                </v-icon>
            </v-btn>
        </template>
    </v-snackbar>
</template>

<script>

import { mapGetters } from 'vuex'

export default {
    computed: {
        ...mapGetters({
            toast: 'modules/toast/getToast'
        }),
        setSnackbar: {
            get () { return this.toast.status },
            // (val)にはfalseが返ってくる（Vuetifyのv-snackbarの仕様）
            // set()内で return false を行うと、トースターが閉じる
            // return falseの前に、Vuexのtoast.msgをnullにリセットしている
            set (val) { return this.resetToast() && val }
        }
    },
    beforeDestroy () {
        // Vueインスタンスが破棄される直前にVuexのtoast.msgを削除する(無期限toastに対応)
        this.resetToast()
    },
    methods: {
        // Vuexのtoast.msgの値を変更する
        resetToast () {
            return this.$my.dispatchToast(false, null, null)
        }
    }
}
</script>

<style lang="scss" scoped>
.toaster {
    position: fixed;
    z-index: 9999;
}
</style>