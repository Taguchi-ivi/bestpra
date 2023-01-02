<template>
  <div>
    <dir>
      <p>Test vue!!</p>
      <p><span class="lime accent-1"> Actionsから自動更新完了!!</span></p>
    </dir>
    <button
      type="button"
      name="button"
      class="yellow lighten-4"
      @click="getMsg"
    >
      RailsからAPIを取得する
    </button>
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