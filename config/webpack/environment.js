/* jshint esversion: 6 */
const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const pug = require('./loaders/pug');

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('pug', pug);
environment.loaders.prepend('vue', vue);
module.exports = environment;
