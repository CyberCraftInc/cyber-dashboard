<template>
  <div>
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
      <create-event-button
        :can-edit-event="canEditEvent"
        @show="onClickCreateEvent"
      ></create-event-button>
      <create-event-pop-up
        :modal="showModal"
        :user="user"
        @show="onClickCreateEvent"
        :event-props="formValue"
        :events-path="eventsPath"
        :axios-request="axiosRequestType"
        :statuses-for-event="statusesEvent"
      ></create-event-pop-up>
    </div>
    <user-events-component
      :events-for-props="eventsForProps"
      :can-edit-event="canEditEvent"
      @show="onClickCreateEvent"
      @eventProps="onClickEditEvent"
    ></user-events-component>
  </div>
</template>

<script>
  import CreateEventButton from './show/CreateEventButton.vue'
  import CreateEventPopUp from './show/CreateEventPopUp.vue'
  import UserEvents from '../users/UserEvents'

  export default {
    components: {
      'create-event-button': CreateEventButton,
      'create-event-pop-up': CreateEventPopUp,
      'user-events-component': UserEvents
    },
    data: function () {
      return {
        user: JSON.parse(this.userForProps),
        titlesProjectInfo: {
          "Project name": "name",
          "Project description": "desc"
        },
        showModal: false,
        eventsPath: '',
        axiosRequestType: '',
        statusesEvent: JSON.parse(this.statuses),
        formValue: {}
      }
    },
    methods: {
      onClickCreateEvent (value) {
        this.showModal = value;
        this.formValue = {
          id: '',
          description: '',
          status: 'scheduled',
          startDate: '',
          finishDate: '',
          comments: '',
          summary: '',
          targets: [],
          targetDescription: ''
        }
        this.eventsPath = this.EventsPath;
        this.axiosRequestType = 'post';
      },
      onClickEditEvent (value) {
        this.formValue = value;
        this.eventsPath =  this.EventsPath;
        this.axiosRequestType = 'put';
      },
      showButtonForCanEditEvent() {
        if (!this.canEditEvent) {
          return "display-none";
        }
      }
    },
    props: {
      userForProps: { type: String },
      EventsPath: { type: String },
      eventsForProps: { type: String },
      canEditEvent: { type: Boolean },
      statuses: { type: String }
    }
  }
</script>
