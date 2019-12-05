import React from "react";
import PropTypes from "prop-types";
import Modal from "react-modal";
import axios from "axios";

const modalStyles = {
  content : {
    top                   : "50%",
    left                  : "50%",
    right                 : "auto",
    bottom                : "auto",
    marginRight           : "-50%",
    border                : "none",
    padding               : "0",
    transform             : "translate(-50%, -50%)"
  }
};

class UserHeader extends React.Component {
  constructor(props) {
    super(props);
    this.inputDescription = React.createRef();
    this.inputStartDate = React.createRef();
    this.inputFinishDate = React.createRef();
    this.inputComments = React.createRef();
    this.inputSummary = React.createRef();
    this.state = {
      modalIsOpen: false,
      errors: {},
      selectedStatus: "scheduled",
      targets: [],
      targetDescription: ""
    };
    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  handleTargetInput(event) {
    event.preventDefault();
    this.setState({targetDescription: event.target.value});
  }

  handleStatusSelect(event){
    this.setState({selectedStatus: event.target.value});
  }

  createTarget(){
    if(this.state.targetDescription) {
      this.cleanErrorMessages();
      const targets_list = this.state.targets;
      targets_list.push({ description: this.state.targetDescription, id: null, achieved: false, _destroy: null });
      this.setState({ targets: targets_list, targetDescription: ""});
    } else {
      this.cleanErrorMessages();
      this.addErrorMessages("add-new-target", "Field can't be blank", 1);
    }
  }

  removeTarget(index){
    const targets = [...this.state.targets];
    targets.splice(index, 1);
    this.setState({targets: targets});
  }

  submitEvent(){
    axios
      .post("/events",{
        event: {
          status: this.state.selectedStatus,
          start_date: this.inputStartDate.current.value,
          finish_date: this.inputFinishDate.current.value,
          description: this.inputDescription.current.value,
          targets_attributes: this.state.targets,
          comments: this.inputComments.current.value,
          summary: this.inputSummary.current.value,
          user_id: this.props.user["id"]
        },
      }).then(response => this.showNotice(response.data));
  }
   showNotice (response) {
      if (response.status === "created" || response.status === "updated") {
        location.reload();
      } else {
        this.cleanErrorMessages();
        for (let error in response) {
          this.addErrorMessages(error, response[error], 3);
        }
      }
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
    const { user, project, project_path, generateICSURL } = this.props;
    const gravatar = require("gravatar");
    return (
      <div className="container row pt-3 px-4">
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
                  className="btn btn-primary mail"
                  href={generateICSURL}
                  title="Generate ics file"
                >
                  <i className="fas fa-calendar"/>
                </a>
              </div>
            </div>
            {/*Modal starts*/}
            <Modal
              isOpen={this.state.modalIsOpen}
              onRequestClose={this.closeModal}
              style={modalStyles}
              contentLabel="Example Modal"
              ariaHideApp={false}
              user={this.props.user}
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
                  {/*Select Status*/}
                  <div className="modal-body d-flex flex-column">
                    <div id="modal-status" className="form-group mb-3">
                      <label htmlFor="status">Status</label>
                      <select
                        onChange={(event) => this.handleStatusSelect(event)}
                        className="form-control select">
                          <option value={"scheduled"}>Scheduled</option>
                          <option value={"canceled"}>Canceled</option>
                          <option value={"done"}>Done</option>
                        ))
                      </select>
                    </div>
                    {/*Event Description*/}
                    <div id="modal-description" className="form-group mb-3">
                      <label htmlFor="description">Description</label>
                      <textarea
                        className="form-control"
                        id="description"
                        ref={this.inputDescription}
                        placeholder="Type an event description here"
                      />
                    </div>
                    {/*Start Finish Date*/}
                    <div id="modal-period" className="d-flex justify-content-start form-group mb-3">
                      <div className="mr-4">
                        <label htmlFor="start_date">Start date</label>
                        <input
                          className="form-control"
                          id="start_date"
                          type="date"
                          ref={this.inputStartDate}
                        />
                      </div>
                      <div>
                        <label htmlFor="finish_date">Finish date</label>
                        <input
                          className="form-control"
                          id="finish_date"
                          type="date"
                          ref={this.inputFinishDate}
                        />
                      </div>
                    </div>
                    {/*TARGETS*/}
                    <div id="modal-targets" className="form-group mb-3">
                      <label>Targets</label>
                      <div id="targets">
                        {this.state.targets.map((target) => {
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
                        );})}
                      </div>
                      {/*Add new target*/}
                      <div className="d-flex align-items-start">
                        <div className="flex-fill">
                          <input
                            id="add-new-target"
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
                    {/*Comments Summary*/}
                    <div id="modal-comments" className="mb-3">
                      <label>Comments</label>
                      <textarea className="form-control" ref={this.inputComments}/>
                    </div>

                    <div id="modal-summary" className="mb-3">
                      <label>Summary</label>
                      <textarea className="form-control" ref={this.inputSummary}/>
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
  user: PropTypes.object,
  project: PropTypes.object,
  image_path: PropTypes.string,
  project_path: PropTypes.string,
  generateICSURL: PropTypes.string,
  statuses: PropTypes.array,
  targets: PropTypes.array,
  targetDescription: PropTypes.string,
  events_path: PropTypes.string,
  events: PropTypes.array
};

export default UserHeader;
