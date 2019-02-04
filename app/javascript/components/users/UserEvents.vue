<template>
  <div class="user-events">
    <div class="row" v-for="event in events">
      <div class="col-12" v-if="!topEqualCurrent(event)">
        <h5>{{ getFullYear(event) }}<br></h5>
        <hr/>
      </div>
      <div class="col-2">
        <p class="event-finish-date">{{ event["finish_date"] }}</p>
      </div>
      <div class="col-10">
        <div class="row event-visible-item">
          <div class="col-8" @click="changeActiveEvent(event.id)">
            <span>{{ event.description }}</span>
          </div>
          <div class="col-2">
            <button class="btn-warning edit-event-button" v-bind:disabled="!canEditEvent" @click='onClickButton(event)'>Edit event</button>
          </div>
          <div class="col-2">
            <p class="event-status" :class="event.status">{{ event.status }}</p>
          </div>
        </div>
        <div v-bind:id="'event'+event.id" class="display-none">
          <p v-for="title in Object.keys(titlesEvent)" v-if="event[titlesEvent[title]]!==null">{{ title +" - " +
            event[titlesEvent[title]] }}</p>
          <div class="row" v-if="event.targets.length!==0">
            <div class="col-2">Targets:</div>
            <div class="col-10">
              <div class="row" v-for="target in event.targets">
                <div v-if="axiosFlashNotice" class="alert alert-danger flash_notice">{{ axiosFlashNotice }}</div>
                <div class="col-10">
                  <label v-bind:for="'target'+target.id">{{ target.description }}</label>
                </div>
                <div class="col-2">
                  <input v-bind:id="'target'+target.id" type="checkbox" class="checkbox" v-bind:checked="target.achieved"
                         @click="changeTargetAchieved(target)" v-bind:disabled="!canEditEvent">
                </div>
              </div>
            </div>
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
        eventsStatuses: JSON.parse(this.eventsStatistic),
        topYear: null,
        axiosFlashNotice: false,
        titlesEvent: {
          "Comments": "comments",
          "Summary": "summary",
          "Start date": "start_date",
          "Finish date": "finish_date",
        },
      }
    },
    props: {
      eventsForProps: { type: String },
      canEditEvent: { type: Boolean },
      eventsStatistic: { type: String }
    },
    methods: {
      getFullYear(event) {
        return new Date(event['finish_date']).getFullYear()
      },
      topEqualCurrent(event) {
        if (this.getFullYear(event) === this.topYear) {
          return true
        } else {
          this.topYear = this.getFullYear(event);
          return false
        }
      },
      changeActiveEvent(eventId) {
        let hiddenEventInfo = document.getElementById('event' + eventId);
        if (hiddenEventInfo.classList.contains("display-none")) {
          hiddenEventInfo.classList.add("display-block");
          hiddenEventInfo.classList.remove("display-none");
        } else {
          hiddenEventInfo.classList.remove("display-block");
          hiddenEventInfo.classList.add("display-none");
        }
      },
      changeTargetAchieved(target) {
        this.$axios.put(target.toggle_achieved_path , {
          params: {
            id: target.id
          }
        }).then(() => this.axiosFlashNotice = false)
          .catch(() => this.axiosFlashNotice = "Failed change checkbox ");
      },
      onClickButton(event) {
        this.$emit('show', true)
        this.$emit('eventProps', event)
      }

    }
  }
</script>
