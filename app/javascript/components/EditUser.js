import * as React from "react";
import axios from "axios";
import InputMask from "react-input-mask";
import PropTypes from "prop-types";

class EditUser extends React.Component {
  constructor(props) {
    super(props);
    this.inputFirstName = React.createRef();
    this.inputCurrentPassword = React.createRef();
    this.inputLastName = React.createRef();
    this.inputBirthday = React.createRef();
    this.inputNewPassword = React.createRef();
    this.inputConfirmPassword = React.createRef();
    this.state = {notice: "", isSuccessNotice: false, inputPhone: this.props.user.phone};
  }

  submitForm() {
    axios
      .put(this.props.updatePath, {
        user: {
          first_name: this.inputFirstName.current.value,
          last_name: this.inputLastName.current.value,
          phone: this.state.inputPhone.replace(/[()+ ]/g, ""),
          birthday: this.inputBirthday.current.value,
          password: this.inputNewPassword.current.value,
          password_confirmation: this.inputConfirmPassword.current.value,
          current_password: this.inputCurrentPassword.current.value,
        }
      })
      .then(response => this.showNotice(response.data))
      .catch(error => console.log(error.response));
  }

  showNotice(response) {
    const message = () => {
      if (response.success) {
        window.setTimeout(function () {
          location.href = "/";
        }, 3000);
        this.setState({isSuccessNotice: true});
        return "Profile updated. You will be redirected in 3 seconds";
      } else if (response.errors != 0) {
        this.setState({isSuccessNotice: false});
        return response.errors;
      }
    };
    this.setState({notice: message()});
  }

  onChangeInputPhone = (event) => {
    this.setState({
      inputPhone: event.target.value
    });
  };

  render() {
    return (<div id="edit-user">
      <h2>Profile information</h2>
      <div>
        <label htmlFor="currentPassword"> Current password (must be for edit data) </label>
        <input
          className="form-control"
          type="password"
          id="currentPassword"
          ref={this.inputCurrentPassword}
        />
      </div>
      <div>
        <label htmlFor="userFirstName"> First name </label>
        <input
          className="form-control"
          type="text"
          id="userFirstName"
          defaultValue={this.props.user.first_name}
          ref={this.inputFirstName}
        />
      </div>
      <div>
        <label htmlFor="userLastName"> Last name </label>
        <input
          className="form-control"
          type="text"
          id="userLastName"
          defaultValue={this.props.user.last_name}
          ref={this.inputLastName}
        />
      </div>
      <div>
        <label htmlFor="userPhone"> Phone </label>
        <InputMask
          className="form-control"
          id="userPhone"
          value={this.state.inputPhone}
          alwaysShowMask={true}
          mask="+38 (999) 999 99 99"
          maskChar="_"
          onChange={this.onChangeInputPhone}
        />
      </div>
      <div>
        <label htmlFor="userBirthday"> Birthday </label>
        <input
          className="form-control"
          type="date"
          id="userBirthday"
          defaultValue={this.props.user.birthday}
          ref={this.inputBirthday}
        />
      </div>
      <div>
        <label htmlFor="newPassword"> New password </label>
        <input
          className="form-control"
          type="password"
          id="newPassword"
          ref={this.inputNewPassword}
        />
      </div>
      <div>
        <label htmlFor="confirmNewPassword"> Confirm new password </label>
        <input
          className="form-control"
          type="password"
          id="confirmNewPassword"
          ref={this.inputConfirmPassword}
        />
      </div>
      <div>
        <button id="button-edit" onClick={() => this.submitForm()} className="btn btn-warning">Update</button>
      </div>
      <span id="notice" style={{color: this.state.isSuccessNotice ? "green" : "red"}}>{this.state.notice}</span>

    </div>);
  }
}

EditUser.propTypes = {
  updatePath: PropTypes.string,
  user: PropTypes.object
};

export default EditUser;