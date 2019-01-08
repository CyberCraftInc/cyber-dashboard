import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/UsersList.vue'
import axios from 'axios';

Vue.prototype.$axios = axios;

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '[data-behavior="vue"]',
        components: {
            'users-component': UsersList,
        }
    })
});
