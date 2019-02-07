<template>
  <div>
    <div class="row">
      <div class="col-4 user-info px-5 py-4">
        <h3 class="font-weight-bold pt-2 first-last-user-name">{{ user.first_name + " " +user.last_name }}</h3>
        <p>{{ user.email }}</p>
        <hr />
        <span class="text-muted">PHONE</span>
        <div class="m-top5">{{user.phone}}</div>
        <span class="text-muted">BIRTHDAY</span>
        <div class="m-top5">{{prettyDate(user.birthday)}}</div>
        <div class="row">
          <div class="col-6 m-top5">
            <span class="text-muted">START IN COMPANY</span>
            <div>{{prettyDate(user.start_in_company)}}</div>
          </div>
          <div class="col-6">
            <p class="ml-4 py-2 date-diff-block font-weight-bold">{{datediff(user.start_in_company)}}</p>
          </div>
        </div>
      </div>
      <div class=" col-7 ml-5 user-info pl-5 pr-5 pb-4 project-info">
        <h3>{{ user.project.name }}</h3>
        <span class="text-muted">POSITION</span>
        <div>{{user.position}}</div>
        <hr>
        <span class="text-muted">PROJECT DESCRIPTION</span>
        <div>{{user.project.desc}}</div>
      </div>
    </div>
    <create-event-button
      :can-edit-event="canEditEvent"
      @show="onClickCreateEvent"
    ></create-event-button>
    <create-event-pop-up
      :user="user"
      @show="onClickCreateEvent"
      :event-props="formValue"
      :events-path="eventsPath"
      :axios-request="axiosRequestType"
      :statuses-for-event="statusesEvent"
    ></create-event-pop-up>
    <user-events-component
      :events-for-props="eventsForProps"
      :can-edit-event="canEditEvent"
      @show="onClickCreateEvent"
      @eventProps="onClickEditEvent"
    ></user-events-component>
  </div>
</template>

<script>
import CreateEventButton from "./show/CreateEventButton.vue";
import CreateEventPopUp from "./show/CreateEventPopUp.vue";
import UserEvents from "../users/UserEvents";

export default {
  components: {
    "create-event-button": CreateEventButton,
    "create-event-pop-up": CreateEventPopUp,
    "user-events-component": UserEvents
  },
  data: function () {
    return {
      user: JSON.parse(this.userForProps),
      titlesProjectInfo: {
        "Project name": "name",
        "Project description": "desc"
      },
      eventsPath: "",
      axiosRequestType: "",
      statusesEvent: JSON.parse(this.statuses),
      formValue: {}
    };
  },
  methods: {
    prettyDate (date) {
      return new Date(date).toLocaleDateString("en-US", { year: 'numeric', month: 'short', day: 'numeric' })
    },
    datediff (date) {
      let mdate = moment(date);
      let today = moment(Date.now());
      let years = today.diff(mdate, 'year');
      mdate.add(years, 'years');
      let months = today.diff(mdate, 'months');
      mdate.add(months, 'months');
      let days = today.diff(mdate, 'days');
      if (years === 0 && months === 0) return days + 'D';
      else if (years === 0) return months + 'M ' + days + 'D';
      else return years + 'Y ' + months + 'M ' + days + 'D';
    },
    onClickCreateEvent (value) {
      this.formValue = {
        id: "",
        description: "",
        status: "scheduled",
        startDate: "",
        finishDate: "",
        comments: "",
        summary: "",
        targets: [],
        targetDescription: ""
      };
      this.eventsPath = this.EventsPath;
      this.axiosRequestType = "post";
    },
    onClickEditEvent (value) {
      this.formValue = value;
      this.eventsPath = this.EventsPath;
      this.axiosRequestType = "put";
    },
    showButtonForCanEditEvent () {
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
};
</script>
