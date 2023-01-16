<template>
  <div>
    <div class="my-2">
      <p>Test vue!!</p>
      <p>自動デプロイ確認</p>
    </div>
    <div class="pa-1">
      <button
        type="button"
        name="button"
        class="p-1"
        width="200px"
        @click="getMsg"
      >
        RailsからAPIを取得する
      </button>
    </div>
    <div
      v-for="(msg, i) in msgs"
      :key="i"
    >
      {{ msg }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      msgs: []
    }
  },
  methods: {
    getMsg () {
      this.$axios.$get('/api/v1/hello')
        .then(res => this.msgs.push(res))
    }
  }
}
</script>
