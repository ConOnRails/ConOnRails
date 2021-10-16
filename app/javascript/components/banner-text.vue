<template>
  <div id="banner_text" class="row">
    <div v-if="this.userName" class="col-md-12">
      <div class="row">
        <div v-if="this.emergency > 0" class="col-md-6 col-sm-6">
          <div class="emergency-icon" />
          <span>{{this.emergencyText}}</span>
        </div>
        <div v-if="this.medical > 0" class="col-md-6 col-sm-6">
          <div class="medical-icon" />
          <span>{{this.medicalText}}</span>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 col-sm-6">
          <div class="active-icon" />
          <span>{{this.activeText}}</span>
        </div>
        <div v-if="this.activeSecure > 0" class="col-md-6 col-sm-6">
          <div class="secure-icon" />
          <span>{{this.activeSecureText}}</span>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12">
          {{now}} &mdash; User: <a :href="userUrl">{{this.userName}}</a> as {{this.role}}
        </div>
      </div>
    </div>

    <div v-if="!this.userName">
      <h1>CONvergence Operations Log</h1>
    </div>
  </div>
</template>

<script>
import Pluralize from 'pluralize';

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
  },
  props: {
    active: [Number, String],
    activeSecure: [Number, String],
    emergency: [Number, String],
    medical: [Number, String],
    now: String,
    role: String,
    userName: String,
    userUrl: String
  },
  setup() {
    
  },
};
</script>
