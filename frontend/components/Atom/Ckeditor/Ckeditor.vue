<template>
    <div class="ckeditor ck-content-a">
        <ckeditor
            v-model="setRichText"
            :editor="editor"
            :config="editorConfig"
            class="ckeditor"
        >
        </ckeditor>
    </div>
</template>

<script>
import CKEditor from '@ckeditor/ckeditor5-vue2'
// import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import ClassicEditor from '@ckeditor/ckeditor5-build-balloon';


export default {
    name: 'CkEditor',
    components: { ckeditor: CKEditor.component },
    props: {
        text: {
            type: String,
            default: ''
        }
    },
    // props: ['text'],
    data() {

        // return { ckeditorValue, ckeditorConfig, ckeditorReady };
        return {
            editor: ClassicEditor,
            editorData: '<p>Content of the editor.</p>',
            editorConfig: {
                toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote'],
                heading: {
                    options: [
                        { model: 'paragraph', title: '見出し', class: 'ck-heading_paragraph' },
                        { model: 'heading1', view: 'h1', title: '大見出し', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: 'h2', title: '小見出し', class: 'ck-heading_heading2' }
                    ]
                },
                // language: 'ja',
            },
        }
    },
    computed: {
        setRichText: {
            get() {
                return this.text
            },
            set(newVal) {
                this.$emit('update:text', newVal)
            }
        }
    }
};

// get() { return this.email },
//             set(newVal) { return this.$emit('update:email',newVal)}
</script>

<style lang="scss" scoped>
.ckeditor {
    width: 100%;
    max-width: 800px;
    height: 500px;
    margin: 0 auto;
    border: 1px solid #9E9E9E;
}

.ck.ck-editor__editable > .ck-placeholder::before {
    color: #d21714;
    font-family: Georgia;
}

</style>