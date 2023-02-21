<template>
    <!-- TODO  -->
    <!-- avatarが存在しない場合はiconを -->
    <!-- flgがtrueなら押下時に下に値を表示 -->
    <!-- trueではない場合はシンプルにlinkを作成してその人のprofileページへ -->
    <!-- <h1>avatarのcomponentを作成したい</h1> -->
    <div>
        <div v-if="avatar.url">
            <v-img
                :src="avatar.url"
            >

            </v-img>
        </div>
        <div v-else>
            <v-avatar
                color="indigo"
                class="align-self-center"
                :size="size"
                >
                <v-icon dark>
                    mdi-account-circle
                </v-icon>
            </v-avatar>
        </div>
    </div>
</template>

<script>

export default {
    props: {
        size: {
            type: Number,
            default: 33
        },
        avatar: {
            type: Array,
            default: {}
        }
    },
}
</script>