import * as React from "react";
// import axios from "axios";

class CreateEventModal extends React.Component {
  render() {
    return(
      <div
        className="modal fade"
        id="popUpModal"
        tabIndex="-1"
        role="dialog"
        aria-labelledby="popUpModalTitle"
        aria-hidden="true"
        // onClick = closeModal($event)
      >
        <div
          className="modal-dialog"
          role="document"
        >
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title">Event form</h5>
              <button
                type="button"
                className="close"
                data-dismiss="modal"
                aria-label="Close"
                // onClick="closeModal('close')"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>

            <div className="modal-body d-flex flex-column">
              <div
                id="modal-status"
                className="form-group mb-3"
              >
                <label htmlFor="status">Status</label>
                <select
                  className="form-control"
                  id="status"
                  v-model="status"
                >
                  <option
                    v-for="status in statuses"
                  >status.text</option>
                </select>
              </div>

              <div
                id="modal-description"
                className="form-group mb-3"
              >
                <label htmlFor="description">Description</label>
                <textarea
                  className="form-control"
                  id="description"
                  v-model="description"
                  placeholder="Type an event description here"
                />
              </div>

              <div
                id="modal-period"
                className="d-flex justify-content-start form-group mb-3"
              >
                <div className="mr-4">
                  <label htmlFor="start_date">Start date</label>
                  <input
                    v-model="startDate"
                    className="form-control"
                    id="start_date"
                    type="date"
                  />
                </div>
                <div>
                  <label htmlFor="finish_date">Finish date</label>
                  <input
                    v-model="finishDate"
                    className="form-control"
                    id="finish_date"
                    type="date"
                  />
                </div>
              </div>

              <div
                id="modal-targets"
                className="form-group mb-3"
              >
                <label>Targets</label>
                <div id="targets">
                  <div
                    className="mb-1"
                  >
                    <div
                      className="d-flex align-items-center justify-content-between"
                      v-if="target._destroy != '1'"
                    >
                      <div className="pl-3 flex-fill d-flex align-items-center p-1 border-bottom">
                        <div>target.description</div>
                      </div>
                      <div className="d-flex justify-content-end">
                        <button
                          onClick={console.log('removeTarget')}
                          className="btn bg-white text-danger m-0 ml-2"
                        >&#10008;</button>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="d-flex align-items-start">
                  <div className="flex-fill">
                    <input
                      id="add-new-target"
                      v-model="targetDescription"
                      className="form-control"
                      type="text"
                      placeholder="Enter target"
                    />
                  </div>
                  <div>
                    <button
                      id="create-target"
                      className="btn btn-light text-success m-0 ml-2"
                    >&#10010;</button>
                  </div>
                </div>
              </div>

              <div
                id="modal-comments"
                className="mb-3"
              >
                <label>Comments</label>
                <textarea
                  v-model="comments"
                  className="form-control"
                />
              </div>

              <div
                id="modal-summary"
                className="mb-3"
              >
                <label>Summary</label>
                <textarea
                  v-model="summary"
                  className="form-control"
                />
              </div>
            </div>

            <div className="modal-footer">
              <div id="modal-create">
                <button
                  className="btn bg-secondary text-white m-0"
                  data-dismiss="modal"
                  aria-label="Close"
                  onClick={console.log('closeModal')}
                >Cancel</button>
                <button
                  className="btn bg-dark text-white m-0"
                  onClick={console.log('submitData(axiosRequest, eventsPath')}
                  id="create-event"
                >Submit</button>
              </div>
            </div>
          </div>

        </div>
      </div>
    );
  }
}


export default CreateEventModal;
