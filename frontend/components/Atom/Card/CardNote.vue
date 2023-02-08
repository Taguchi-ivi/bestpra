<template>
    <v-row>
        <!-- v-for="n in 12"
        rounded="tl-xl"
        :key="n" -->
        <v-col
            v-for="n in 12"
            :key="n"
            class="d-flex justify-center"
        >
            <nuxt-link
                to="/"
            >
                <div class="note">
                    <!-- <v-card
                        max-width="300"
                        to="/" nuxt
                        hover
                    >
                        <v-card
                            color="grey lighten-1"
                            height="100px"
                        >
                        </v-card>
                        <v-card-title>
                            this.title
                        </v-card-title>
                        <v-card-subtitle>
                            作成日: 2023/02/06
                        </v-card-subtitle>
                    </v-card> -->
                    <!-- tile -->
                    <v-card
                        class="mt-15 note-mb"
                    >
                        <v-card-title>
                            this.title
                        </v-card-title>
                        <v-card-subtitle>
                            作成日: 2023/02/06
                        </v-card-subtitle>

                    </v-card>
                </div>
            </nuxt-link>
        </v-col>
    </v-row>
</template>

<style lang="scss" scoped>

.note {
    background: #7986CB;
	width: 200px;
	height: 170px;
	margin: 50px 20px;
    box-sizing: content-box;
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
        border-left: solid 40px transparent;
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