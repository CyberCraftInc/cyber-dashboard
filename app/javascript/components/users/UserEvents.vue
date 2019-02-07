<template>
  <div class="user-events">
    <h3
      v-if="events.length>0"
      class="text-muted"
    >EVENTS TIMELINE</h3>
    <div
      class="row"
      v-for="(event, index) in events"
      :key="event.id"
    >
      <div class="col-12">
        <span v-if="index > 0">
          <h1
            class="event-unique-year mt-5"
            v-show="dateYear(index)"
          >{{ dateYear(index) }}</h1>
        </span>
        <span v-else>
          <h1 class="event-unique-year mt-3">{{ event.finish_date.match(/^\d*/gi).toString() }}</h1>
        </span>
      </div>
      <div class="col-1 pr-0 ml-4 d-flex align-items-start day-month-event justify-content-center">
        <h5>
          <span class="">{{ getMonthAndDate(event["finish_date"]) }}</span>
        </h5>
      </div>
      <div class="col-10 pl-0 ml-4">
        <div class="d-flex flex-wrap align-items-center">
          <div
            class="col-12 pt-2 pb-2 d-flex align-items-center justify-content-between flex-row pl-2 event-visible-item mt-2 mb-0"
            @click="changeActiveEvent(event.id)"
          >
            <div
              v-bind:class="showButtonForCanEditEvent()"
              class="pl-2 "
              data-toggle="modal"
              data-target="#popUpModal"
              @click='onClickButton(event)'
            ><i class="fas fa-edit fa-lg"></i></div>
            <div
              class="col-8 event-description-text"
              v-if="addTagDelToEventDescription(event.status)"
            ><span>
                <del>{{ event.description }}</del>
              </span>
            </div>
            <div
              class="col-8 event-description-text"
              v-else
            ><span>{{ event.description }}</span></div>
            <div
              class="text-white text-uppercase event-status-item mx-4 mt-1 py-1"
              :class="eventBadgesStyle[event.status]"
            >{{event.status}}</div>
            <div class="col-1 mt-1"><i
                v-bind:id="'open-event'+event.id"
                class="fas fa-angle-down fa-2x"
              ></i></div>
          </div>
        </div>
        <div
          v-bind:id="'event'+event.id"
          class="display-none event-full-data-item px-3 py-1 mt-0 border border-top-0 border-width-2"
        >
          <span
            class="text-muted"
            v-if="isFieldNotEmpty(event.start_date)"
          >START DATE</span>
          <div v-if="isFieldNotEmpty(event.start_date)">{{getYearMonthAndDate(event.start_date)}}</div>
          <span class="text-muted">FINISH DATE</span>
          <div>{{getYearMonthAndDate(event.finish_date)}}</div>
          <span class="text-muted">EVENT DESCRIPTION</span>
          <div>{{event.description}}</div>
          <span
            class="text-muted"
            v-if="isFieldNotEmpty(event.comments)"
          >COMMENT</span>
          <div v-if="isFieldNotEmpty(event.comments)">{{event.comments}}</div>
          <span
            v-if="isFieldNotEmpty(event.summary)"
            class="text-muted"
          >SUMMARY</span>
          <div v-if="isFieldNotEmpty(event.summary)">{{event.summary}}</div>
          <span
            class="text-muted"
            v-if="event.targets.length!==0"
          >TARGETS</span>
          <div
            v-for="target in event.targets"
            class="round"
            :key="target.id"
          >
            <div
              v-if="axiosFlashNotice"
              class="alert alert-danger flash_notice"
            >{{ axiosFlashNotice }}</div>
            <div class="d-inline">
              <input
                class="pt-1"
                v-bind:id="'target'+target.id"
                type="checkbox"
                v-bind:checked="target.achieved"
                @click="changeTargetAchieved(target)"
                v-bind:disabled="!canEditEvent"
              />
            </div>
            <label
              class='ml-3 d-inline'
              v-bind:for="'target'+target.id"
            >{{ target.description }}</label>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      events: JSON.parse(this.eventsForProps),
      topYear: null,
      axiosFlashNotice: false,
      titlesEvent: {
        "Start date": "start_date",
        "Finish date": "finish_date",
        "Comments": "comments",
        "Summary": "summary"
      },
      eventBadgesStyle: {
        'scheduled': 'badge badge-info',
        'done': 'badge badge-success',
        'canceled': 'badge badge-secondary'
      },
      date: []
    };
  },
  props: {
    eventsForProps: { type: String },
    canEditEvent: { type: Boolean }
  },
  methods: {
    showButtonForCanEditEvent () {
      return this.$parent.showButtonForCanEditEvent()
    },
    isFieldNotEmpty (field) {
      return (field === null || field === '') ? false : true
    },
    dateYear (index) {
      let year = this.events[index].finish_date.match(/^\d*/gi).toString()
      let nextYear = this.events[index - 1].finish_date.match(/^\d*/gi).toString()
      if (year == nextYear) {
        return false
      } else {
        return year
      }
    },
    addTagDelToEventDescription (eventStatus) {
      return ["canceled"].includes(eventStatus)
    },
    getMonthAndDate (date) {
      return new Date(date).toLocaleDateString("en-US", { month: 'short', day: 'numeric' }).toLocaleLowerCase()
    },
    getYearMonthAndDate (date) {
      return new Date(date).toLocaleDateString("en-US", { month: 'short', day: 'numeric', year: 'numeric' })
    },
    changeActiveEvent (eventId) {
      document.getElementById('event' + eventId).classList.toggle('display-block')
      document.getElementById('open-event' + eventId).classList.toggle('fa-angle-up')
    },
    openedEventData (eventId) {
      return document.getElementById('event' + eventId).classList.contains('display-block');
    },
    changeTargetAchieved (target) {
      this.$axios
        .put(target.toggle_achieved_path, {
          params: {
            id: target.id
          }
        })
        .then(() => (this.axiosFlashNotice = false))
        .catch(() => (this.axiosFlashNotice = "Failed change checkbox "));
    },
    onClickButton (event) {
      this.$emit("eventProps", event);
    }
  }
};
</script>
