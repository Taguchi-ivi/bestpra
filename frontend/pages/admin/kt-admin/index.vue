<template>
    <v-container>
        <v-card
            class="pa-3"
        >
            <MainTitle title="user関連" />
            <v-simple-table
                fixed-header
                height="300px"
            >
                <template #default>
                    <thead>
                        <tr>
                            <th class="text-left">
                                id
                            </th>
                            <th class="text-left">
                                Name
                            </th>
                            <th class="text-left">
                                Calories
                            </th>
                            <th class="text-left">
                                delete
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="item in desserts"
                            :key="item.name"
                        >
                            <td>{{ item.id }}</td>
                            <td>{{ item.name }}</td>
                            <td>{{ item.calories }}</td>
                            <td>
                                <v-btn
                                    icon
                                >
                                    <v-icon>
                                        mdi-trash-can-outline
                                    </v-icon>
                                </v-btn>
                            </td>
                        </tr>
                    </tbody>
                </template>
            </v-simple-table>
            <v-form
                class="mt-10"
            >
                <v-text-field
                    label="Your product or service"
                    hint="For example, flowers or used cars"
                    outlined
                >
                </v-text-field>
                <div class="text-right">
                    <v-btn
                        dark
                        color="primary"
                    >
                        userへ連絡
                    </v-btn>
                </div>
            </v-form>
        </v-card>
        <v-card
            class="pa-3 mt-8"
        >
            <MainTitle title="Tagマスタ情報の修正" />
            <v-simple-table
                fixed-header
                height="300px"
            >
                <template #default>
                    <thead>
                        <tr>
                            <th class="text-left">
                                id
                            </th>
                            <th class="text-left">
                                Name
                            </th>
                            <th class="text-left">
                                Calories
                            </th>
                            <th class="text-left">
                                delete
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="item in desserts"
                            :key="item.name"
                        >
                            <td>{{ item.id }}</td>
                            <td>{{ item.name }}</td>
                            <td>{{ item.calories }}</td>
                            <td>
                                <v-btn
                                    icon
                                >
                                    <v-icon>
                                        mdi-trash-can-outline
                                    </v-icon>
                                </v-btn>
                            </td>
                        </tr>
                    </tbody>
                </template>
            </v-simple-table>
            <v-form
                class="mt-10"
            >
                <v-text-field
                    label="Your product or service"
                    hint="For example, flowers or used cars"
                    outlined
                >
                </v-text-field>
                <div class="text-right">
                    <v-btn
                        dark
                        color="primary"
                    >
                        タグ追加
                    </v-btn>
                </div>
            </v-form>
        </v-card>
        <v-card
            class="pa-3 mt-8"
        >
            <MainTitle title="Levelマスタ情報の修正" />
            <v-simple-table
                fixed-header
                height="300px"
            >
                <template #default>
                    <thead>
                        <tr>
                            <th class="text-left">
                                id
                            </th>
                            <th class="text-left">
                                Name
                            </th>
                            <th class="text-left">
                                Calories
                            </th>
                            <th class="text-left">
                                delete
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="item in desserts"
                            :key="item.name"
                        >
                            <td>{{ item.id }}</td>
                            <td>{{ item.name }}</td>
                            <td>{{ item.calories }}</td>
                            <td>
                                <v-btn
                                    icon
                                >
                                    <v-icon>
                                        mdi-trash-can-outline
                                    </v-icon>
                                </v-btn>
                            </td>
                        </tr>
                    </tbody>
                </template>
            </v-simple-table>
            <v-form
                class="mt-10"
            >
                <v-text-field
                    label="Your product or service"
                    hint="For example, flowers or used cars"
                    outlined
                >
                </v-text-field>
                <div class="text-right">
                    <v-btn
                        dark
                        color="primary"
                    >
                        level追加
                    </v-btn>
                </div>
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
    data() {
        return {
            desserts: [
                    {
                        id: 1,
                        name: 'Frozen Yogurt',
                        calories: 159,
                    },
                    {
                        id: 2,
                        name: 'Ice cream sandwich',
                        calories: 237,
                    },
                    {
                        id: 3,
                        name: 'Eclair',
                        calories: 262,
                    },
                    {
                        id: 4,
                        name: 'Cupcake',
                        calories: 305,
                    },
                    {
                        id: 5,
                        name: 'Gingerbread',
                        calories: 356,
                    },
                    {
                        id: 6,
                        name: 'Jelly bean',
                        calories: 375,
                    },
                    {
                        id: 7,
                        name: 'Lollipop',
                        calories: 392,
                    },
                    {
                        id: 8,
                        name: 'Honeycomb',
                        calories: 408,
                    },
                    {
                        id: 9,
                        name: 'Donut',
                        calories: 452,
                    },
                    {
                        id: 10,
                        name: 'KitKat',
                        calories: 518,
                    },
                ],
            }
        }
    // middleware: {
    //     // admin権限保持者のみの制御
    // }
}
</script>