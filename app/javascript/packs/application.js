/* eslint no-console:0 */
/* jshint esversion: 6 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue/dist/vue.esm.js';
import Vuex from 'vuex';
import Banner from '../components/banner/banner.vue';
import BannerText from '../components/banner/banner-text.vue';
import BannerCategory from "../components/banner/banner-category.vue";

Vue.component('banner', Banner);
Vue.component('BannerText', BannerText);
Vue.component('BannerCategory', BannerCategory);
Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    active: 0,
    activeSecure: 0,
    emergency: 0,
    imageLink: '',
    medical: 0,
    pause: false,
    role: '',
    userName: '',
    userUrl: ''
  },
  mutations: {
    updateBanner(state, data) {
      state.active = data.active;
      state.activeSecure = data.active_secure;
      state.emergency = data.emergency;
      state.medical = data.medical;
      state.imageLink = data.logo_url;
      state.role = data.role;
      state.userName = data.user_name;
      state.userUrl = data.user_url;
    },
    togglePause(state) {
      state.pause = !state.pause;
    }
  }
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue',
    store: store
  });
});
