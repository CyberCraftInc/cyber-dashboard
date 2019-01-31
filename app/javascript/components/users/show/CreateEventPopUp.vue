<template>
  <div>
    <div v-if='modal' id='modal' class='modal-content' @click='closeModal($event)'>
      <div id='modal-content'>
        <div class='d-flex modal-header'>
          <h3 class='modal-title'>Create event</h3>
          <button type='button' @click="closeModal('close')" class='close' data-dismiss='modal'>&times;</button>
        </div>

        <div id='modal-status'>
          <label>Status - </label>
          <select v-model="status">
            <option v-for="status in statuses" v-bind:value="status.value">
              {{ status.text }}
            </option>
          </select>
        </div>

        <div id='modal-description'>
          <label for='description'>Description</label>
          <input id='description' v-model='description' autofocus class='form-control' type='text' placeholder='Type an event description here'>
        </div>

        <div id='modal-period'>
          <div>
            <label for='start_date'>Start date</label>
            <input v-model='startDate' class='form-control' id='start_date' type='date'>
          </div>
          <div>
            <label for='finish_date'>Finish date</label>
            <input v-model='finishDate' class='form-control' id='finish_date' type='date'>
          </div>
        </div>
        <!-- for the future  
        <div id='modal-type'>
          <label>Type</label>
          <input type='radio' checked aria-label='Radio button for following text input' onclick='return false;'/>
          <span>REVIEW</span>
        </div>
        -->
        <div id='modal-targets'>
          <label>Targets</label>

          <div id='targets'>
            <div v-for='(target, count) in targets'>
              <div v-if="target._destroy != '1'">
                <span>{{ count+1 }}</span>
                <span>{{ target.description }}</span>
                <button v-on:click='removeTarget(count)' class='gray-button'>remove</button>
              </div>
            </div>

            <div>
              <input id='add-new-target' v-model='targetDescription' class='form-control' type='text'>
              <button class='btn bg-dark text-white' @click='createTargetInput'>Add new target</button>
            </div>
          </div>
        </div>

        <div id='modal-comments'>
          <label>Comments</label>
          <textarea v-model='comments' class='form-control' rows='5' cols='50'>
          </textarea>
        </div>

        <div id='modal-summary'>
          <label>Summary</label>
          <textarea v-model='summary' class='form-control' rows='8' cols='50'>
          </textarea>
        </div>

        <div id='modal-create'>
          <button class='btn bg-secondary text-white' @click="closeModal('close')" >Cancel</button>
          <button class='btn bg-dark text-white' @click="submitData(axiosRequest, eventsPath)" id='create-event'>Submit</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      modal: {
        type: Boolean
      },
      user: {
        type: Object
      },
      eventsPath: {
        type: String
      },
      axiosRequest: {
        type: String,
        default: 'post'
      },
      eventProps: {
        type: Object
      },
      statusesForEvent: {
        type: Array
      }
    },
    data() {
      return {
        showModal: this.modal,
        id: '',
        description: '',
        startDate: '',
        finishDate: '',
        comments: '',
        summary: '',
        targets: [],
        targetDescription: '',
        status: 'scheduled',
        statuses: [],
        event: this.eventProps,
      }
    },
    created() {
      for(var i=0;i<this.statusesForEvent.length;i++){
        this.statuses.push({
          text: this.statusesForEvent[i].charAt(0).toUpperCase() + this.statusesForEvent[i].slice(1),
          value: this.statusesForEvent[i]
        });
      }
    },
    watch: {
      eventProps: function () {
        this.id = this.eventProps.id;
        this.description = this.eventProps.description;
        this.startDate = this.eventProps.start_date;
        this.finishDate = this.eventProps.finish_date;
        this.comments = this.eventProps.comments;
        this.summary = this.eventProps.summary;
        this.targets = this.eventProps.targets;
        this.status = this.eventProps.status;
      }
    },
    methods: {
      closeModal(e) {
        if (e.target == document.getElementById('modal') || e == 'close')
          this.$emit('show', false);
      },
      createTargetInput() {
        this.targets.push({
          id: null,
          description: this.targetDescription,
          achieved: false,
          _destroy: null
        });
        this.targetDescription = '';
      },
      removeTarget(index) {
        var target = this.targets[index]

        if (target.id == null) {
          this.targets.splice(index, 1);
        } else {
          this.$set(this.$data.targets[index], '_destroy', '1' );
        }
      },
      submitData(method, path) {
        this.$axios({
          url: path + `/${this.id}`,
          method: method,
          data: {
            event: {
              description: this.description,
              status: this.status,
              start_date: this.startDate,
              finish_date: this.finishDate,
              comments: this.comments,
              summary: this.summary,
              user_id: this.user.id,
              targets_attributes: this.targets
            }
          }
        }).then((response) => location.reload())
          .catch((error) => console.log(error.response));
      }
    }
  }
</script>
