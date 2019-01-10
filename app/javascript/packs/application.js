import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/UsersList.vue'
require('../../assets/javascripts/mask');
require('imask');
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0];
axios.defaults.headers.common['Accept'] = 'application/json';
Vue.prototype.$axios = axios;

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '[data-behavior="vue"]',
        components: {
            'users-component': UsersList,
        }
    })
});
