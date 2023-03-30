<!-- health check -->
<template>
  <div class="ma-16">
    <div class="my-2">
      <p>Test vue!!</p>
    </div>
    <div class="pa-1">
      <v-btn
        name="button"
        class="p-1"
        width="200px"
        @click="getMsg"
      >
        RailsからAPIを取得する
      </v-btn>
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
  name: 'PageIndex',
  // ページをレンダリングする前に実行
  middleware ({ redirect }) {
        return redirect('/about')
  },
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
