<template>
  <div>
    <div v-if='modal' id='modal' @click='closeModal($event)'>
      <div id='modal-content'>
        <div id='modal-title'>
          <h2>Create event</h2>
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

        <div id='modal-type'>
          <label>Type</label>
          <input type='radio' checked aria-label='Radio button for following text input' onclick='return false;'/>
          <span>REVIEW</span>
        </div>

        <div id='modal-targets'>
          <label>Targets</label>

          <div id='targets'>
            <div v-for='(target, count) in targets'>
              <span>{{ count+1 }}</span>
              <span>{{ target.description }}</span>
              <button v-on:click='removeTarget(count)' class='gray-button'>remove</button>
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
          <button class='btn bg-dark text-white' @click='submitData' id='create-event'>Submit</button>
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
      targetsPath: {
        type: String
      }
    },
    data() {
      return {
        showModal: this.modal,
        description: '',
        startDate: '',
        finishDate: '',
        comments: '',
        summary: '',
        targets: [],
        targetDescription: ''
      }
    },
    methods: {
      closeModal(e) {
        if (e.target == document.getElementById('modal') || e == 'close')
          this.$emit('show', false);
      },
      createTargetInput() {
        this.targets.push({
          description: this.targetDescription,
          achieved: false,
          event_id: ''
        });
        this.targetDescription = '';
      },
      removeTarget(index) {
        this.targets.splice(index, 1);
      },
      submitData() {
        this.$axios.post(this.eventsPath, {
          event: {
            description: this.description,
            start_date: this.startDate,
            finish_date: this.finishDate,
            comments: this.comments,
            summary: this.summary,
            user_id: this.user.id
          }
        }).then((response) => this.createTarget(response.data))
          .catch((error) => console.log(error.response));
      },
      createTarget(eventId) {
        this.targets.forEach(target => {
          target['event_id'] = eventId;
        });
        this.$axios.post(this.targetsPath, {
          target: {
            targets: this.targets
          } 
        }).then((response) => location.reload())
          .catch((error) => console.log(error.response));
      }
    }
  }
</script>
