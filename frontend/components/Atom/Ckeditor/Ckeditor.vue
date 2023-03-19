<template>
    <div class="ckeditor ck-content-a">
        <!-- TODO 綺麗にする -->
        <!-- placeholder="本文を入力してください(範囲選択でテキストを変更できます)" -->
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
        text: {
            type: String,
            default: ''
        }
    },
    // props: ['text'],
    data() {

        // return { ckeditorValue, ckeditorConfig, ckeditorReady };
        return {
            // editor: CKeditor,
            // editorData: '<p>Content of the editor.</p>',
            // editorConfig: {}
            editor: ClassicEditor,
            editorData: '<p>Content of the editor.</p>',
            editorConfig: {
                // htmlSupport: {
				// 		disallow: [
				// 			{
				// 				name: /.*/,
				// 				style: /.*/
				// 			}
				// 		]
				// 	},
                // extraPlugins: [ HtmlSupport ],
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