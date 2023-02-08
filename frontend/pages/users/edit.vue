<template>
    <v-container>
        <div class="mt-8" />

        <!-- <v-form v-model="valid"> -->
        <v-card
            class="mx-auto"
            max-width="800"
            color="transparent"
            flat
        >
            <v-form>
                <v-row
                    no-gutters
                >
                    <v-col
                        cols="3"
                        class="d-flex"
                    >
                        <v-avatar
                            color="indigo"
                            class="align-self-center"
                            >
                            <v-icon dark>
                                mdi-account-circle
                            </v-icon>
                        </v-avatar>
                    </v-col>
                    <v-col
                        cols="9"
                    >
                        <!-- v-model="nickname" -->
                        <!-- :rules="nameRules" -->
                        <v-text-field
                            color="indigo"
                            :value="name"
                            :counter="20"
                            label="ニックネーム"
                            required
                        >
                        </v-text-field>
                        <v-textarea
                            color="indigo"
                            name="input-7-1"
                            label="自己紹介"
                            :value="introduction"
                            hint="自己紹介文"
                            auto-grow
                            counter="256"
                        >
                        </v-textarea>
                    </v-col>
                </v-row>
                <!-- :rules="emailRules" -->
                <!-- v-model="email" -->
                <div class="mt-8" />
                <v-card
                    max-width="400"
                    class="mx-auto"
                    color="transparent"
                    flat
                >
                    <div class="mb-8">
                        <!-- <div class="mb-6">
                            Active picker: <code>{{ activePicker || 'null' }}</code>
                        </div> -->
                        <v-menu
                            ref="menu"
                            v-model="menu"
                            :close-on-content-click="false"
                            transition="scale-transition"
                            offset-y
                            min-width="auto"
                        >
                            <template #activator="{ on, attrs }">
                                <v-text-field
                                    v-model="date"
                                    color="indigo"
                                    label="Birthday date"
                                    prepend-icon="mdi-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                >
                                </v-text-field>
                            </template>
                            <v-date-picker
                                v-model="date"
                                color="indigo"
                                :active-picker.sync="activePicker"
                                :max="(new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10)"
                                min="1950-01-01"
                                @change="save"
                            >
                            </v-date-picker>
                        </v-menu>
                    </div>
                    <v-text-field
                        color="indigo"
                        label="E-mail"
                        :value="email"
                        required
                    >
                    </v-text-field>
                </v-card>
                <div
                    class="d-flex justify-end"
                >
                <!-- :disabled="!valid" -->
                    <v-btn
                        dark
                        color="indigo"
                        class="mr-4"
                        @click="updateUser"
                    >
                        保存
                    </v-btn>
                </div>
            </v-form>
        </v-card>
        <template v-if="false">
            {{ defaultUser }}
        </template>
    </v-container>
</template>

<script>
export default {
    data() {
        return {
            name: 'meron',
            introduction: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            email: 'test@test.com',
            valid: false,
            activePicker: null,
            date: null,
            menu: false,
            defaultUser: {
                nickname: '',
                introduction: '',
                avatar: '',
                birthday: '',
                email: ''
            },
            // updateUser: {
            //     nickname: '',
            //     introduction: '',
            //     avatar: '',
            //     birthday: '',
            //     email: ''
            // }
        }
    },
    watch: {
        menu (val) {
            val && setTimeout(() => (this.activePicker = 'YEAR'))
        },
    },
    methods: {
        updateUser() {

        },
        save (date) {
            this.$refs.menu.save(date)
        },
    },
}
</script>