<template>
    <v-row>
        <v-col
            v-for="n in 12"
            :key="n"
            class="d-flex justify-center"
        >
            <nuxt-link
                to="/"
            >
                <div class="tag">
                    <v-card
                        class="mt-15 tag-mb"
                    >
                    <v-card-title>
                        タグ.name
                    </v-card-title>
                        <div
                            class="d-flex justify-end mb-2"
                        >
                            <div
                                class="mr-3"
                            >
                                <span class="subheading">256件の投稿</span>
                            </div>
                        </div>
                    </v-card>
                </div>
            </nuxt-link>
        </v-col>
    </v-row>
</template>

<style lang="scss" scoped>

.tag {
    background: #7986CB;
	width: 230px;
	height: 250px;
	margin: 50px 20px;
    box-sizing: content-box;
    transition: .3s;
	position: relative;

    &:before {
        width: calc(100% - 40px);
        height: 0;
        display: block;
        position: absolute;
        left: 0;
        content: "";
    }

    &:before {
        border-bottom: solid 40px #7986CB;
        border-right: solid 40px transparent;
        bottom: 100%;
    }
    &:hover {
        box-shadow: 0 15px 30px -5px rgba(0,0,0,.15), 0 0 5px rgba(0,0,0,.1);
        transform: translateY(-4px);
    }

    &-mb {
        width: 100%;
        position: absolute;
        bottom: 0;
    }

}
</style>