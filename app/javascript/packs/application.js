import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/UsersList.vue'
require('../../assets/javascripts/mask');
require('imask');
Vue.prototype.$axios = require('axios');

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '[data-behavior="vue"]',
        components: {
            'users-component': UsersList,
        }
    })
});
