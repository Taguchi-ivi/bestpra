<template>
    <v-navigation-drawer
        v-model="setDrawer"
        app
        clipped
        :mobile-breakpoint="mobileBreakPoint"
    >
        <margin-top />
        <v-list>
            <!-- close botton -->
            <template
                v-if="isMoblieBreakpointLessThan"
            >
                <v-list-item
                    @click="$emit('update:drawer', false)"
                >
                    <!-- class="text-center" -->
                    <v-list-item-content
                    >
                        <!-- class="d-flex justify-center align-center" -->
                        <v-list-item-action-text
                        >
                            <v-icon>
                                mdi-chevron-double-left
                            </v-icon>
                            閉じる
                        </v-list-item-action-text>
                    </v-list-item-content>
                </v-list-item>
                <v-divider />
            </template>

            <!-- nav menus -->
            <!-- <v-list-item
                v-for="(nav, i) in navMenus"
                :key="`nav-${i}`"
                :to="nav.id"
            >
                <v-list-item-icon>
                    <v-icon>
                        {{ nav.icon }}
                    </v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                <v-list-item-title> -->
                    <!-- {{ $my.pageTitle(nav.name) }} -->
                    <!-- {{ nav.name }}
                </v-list-item-title>
                </v-list-item-content>
            </v-list-item> -->
            <v-treeview
                rounded
                hoverable
                activatable
                :items="items"
            >
            </v-treeview>
        </v-list>
    </v-navigation-drawer>
</template>

<script>
import marginTop from '~/components/Atom/margin/marginTop.vue'
    export default {
        components: {
            marginTop
        },
        props: {
            drawer: {
                type: Boolean,
                default: null
            }
        },
        data() {
            return {
                mobileBreakPoint: 960,
                // navMenus: [
                //     { name: 'home', icon: 'mdi-view-dashboard', id: '#' },
                //     { name: 'project-id-layouts', icon: 'mdi-view-compact', id: '#' },
                //     { name: 'project-id-pages', icon: 'mdi-image', id: '#' },
                //     { name: 'project-id-components', icon: 'mdi-view-comfy', id: '#' },
                //     { name: 'project-id-settings', icon: 'mdi-cog', id: '#' },
                //     { name: 'project-id-help', icon: 'mdi-help-circle', id: '#' }
                // ]
                items: [
                    {
                    id: 1,
                    name: 'Applications :',
                    children: [
                        { id: 2, name: 'Calendar : app' },
                        { id: 3, name: 'Chrome : app' },
                        { id: 4, name: 'Webstorm : app' },
                    ],
                    },
                    {
                    id: 5,
                    name: 'Documents :',
                    children: [
                        {
                        id: 6,
                        name: 'vuetify :',
                        children: [
                            {
                            id: 7,
                            name: 'src :',
                            children: [
                                { id: 8, name: 'index : ts' },
                                { id: 9, name: 'bootstrap : ts' },
                            ],
                            },
                        ],
                        },
                        {
                        id: 10,
                        name: 'material2 :',
                        children: [
                            {
                            id: 11,
                            name: 'src :',
                            children: [
                                { id: 12, name: 'v-btn : ts' },
                                { id: 13, name: 'v-card : ts' },
                                { id: 14, name: 'v-window : ts' },
                            ],
                            },
                        ],
                        },
                    ],
                    },
                    {
                    id: 15,
                    name: 'Downloads :',
                    children: [
                        { id: 16, name: 'October : pdf' },
                        { id: 17, name: 'November : pdf' },
                        { id: 18, name: 'Tutorial : html' },
                    ],
                    },
                    {
                    id: 19,
                    name: 'Videos :',
                    children: [
                        {
                        id: 20,
                        name: 'Tutorials :',
                        children: [
                            { id: 21, name: 'Basic layouts : mp4' },
                            { id: 22, name: 'Advanced techniques : mp4' },
                            { id: 23, name: 'All about app : dir' },
                        ],
                        },
                        { id: 24, name: 'Intro : mov' },
                        { id: 25, name: 'Conference introduction : avi' },
                    ],
                    },
                ],
            }
        },
        computed: {
            setDrawer: {
                get(){ return this.drawer },
                set(newVal){ return this.$emit('update:drawer', newVal )}
            },
            isMoblieBreakpointLessThan() {
                const windowWidth = this.$vuetify.breakpoint.width
                return this.mobileBreakPoint > windowWidth
            }
        }
    }
</script>