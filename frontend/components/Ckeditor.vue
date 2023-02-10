<template>
    <!-- <ckeditor
        v-model="ckeditorValue"
        v-bind="ckeditorConfig"
        @ready="ckeditorReady"
    /> -->
    <div class="ckeditor">
        <ckeditor
            v-model="editorData"
            :editor="editor"
            :config="editorConfig"
            class="ckeditor"
        >
        </ckeditor>
    </div>
</template>

<script>
// --
import CKEditor from '@ckeditor/ckeditor5-vue2'
// import ClassicEditor from '@ckeditor/ckeditor5-editor-classic/src/classiceditor'
// import Bold from '@ckeditor/ckeditor5-basic-styles/src/bold'
// import Italic from '@ckeditor/ckeditor5-basic-styles/src/italic.js'
// import Underline from '@ckeditor/ckeditor5-basic-styles/src/underline'
// import Strikethrough from '@ckeditor/ckeditor5-basic-styles/src/strikethrough'
// // less Heading + Essentials plugin can't input the text
// import Heading from '@ckeditor/ckeditor5-heading/src/heading'
// import Essentials from '@ckeditor/ckeditor5-essentials/src/essentials'
// import ImageUpload from '@ckeditor/ckeditor5-image/src/imageupload'
// import ImageInsert from '@ckeditor/ckeditor5-image/src/imageinsert'
// import AutoImage from '@ckeditor/ckeditor5-image/src/autoimage'
// import Image from '@ckeditor/ckeditor5-image/src/image'
// import ImageResizeEditing from '@ckeditor/ckeditor5-image/src/imageresize/imageresizeediting'
// import ImageResizeHandles from '@ckeditor/ckeditor5-image/src/imageresize/imageresizehandles'
// import Base64UploadAdapter from '@ckeditor/ckeditor5-upload/src/adapters/base64uploadadapter'

// --
// import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import ClassicEditor from '@ckeditor/ckeditor5-build-balloon';

// import CKeditor from '@ckeditor/ckeditor5-build-classic';
// import "@ckeditor/ckeditor5-build-classic/build/translations/ja.js";

export default {
    name: 'CkEditor',
    components: { ckeditor: CKEditor.component },
    props: {
        value: {
            type: String,
            default: ''
        }
    },
    data() {
        //     const config = this.config || {};

        //     const ckeditorValue = "";
        //     const ckeditorConfig = { editor, ...config };
        //     const ckeditorReady = () => {};

        // return { ckeditorValue, ckeditorConfig, ckeditorReady };
        return {
            // editor: CKeditor,
            // editorData: '<p>Content of the editor.</p>',
            // editorConfig: {}
            editor: ClassicEditor,
            editorData: '<p>Content of the editor.</p>',
            editorConfig: {
                // plugins: [
                //     Bold,
                //     Italic,
                //     Underline,
                //     Strikethrough,
                //     Heading,
                //     Essentials,
                //     ImageUpload,
                //     ImageInsert,
                //     AutoImage,
                //     Image,
                //     ImageResizeEditing,
                //     ImageResizeHandles,
                //     Base64UploadAdapter,
                // ],
                // toolbar: {
                //     items: [
                //         'heading',
                //         '|',
                //         'bold',
                //         'italic',
                //         'underline',
                //         'strikethrough',
                //         '|',
                //         'insertImage',
                //     ],
                // },
                toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote' ],
                heading: {
                    options: [
                        { model: 'paragraph', title: '見出し', class: 'ck-heading_paragraph' },
                        { model: 'heading1', view: '大見出し', title: 'Heading 1', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: '小見出し', title: 'Heading 2', class: 'ck-heading_heading2' }
                    ]
                },
                // language: 'ja',
            },
        }
    },
    // watch: {
    //     ckeditorValue(value) {
    //         this.$emit("input", value);
    //     }
    // }
    // computed: {
    //     editorData: {
    //         get() {
    //             return this.value
    //         },
    //         set(value) {
    //             this.$emit('input', value)
    //         }
    //     }
    // }
};
</script>

<style lang="scss" scoped>
.ckeditor {
    width: 80%;
    max-width: 800px;
    height: 500px;
    margin: 0 auto;
}

</style>