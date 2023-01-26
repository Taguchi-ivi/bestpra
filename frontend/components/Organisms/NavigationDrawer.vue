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
                v-if="isBreakpoint"
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
            <v-list-item
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
                <v-list-item-title>
                    <!-- {{ $my.pageTitle(nav.name) }} -->
                    {{ nav.name }}
                </v-list-item-title>
                </v-list-item-content>
            </v-list-item>
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
                navMenus: [
                    { name: 'home', icon: 'mdi-view-dashboard', id: '#' },
                    { name: 'project-id-layouts', icon: 'mdi-view-compact', id: '#' },
                    { name: 'project-id-pages', icon: 'mdi-image', id: '#' },
                    { name: 'project-id-components', icon: 'mdi-view-comfy', id: '#' },
                    { name: 'project-id-settings', icon: 'mdi-cog', id: '#' },
                    { name: 'project-id-help', icon: 'mdi-help-circle', id: '#' }
                ]
            }
        },
        computed: {
            setDrawer: {
                get(){ return this.drawer },
                set(newVal){ return this.$emit('update:drawer', newVal )}
            },
            isBreakpoint() {
                const windowWidth = this.$vuetify.breakpoint.width
                return this.mobileBreakPoint > windowWidth
            }
        }
    }
</script>