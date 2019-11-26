import * as React from "react";
import axios from "axios";
import InputMask from "react-input-mask";

class EditUser extends React.Component {
  constructor() {
    super();
    this.inputFirstName = React.createRef();
    this.inputCurrentPassword = React.createRef();
    this.inputLastName = React.createRef();
    this.inputBirthday = React.createRef();
    this.inputPhone = React.createRef();
    this.inputNewPassword = React.createRef();
    this.inputConfirmPassword = React.createRef();
    this.state = {
      notice: "",
      isSuccessNotice: false,
      inputAvatar: null,
      updatePath: "/users",
      user: {
        first_name: "",
        las_name: ""
      }
    };
  }

  componentDidMount() {
    axios
      .get("/api/v1/users/current/edit")
      .then(response => {
        this.setState({
          user: response.data.user,
          updatePath: response.data.updatePath
        });
      })
      .catch(error => console.log(error.response.data));
  }

  setDataUrl = preview => {
    const reader = new FileReader();
    reader.addEventListener(
      "load",
      () => {
        this.setState({ inputAvatar: reader.result });
      },
      false
    );
    reader.readAsDataURL(preview);
  };

  onChangeHandler = event => {
    this.setDataUrl(event.target.files[0]);
  };

  submitForm() {
    const data = new FormData();

    data.append("user[first_name]", this.inputFirstName.current.value);
    data.append("user[last_name]", this.inputLastName.current.value);
    data.append(
      "user[phone]",
      this.inputPhone.current.value.replace(/[() ]/g, "")
    );
    data.append("user[birthday]", this.inputBirthday.current.value);
    data.append("user[password]", this.inputNewPassword.current.value);
    data.append(
      "user[password_confirmation]",
      this.inputConfirmPassword.current.value
    );
    data.append(
      "user[current_password]",
      this.inputCurrentPassword.current.value
    );
    data.append("user[avatar]", this.state.inputAvatar);

    axios
      .put(this.state.updatePath, data)
      .then(response => this.showNotice(response.data))
      .catch(error => console.log(error.response));
  }

  showNotice(response) {
    const message = () => {
      if (response.success) {
        window.setTimeout(function() {
          location.href = "/";
        }, 3000);
        this.setState({ isSuccessNotice: true });
        return "Profile updated. You will be redirected in 3 seconds";
      } else if (response.errors != 0) {
        this.setState({ isSuccessNotice: false });
        return response.errors;
      }
    };
    this.setState({ notice: message() });
  }

  render() {
    return (
      <div id="edit-user">
        <h2>Profile information</h2>
        <div>
          <label htmlFor="currentPassword">
            {" "}
            Current password (must be for edit data){" "}
          </label>
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
            defaultValue={this.state.user.first_name}
            ref={this.inputFirstName}
          />
        </div>
        <div>
          <label htmlFor="userLastName"> Last name </label>
          <input
            className="form-control"
            type="text"
            id="userLastName"
            defaultValue={this.state.user.last_name}
            ref={this.inputLastName}
          />
        </div>
        <div>
          <label htmlFor="userPhone"> Phone </label>
          <InputMask
            className="form-control"
            id="userPhone"
            alwaysShowMask={true}
            mask="+38 (099) 999 99 99"
            maskChar="_"
            ref={this.inputPhone}
            defaultValue={this.state.user.phone}
          />
        </div>
        <div>
          <label htmlFor="userBirthday"> Birthday </label>
          <input
            className="form-control"
            type="date"
            id="userBirthday"
            defaultValue={this.state.user.birthday}
            ref={this.inputBirthday}
          />
        </div>
        <div>
          <label htmlFor="userAvatar"> Avatar </label>
          <input
            className="form-control-file"
            id="userAvatar"
            type="file"
            name="file"
            onChange={this.onChangeHandler}
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
          <button
            id="button-edit"
            onClick={() => this.submitForm()}
            className="btn btn-warning"
          >
            Update
          </button>
        </div>
        <span
          id="notice"
          style={{ color: this.state.isSuccessNotice ? "green" : "red" }}
        >
          {this.state.notice}
        </span>
      </div>
    );
  }
}

export default EditUser;
