import Vue from 'vue/dist/vue.esm';
import App from '../components/App.vue'
import usersList from '../components/UsersList.vue'

Vue.component('app', App)
Vue.component('usersList', usersList)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '[data-behavior="vue"]',
    data: {
      currentView: 'app'
    }
  })
  app.currentView = 'usersList' // Switching pages in any route handler:
})
