<template lang="pug">
  #banner_text.row
    div(v-if="this.userName").col-md-12
      .row
        BannerCategory(v-if="this.emergency > 0" icon='emergency-icon' :text="this.emergencyText")
        BannerCategory(v-if="this.medical > 0" icon='medical-icon' :text="this.medicalText")

      .row
        BannerCategory(icon='active-icon' :text="this.activeText")
        BannerCategory(v-if="this.activeSecure > 0" icon='secure-icon' :text="this.activeSecureText")

      .row
        .col-md-12
          | {{now}}
      .row
        .col-md-12
          | User:
          |
          a(href="userUrl")
            | {{this.userName}} as {{this.role}}

    div(v-if="!this.userName")
      h1
        | CONvergence Operations Log
</template>

<script>
import Pluralize from 'pluralize';
import { mapState } from 'vuex';

export default {
  computed: {
    activeText() {
      return Pluralize("Active Issue", this.active, true);
    },
    activeSecureText() {
      return Pluralize("Secure Active Issue", this.activeSecure, true);
    },
    emergencyText() {
      return Pluralize("Emergency", this.emergency, true);
    },
    medicalText() {
      return Pluralize("Medical", this.medical, true);
    },
    ...mapState([
      'active',
      'activeSecure',
      'emergency',
      'medical',
      'role',
      'userName',
      'userUrl'
    ])
  },
  props: {
    now: String
  }
};
</script>
