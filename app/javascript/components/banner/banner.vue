<template lang="pug">
  #banner(:class="bannerStyle").row
    .col-md-3.col-sm-3.col-xs-12
      #logo
        img(:src="imageLink" alt="Con On Rails")

    .col-md-6.col-sm-6.col-xs-9
      BannerText(
        :active="this.active"
        :active-secure="this.activeSecure"
        :emergency="this.emergency"
        :medical="this.medical"
        :now="this.now"
        :role="this.role"
        :userName="this.userName"
        :userUrl="this.userUrl"
      )

    div(v-if="this.userName").col-md-3.col-sm-3.text-right
      a#emergency_button(:class="this.emergencyButtonStyle" href="/events/new?emergency=1")
        .glyphicon.glyphicon-exclamation-sign
        | &nbsp; Open a New Emergency
      div
        label(for="pause") Pause Banner
        input(name="pause" type="checkbox" v-model="pause")
      div(v-if="this.pause").text-right
        | PAUSED
</template>

<script>
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
    }
  },
  data() {
    return {
      active: 0,
      activeSecure: 0,
      emergency: 0,
      imageLink: '',
      medical: 0,
      now: this.currentTime(),
      pause: false,
      role: '',
      userName: '',
      userUrl: ''
    }
  },
  methods: {
    loadData() {
      if (!this.pause) {
        fetch('/banner').then(response => response.json())
                        .then((data) => {
                          this.active = data.active;
                          this.activeSecure = data.active_secure;
                          this.emergency = data.emergency;
                          this.medical = data.medical;
                          this.imageLink = data.logo_url;
                          this.now = this.currentTime();
                          this.role = data.role;
                          this.userName = data.user_name;
                          this.userUrl = data.user_url;
                        });
      }
      if (this.loggedIn) {
        setTimeout(this.loadData, 10000);
      }
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
