<template>
  <div class="row">
    <div class="col-6">
      <h3>{{ user.first_name + " " +user.last_name }}</h3>
      <p>{{ user.phone }}</p>
      <p>{{ user.email }}</p>
    </div>
    <div class="col-6">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">{{ user.project.name }}</h5>
          <p class="card-text">{{ user.project.desc }}</p>
        </div>
      </div>
    </div>
    <create-event-button @show="onClickCreateEvent"></create-event-button>
    <create-event-pop-up
      :modal="showModal"
      :user="user"
      @show="onClickCreateEvent"
      :events-path='eventsRoute'
      :targets-path='tagretsRoute'
    ></create-event-pop-up>
  </div>
</template>

<script>
  import CreateEventButton from './show/CreateEventButton.vue'
  import CreateEventPopUp from './show/CreateEventPopUp.vue'

  export default {
    components: {
      'create-event-button': CreateEventButton,
      'create-event-pop-up': CreateEventPopUp
    },
    data: function () {
      return {
        user: JSON.parse(this.userForProps),
        titlesProjectInfo: {
          "Project name": "name",
          "Project description": "desc"
        },
        showModal: false
      }
    },
    methods: {
      onClickCreateEvent (value) {
        this.showModal = value
      }
    },
    props: {
      userForProps: { type: String },
      eventsRoute: { type: String },
      tagretsRoute: { type: String }
    }
  }
</script>
