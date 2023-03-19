<template>
    <div>
        <v-card
            v-for="articleComment in articleComments"
            :key="articleComment.id"
            width="80%"
            class="mr-auto mt-5 pa-3"
        >
            <div
                class="d-flex"
            >
                <div>
                    <AvatarSwitch
                        :id="articleComment.user.id"
                        :avatar-url="articleComment.user.avatar.url"
                    />
                </div>
                <div class="ml-5">
                    <p class="ma-0">{{ articleComment.user.nickname }}</p>
                    <p class="text-caption">作成日:{{ $my.dataFormat(articleComment.created_at) }}</p>
                </div>
                <div v-if="currentUser.id === articleComment.user.id"
                    class="ml-auto"
                >
                    <v-menu
                        app
                        offset-x
                        offset-y
                        max-width="300"
                    >
                        <template
                            #activator="{ on }"
                        >
                            <v-btn
                                icon
                                v-on="on"
                            >
                                <v-icon size="25">
                                    mdi-dots-vertical
                                </v-icon>
                            </v-btn>
                        </template>
                        <v-list
                            dense
                        >
                            <v-dialog
                                v-model="dialog"
                                max-width="290"
                            >
                                <template #activator="{ on, attrs }">
                                    <v-list-item
                                        v-bind="attrs"
                                        v-on="on"
                                    >
                                        <v-list-item-icon
                                            class="mr-2"
                                        >
                                            <v-icon
                                                size="22"
                                            >
                                                mdi-trash-can-outline
                                            </v-icon>
                                        </v-list-item-icon>
                                        <v-list-item-title>
                                            削除する
                                        </v-list-item-title>
                                    </v-list-item>
                                </template>
                                <v-card>
                                    <v-card-title class="text-h5">
                                        コメントを削除します
                                    </v-card-title>
                                    <v-card-text>
                                        本当によろしいですか？<br />
                                    </v-card-text>
                                    <v-card-actions>
                                        <v-spacer />
                                        <v-btn
                                            color="blue"
                                            text
                                            @click="dialog = false"
                                        >
                                            キャンセル
                                        </v-btn>
                                        <v-btn
                                            color="red"
                                            text
                                            @click="commentDelete(articleComment.id)"
                                        >
                                            削除する
                                        </v-btn>
                                    </v-card-actions>
                                </v-card>
                            </v-dialog>
                        </v-list>
                    </v-menu>
                </div>
            </div>
            <p>{{ articleComment.content }}</p>
        </v-card>
    </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import AvatarSwitch from '~/components/Molecules/AvatarSwitch.vue'

export default {
    components: {
        AvatarSwitch,
    },
    data() {
        return {
            avatarUrl: '',
            dialog: false
        }
    },
    computed: {
        ...mapGetters({
            currentUser: 'modules/user/getUser',
            articleComments: 'modules/comment/getArticleComment',
        })
    },
    methods: {
        ...mapMutations({
            commitDeleteArticleComment: 'modules/comment/setDeleteArticleComment'
        }),
        async commentDelete(commentId) {
            await this.$axios.$delete(`/api/v1/articles/${this.$route.params.id}/comments/${commentId}`)
                .then(res => {
                    this.commitDeleteArticleComment(commentId)
                    this.$my.dispatchToast(true, 'コメントを削除しました', 'success')
                })
                .catch(err => {
                    console.log(err)
                })
            this.dialog = false
        }
    }
}
</script>