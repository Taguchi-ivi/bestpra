<template>
    <v-container>
        <v-card
            class="pa-5"
        >
            <MainTitle title="helpページ" />
            <v-alert
                type="info"
                color="indigo"
                text
            >
                <h5>日々サイトをご利用いただき、誠にありがとうございます。</h5>
                <p>
                    こちらでは改善点などをご意見として管理者に送信できる場所となります。<br />
                    またタグを追加して欲しいなどの要望も承ります。<br />
                    全てのご意見に対し真摯に向き合い、サイトの利便性向上に努めたいと思います。<br />
                </p>
            </v-alert>
            <v-form>
                <v-card
                    width="80%"
                    class="mx-auto"
                    flat
                    color="transparent"
                >
                    <v-combobox
                        v-model="select"
                        :items="items"
                        label="タイトル選択(自由記述可)"
                        color="indigo"
                        class="mt-8 pa-2"
                    >
                    </v-combobox>
                    <v-textarea
                        outlined
                        name="input-7-4"
                        label="ご意見/ご要望"
                        placeholder="〇〇な理由により「××」というタグが欲しいです！！"
                        color="indigo"
                        class="mt-8"
                    >
                    </v-textarea>
                    <div
                        class="text-right"
                    >
                        <v-btn
                            dark
                            color="indigo"
                        >
                            送信!!
                        </v-btn>
                    </div>
                </v-card>
            </v-form>
        </v-card>
    </v-container>
</template>

<script>
import MainTitle from '~/components/Atom/App/AppMainTitle.vue'

export default {
    components: {
        MainTitle
    },
    data () {
        return {
            select: '',
            items: [
                'タグを追加して欲しい',
                'レベルを追加して欲しい',
                '意見があります！',
                'その他',
            ],
        }
    },
}
</script>