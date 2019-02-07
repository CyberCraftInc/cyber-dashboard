import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/users/UsersList.vue'
import UserEdit from '../components/users/edit/UserEdit.vue'
import HeaderDropdown from '../components/header/HeaderDropdown.vue'
import UserInfo from '../components/users/UserInfo.vue'
import UserEvents from '../components/users/UserEvents'
import axios from 'axios'

window.moment = require('moment');
require('../../assets/javascripts/mask');
require('imask');

Vue.prototype.$axios = axios;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: {
      'users-component': UsersList,
      'users-edit-component': UserEdit,
      'header-dropdown': HeaderDropdown,
      'user-info-component': UserInfo,
      'user-events-component': UserEvents
    }
  });

  if (document.querySelector('meta[name="csrf-token"]')) {
    axios.defaults.headers.common = {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      'Accept': 'application/json'
    }
  } else {
    axios.defaults.headers.common['Accept'] = 'application/json';
  }
});
