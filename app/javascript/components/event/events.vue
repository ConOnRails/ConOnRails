<template lang="pug">
  #event_list
    Event(v-for="event in events", :key="event.id")
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    ...mapState(['events'])
  },
  methods: {
    loadData() {
      fetch('/events.json').then(response => response.json())
	.then((data) => {
	  console.log(data);
	  this.$store.commit('events', data);
	});
      setTimeout(this.loadData, 10000);
    }
  },
  beforeMount() {
    this.loadData();
  }
}
      
</script>
