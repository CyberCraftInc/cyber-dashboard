<template>
  <div class="user-events">
    <div class="row" v-for="(event, index) in events">
      <div class="col-12 event-finish-date">
        <span v-if="index > 0">
          <h3 v-show="dateYear(index)">{{ dateYear(index) }}</h3>
        </span>
        <span v-else>
          <h3>{{ event.finish_date.match(/^\d*/gi).toString() }}</h3>
        </span>
        <hr/>
      </div>
      <div class="col-2 d-flex align-items-start pt-2 justify-content-center">
        <h5>
          <span class="badge badge-secondary" :class="event.status">{{ event.status }}</span>
          <span class="badge badge-secondary">{{ getMonthAndDate(event["finish_date"]) }}</span>
        </h5>
      </div>
      <div class="col-10">
        <div class="d-flex flex-wrap align-items-center">
          <div class="col-10 d-flex align-items-center justify-content-between flex-row pl-2 event-visible-item bg-dark text-light  border border-secondary rounded" @click="changeActiveEvent(event.id)">
            <span class="p-2">{{ event.description }}</span>
            <div data-toggle="" href="" class="dropdown-toggle"></div>
          </div>
          <div class="col-2 d-flex justify-content-center p-0">
            <button class="btn btn-warning m-2 p-1 rounded" v-bind:disabled="!canEditEvent" @click='onClickButton(event)'>Edit event</button>
          </div>
        </div>
        <div v-bind:id="'event'+event.id" class="display-none p-3">
          <div class="row" v-if="event.targets.length!==0">
            <div class="col-2">
              <h3>Targets</h3>
            </div>
            <div class="col-8">
              <div class="alert alert-secondary d-flex align-items-center justify-content-center m-1 p-0 text-dark" v-for="target in event.targets">
                <div v-if="axiosFlashNotice" class="alert alert-danger flash_notice">{{ axiosFlashNotice }}</div>
                <div class="col-10 d-flex">
                  <label v-bind:for="'target'+target.id">{{ target.description }}</label>
                </div>
                <div class="col-2 d-flex justify-content-end">
                  <input v-bind:id="'target'+target.id" type="checkbox" class="checkbox" v-bind:checked="target.achieved"
                         @click="changeTargetAchieved(target)" v-bind:disabled="!canEditEvent">
                </div>
              </div>
            </div>
          </div>
          <div class="row" v-for="title in Object.keys(titlesEvent)" v-if="event[titlesEvent[title]]!==null">
            <div class="col-3 mt-3" v-if="title.toLowerCase() == 'start date' || title.toLowerCase() == 'finish date' ">
              <div class="alert alert-secondary d-flex align-items-center justify-content-center m-0 p-2" v-show="event[titlesEvent[title]]">
                <span class="text-dark pr-3">{{ title }}</span>
                <span class="badge badge-secondary p-2">{{ event[titlesEvent[title]] }} </span>
              </div>
            </div>
            <div class="col-10 mt-3" v-else>
              <div v-show="event[titlesEvent[title]]" class='col-12 p-0'><h3>{{ title }}</h3></div>
              <div v-show="event[titlesEvent[title]]" class='col-10'>{{ event[titlesEvent[title]] }}</div>
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
        topYear: null,
        axiosFlashNotice: false,
        titlesEvent: {
          "Start date": "start_date",
          "Finish date": "finish_date",
          "Comments": "comments",
          "Summary": "summary"
        },
        date: []
      }
    },
    props: {
      eventsForProps: { type: String },
      canEditEvent: { type: Boolean }
    },
    methods: {
      dateYear(index) {
        let year = this.events[index].finish_date.match(/^\d*/gi).toString()
        let nextYear = this.events[index-1].finish_date.match(/^\d*/gi).toString()
        if ( year == nextYear ) {
          return false
        }else {
          return year
        }
      },
      getMonthAndDate(date){
        return date.replace(/^\d*-/gi, '')
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
