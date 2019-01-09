import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/UsersList.vue'
import axios from 'axios';

Vue.prototype.$axios = axios;
axios.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0];
axios.defaults.headers.common['Accept'] = 'application/json';

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '[data-behavior="vue"]',
        components: {
            'users-component': UsersList,
        }
    })
});
