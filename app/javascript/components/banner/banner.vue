<template lang="pug">
  #banner(:class="bannerStyle").row
    .col-md-3.col-sm-3.col-xs-12
      #logo
        img(:src="imageLink" alt="Con On Rails")

    .col-md-6.col-sm-6.col-xs-9
      BannerText(:now="this.now")

    div(v-if="this.userName").col-md-3.col-sm-3.text-right
      a#emergency_button(:class="this.emergencyButtonStyle" href="/events/new?emergency=1")
        .glyphicon.glyphicon-exclamation-sign
        | &nbsp; Open a New Emergency
      div
        label(for="pause") Pause Banner
        input(name="pause" type="checkbox" @click="togglePause")
      div(v-if="this.pause").text-right
        | PAUSED
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    bannerStyle() {
      let style = 'normal';
      if (this.active > 0) {
        style = 'active';
      }
      if (this.emergency > 0 || this.medical > 0) {
        style = 'emergency';
      }

      return style;
    },
    emergencyButtonStyle() {
      let style = 'btn btn-danger btn-large';
      if (this.emergency > 0 || this.medical > 0) {
        style = 'reverse';
      }

      return style;
    },
    ...mapState([
      'active',
      'emergency',
      'imageLink',
      'medical',
      'pause',
      'userName'
    ])
  },
  data() {
    return {
      now: this.currentTime()
    }
  },
  methods: {
    loadData() {
      if (!this.pause) {
        fetch('/banner').then(response => response.json())
                        .then((data) => {
                          this.$store.commit('updateBanner', data);
                        });
      }
      if (this.loggedIn) {
        setTimeout(this.loadData, 10000);
      }
    },
    togglePause() {
      this.$store.commit('togglePause');
    },
    currentTime() {
      const d = new Date()
      return d.toDateString() + " " + d.toTimeString();`!`
    }
  },
  props: {
    loggedIn: Boolean
  },
  beforeMount() {
    this.loadData();
  }

}
</script>
