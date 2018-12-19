import Vue from 'vue/dist/vue.esm';
import UsersList from '../components/UsersList.vue'
import axios from 'axios';

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'
window.axios = axios
document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '[data-behavior="vue"]',
        components: {
            'users-component': UsersList,
        }
    })
})
