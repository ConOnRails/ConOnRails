<template lang="pug">
  div.cork-board
</template>

<script>
export default {
  props: ['tag'],
  methods: {
    loadData() {
      fetch('/events/tag/' + this.tag + '.json').
        then((response) => response.json).
        then((data) => {
          console.log(data);
        })
    }
  },
  beforeMount() {
    this.loadData();
  }
}
</script>
