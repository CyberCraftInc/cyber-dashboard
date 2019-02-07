<template>
  <div
    class="modal fade"
    id="popUpModal"
    tabindex="-1"
    @click="closeModal($event)"
    role="dialog"
    aria-labelledby="popUpModalTitle"
    aria-hidden="true"
  >
    <div
      class="modal-dialog"
      role="document"
    >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Event form</h5>
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
            @click="closeModal('close')"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <div class="modal-body d-flex flex-column">
          <div
            id="modal-status"
            class="form-group mb-3"
          >
            <label for="status">Status</label>
            <select
              class="form-control"
              autofocus
              id="status"
              v-model="status"
            >
              <option
                v-for="status in statuses"
                v-bind:key="status.id"
                v-bind:value="status.value"
              >{{ status.text }}</option>
            </select>
          </div>

          <div
            id="modal-description"
            class="form-group mb-3"
          >
            <label for="description">Description</label>
            <textarea
              class="form-control"
              id="description"
              v-model="description"
              placeholder="Type an event description here"
            ></textarea>
          </div>

          <div
            id="modal-period"
            class="d-flex justify-content-start form-group mb-3"
          >
            <div class="mr-4">
              <label for="start_date">Start date</label>
              <input
                v-model="startDate"
                class="form-control"
                id="start_date"
                type="date"
              >
            </div>
            <div>
              <label for="finish_date">Finish date</label>
              <input
                v-model="finishDate"
                class="form-control"
                id="finish_date"
                type="date"
              >
            </div>
          </div>

          <div
            id="modal-targets"
            class="form-group mb-3"
          >
            <label>Targets</label>

            <div id="targets">
              <div
                class="mb-1"
                v-for="(target, count) in targets"
                v-bind:key="target.id"
              >
                <div
                  class="d-flex align-items-center justify-content-between"
                  v-if="target._destroy != '1'"
                >
                  <div class="pl-3 flex-fill d-flex align-items-center p-1 border-bottom">
                    <div>{{ target.description }}</div>
                  </div>
                  <div class="d-flex justify-content-end">
                    <button
                      v-on:click="removeTarget(count)"
                      class="btn bg-white text-danger m-0 ml-2"
                    >&#10008;</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="d-flex align-items-start">
              <div class="flex-fill">
                <input
                  id="add-new-target"
                  @keyup.enter="createTargetInput"
                  v-model="targetDescription"
                  class="form-control"
                  type="text"
                  placeholder="Enter target"
                >
              </div>
              <div>
                <button
                  id="create-target"
                  class="btn btn-light text-success m-0 ml-2"
                  @click="createTargetInput"
                >&#10010;</button>
              </div>
            </div>
          </div>

          <div
            id="modal-comments"
            class="mb-3"
          >
            <label>Comments</label>
            <textarea
              v-model="comments"
              class="form-control"
            ></textarea>
          </div>

          <div
            id="modal-summary"
            class="mb-3"
          >
            <label>Summary</label>
            <textarea
              v-model="summary"
              class="form-control"
            ></textarea>
          </div>
        </div>

        <div class="modal-footer">
          <div id="modal-create">
            <button
              class="btn bg-secondary text-white m-0"
              data-dismiss="modal"
              aria-label="Close"
              @click="closeModal('close')"
            >Cancel</button>
            <button
              class="btn bg-dark text-white m-0"
              @click="submitData(axiosRequest, eventsPath)"
              id="create-event"
            >Submit</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object
    },
    eventsPath: {
      type: String
    },
    axiosRequest: {
      type: String,
      default: "post"
    },
    eventProps: {
      type: Object
    },
    statusesForEvent: {
      type: Array
    }
  },
  data () {
    return {
      id: "",
      description: "",
      startDate: "",
      finishDate: "",
      comments: "",
      summary: "",
      targets: [],
      targetDescription: "",
      status: "scheduled",
      statuses: [],
      event: this.eventProps
    };
  },
  created () {
    for (var i = 0; i < this.statusesForEvent.length; i++) {
      this.statuses.push({
        text:
          this.statusesForEvent[i].charAt(0).toUpperCase() +
          this.statusesForEvent[i].slice(1),
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
    closeModal (e) {
      if (e.target == document.getElementById("popUpModal") || e == "close") {
        this.cleanErrorMessages();
      }
    },
    createTargetInput () {
      if (this.targetDescription) {
        this.cleanErrorMessages();
        this.targets.push({
          id: null,
          description: this.targetDescription,
          achieved: false,
          _destroy: null
        });
        this.targetDescription = "";
      } else {
        this.cleanErrorMessages();
        this.addErrorMessages("add-new-target", "Field can't be blank", 1);
      }
    },
    removeTarget (index) {
      var target = this.targets[index];

      if (target.id == null) {
        this.targets.splice(index, 1);
      } else {
        this.$set(this.$data.targets[index], "_destroy", "1");
      }
    },
    submitData (method, path) {
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
      }).then(response => this.showNotice(response.data));
    },
    showNotice (response) {
      if (response.status == "created" || response.status == "updated") {
        location.reload();
      } else {
        this.cleanErrorMessages();

        for (let error in response) {
          this.addErrorMessages(error, response[error], 3);
        }
      }
    },
    cleanErrorMessages () {
      let errorMessages = document.querySelectorAll(".error");
      let errorFields = document.querySelectorAll(".field-error");

      if (errorFields) {
        [].forEach.call(errorFields, function (el) {
          el.classList.remove("field-error");
        });
      }
      if (errorMessages) {
        [].forEach.call(errorMessages, function (el) {
          el.remove();
        });
      }
    },
    addErrorMessages (elementId, errorText, childPosition) {
      let newErrorElement = document.createElement("div");
      let errorMessage = document.createTextNode(errorText);

      let errorElement = document.getElementById(elementId);
      let errorElementParent = errorElement.parentElement;

      newErrorElement.classList.add("error");
      newErrorElement.appendChild(errorMessage);

      errorElementParent.insertBefore(
        newErrorElement,
        errorElementParent.childNodes[childPosition]
      );
      errorElement.classList.add("field-error");
    }
  }
};
</script>
