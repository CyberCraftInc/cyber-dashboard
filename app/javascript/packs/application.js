import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/users/UsersList.vue'
import UserEdit from '../components/users/edit/UserEdit.vue'
import HeaderDropdown from '../components/header/HeaderDropdown.vue'
import axios from 'axios'

require('../../assets/javascripts/mask');
require('imask');

Vue.prototype.$axios = axios;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: {
      'users-component': UsersList,
      'users-edit-component': UserEdit,
      'header-dropdown': HeaderDropdown
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
