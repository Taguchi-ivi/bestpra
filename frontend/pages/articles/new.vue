<template>
    <div>
        <!-- <client-only>
            <Ckeditor v-model="html" />
        </client-only> -->
        <client-only>
            <!-- <v-ckeditor v-model="text" /> -->
            <Ckeditor v-model="text" />
        </client-only>
        <pre>
            <!-- {{ html }} -->
            {{ text }}
        </pre>

    </div>
</template>

<script>
// import Ckeditor from '~/components/Ckeditor.vue'

export default {
    // components: {
    //     Ckeditor,
    // },
    data() {
        return {
            // html: '',
            text: 'hello world'
        }
    }
};
</script>