import * as React from "react";
import Modal from "react-modal";
import PropTypes from "prop-types";
import SelectStatus from "./SelectStatus";
import axios from "axios";

// Modal.setAppElement('#main');
// Modal.setAppElement(document.getElementById("main"));
const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    border                : 'none',
    padding               : '0',
    transform             : 'translate(-50%, -50%)'
  }
};
class UserHeader extends React.Component {
  constructor(props) {
    super(props);
    this.inputDescription = React.createRef();
    this.state = {
      modalIsOpen: true,
      errors: {},
      targetsArray: [],
      targetDescription: ''
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    // this.handleTargetInput = this.handleTargetInput.bind(this);
  }

  handleTargetInput(event) {
    this.setState({targetDescription: event.target.value});
  }

  createTarget(){
    if(this.state.targetDescription) {
      this.cleanErrorMessages();
      const target = this.state.targetsArray;
      target.push({ description: this.state.targetDescription, id: null, achieved: false, _destroy: null });
      this.setState({ targetsArray: target, targetDescription: ''});
    } else {
      this.cleanErrorMessages();
      this.addErrorMessages("add-new-target", "Field can't be blank", 1);
    }
  }

  removeTarget(index){
    // const target = this.targetsArray[index];
    const target = [...this.state.targetsArray];
    target.splice(index, 1);
    this.setState({targetsArray: target});
  }

  submitEvent(){
    console.log('this.props.eventsPath', this.props.eventsPath);
    axios
      .post(this.props.eventsPath, {
        event: {
          // status: this.status,
          description: this.inputDescription.current.value,
        },
      })
      .then(() => location.href = this.props.eventsUrl)
      .catch(error => console.log(error.response));
      // .catch(error => this.setState({errors: error.response.data.errors}));
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

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
  }
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

  render() {
    const { user, project, image_path, project_path, statuses, events } = this.props;
    const gravatar = require("gravatar");

    return (
      <div className="container row pt-3 px-4" id="main">
        <div className="py-2">
          <img className="user-avatar" src={gravatar.url(user.email)} />
        </div>
        <div className="col-9 px-4">
          <div className="row bordered">
            <div className="col-5 first-last-user-name mr-5 py-2 br">
              <h2>
                {user.first_name} {user.last_name}
              </h2>
              <div className="position text-muted">
                <span>{user.position}</span>
                <div className="company">
                  <a href={project_path}>
                    <i className="fas fa-building short"/>
                    {project.name}
                  </a>
                </div>
              </div>
              <div className="actions py-4">
                <a className="btn btn-success" href="#" onClick={this.openModal}>
                  <i className="fas fa-calendar-plus short"/>
                  <span>Create Event</span>
                </a>
                <a
                  className="mail btn btn-primary"
                  href="mailto:`${user.email}`"
                >
                  <i className="fas fa-envelope"/>
                </a>
              </div>
            </div>
            {/*Modal starts*/}
            <Modal
              // className="modal fade"
              // id="popUpModal"
              // tabIndex="-1"
              // role="dialog"
              // ariaLabelledby="popUpModalTitle"
              // ariaHidden="true"
              isOpen={this.state.modalIsOpen}
              onRequestClose={this.closeModal}
              style={customStyles}
              contentLabel="Example Modal"
              ariaHideApp={false}
            >
              <div className="modal-dialog dialog-style" role="document">
                <div className="modal-content">
                  <div className="modal-header">
                    <h5 className="modal-title">Event form</h5>
                    <button
                      type="button"
                      className="close"
                      data-dismiss="modal"
                      aria-label="Close"
                      onClick={this.closeModal}
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
                      <SelectStatus
                      options={statuses}
                      handleChange={value => this.setState({status: value})}
                      />
                    </div>

                    <div
                      id="modal-description"
                      className="form-group mb-3"
                    >
                      <label htmlFor="description">Description</label>
                      <textarea
                        className="form-control"
                        id="description"
                        ref={this.inputDescription}
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
                          // v-model="startDate"
                          className="form-control"
                          id="start_date"
                          type="date"
                        />
                      </div>
                      <div>
                        <label htmlFor="finish_date">Finish date</label>
                        <input
                          // v-model="finishDate"
                          className="form-control"
                          id="finish_date"
                          type="date"
                        />
                      </div>
                    </div>
{/*TARGETS*/}
                    <div
                      id="modal-targets"
                      className="form-group mb-3"
                    >
                      <label>Targets</label>
                      <div id="targets">
                        {this.state.targetsArray.map((target) => {
                          return(
                              <div className="mb-1" key={target.description}>
                                <div className="d-flex align-items-center justify-content-between">
                                  <div className="pl-3 flex-fill d-flex align-items-center p-1 border-bottom">
                                    {target.description}
                                  </div>
                                    <div className="d-flex justify-content-end">
                                      <button
                                        className="btn bg-white text-danger m-0 ml-2"
                                        onClick={this.removeTarget.bind(this)}>&#10008;</button>
                                    </div>
                                </div>
                              </div>
                        )})}
                      </div>

                      {/*Add new target*/}
                      <div className="d-flex align-items-start">
                        <div className="flex-fill">
                          <input
                            id="add-new-target"
                            //keyup.enter="createTargetInput" -- should create on enter I suppose
                            className="form-control"
                            type="search"
                            placeholder="Target description"
                            value={this.state.targetDescription}
                            onChange={(event) => this.handleTargetInput(event)}
                          />
                        </div>
                        <div>
                          <button
                            id="add-target"
                            className="btn btn-light text-success m-0 ml-2"
                            onClick={() => this.createTarget()}
                          >&#10010;</button>
                        </div>
                      </div>
                    </div>
{/*TARGETS END*/}
                    <div
                      id="modal-comments"
                      className="mb-3"
                    >
                      <label>Comments</label>
                      <textarea
                        // v-model="comments"
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

                    <div className="modal-footer footer-style">
                      <div id="modal-create" className="modal-style">
                        <button
                          className="btn bg-secondary text-white m-0"
                          id="cancel"
                          data-dismiss="modal"
                          aria-label="Close"
                          onClick={this.closeModal}
                        >Cancel</button>
                        <button
                          className="btn btn-warning text-white m-0"
                          id="create-event"
                          onClick={() => this.submitEvent()}
                        >Submit</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </Modal>
              {/*Modal ends*/}
            <div className="py-3">
              <h6>
                <b>USER INFO</b>
              </h6>
              <div className="row">
                <div className="col-7">
                  <ul className="list-unstyled">
                    <li>
                      <i className="fa fa-envelope"/>
                      Email:
                    </li>
                    <li>
                      <i className="fa fa-phone"/>
                      Phone:
                    </li>
                    <li>
                      <i className="fa fa-birthday-cake"/>
                      Birthday:
                    </li>
                    <li>
                      <i className="fa fa-calendar-check"/>
                      Start in Company:
                    </li>
                  </ul>
                </div>
                <div className="col-5">
                  <ul className="list-unstyled">
                    <li className="text-muted">{user.email}</li>
                    <li className="text-muted">{user.phone}</li>
                    <li className="text-muted">{user.birthday}</li>
                    <li className="text-muted">{user.start_in_company}</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

UserHeader.propTypes = {
  statuses: PropTypes.array,
  targetDescription: PropTypes.string,
  eventsPath: PropTypes.string
};
export default UserHeader;
