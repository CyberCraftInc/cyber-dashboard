import * as React from "react";
import axios from "axios";
import PropTypes from "prop-types";
import InputMask from "react-input-mask";
import SelectProject from "./SelectProject";

class SignUp extends React.Component {
  constructor(props) {
    super(props);
    this.inputFirstName = React.createRef();
    this.inputEmail = React.createRef();
    this.inputLastName = React.createRef();
    this.inputBirthday = React.createRef();
    this.inputPassword = React.createRef();
    this.inputStartInCompany = React.createRef();
    this.inputPosition = React.createRef();
    this.inputConfirmPassword = React.createRef();
    this.state = {inputPhone: "", chooseProjectID: this.props.projects[0].id, errors: {}};
  }

  submitForm() {
    axios
      .post(this.props.signUpURL, {
        user: {
          first_name: this.inputFirstName.current.value,
          last_name: this.inputLastName.current.value,
          phone: this.state.inputPhone.replace(/[()+ ]/g, ""),
          birthday: this.inputBirthday.current.value,
          email: this.inputEmail.current.value,
          start_in_company: this.inputStartInCompany.current.value,
          position: this.inputPosition.current.value,
          password: this.inputPassword.current.value,
          password_confirmation: this.inputConfirmPassword.current.value,
          project_id: this.state.chooseProjectID,
        },
      })
      .then(() => location.href = this.props.signUpURL)
      .catch(error => this.setState({errors: error.response.data.errors}));
  }

  onChangeInputPhone = (event) => {
    this.setState({
      inputPhone: event.target.value
    });
  };

  errorSection() {
    return (
      Object.keys(this.state.errors).length !== 0 && <div id="error_explanation">
        <ul>
          {
            Object.keys(this.state.errors).map((field) => this.state.errors[field].map((error) => (
              <li key={field + error}>
                <span className='text-capitalize'>{field.replace("_", " ")}</span>
                <span>{` ${error}`}</span>
              </li>)))
          }
        </ul>
      </div>);
  }

  render() {
    const {user, projects, minimumPasswordLength} = this.props;
    return (<div>
      {this.errorSection()}
      <h3>Sign Up</h3>
      <div className="row">
        <div className="col-md-6">
          <div>
            <label htmlFor="firstName"> First name </label>
            <input
              className="form-control"
              type="text"
              id="firstName"
              ref={this.inputFirstName}
              defaultValue={user.first_name}
            />
          </div>
          <div>
            <label htmlFor="lastName"> Last name </label>
            <input
              className="form-control"
              type="text"
              id="lastName"
              ref={this.inputLastName}
              defaultValue={user.last_name}
            />
          </div>
          <div>
            <label htmlFor="phone"> Phone </label>
            <InputMask
              className="form-control"
              id="phone"
              alwaysShowMask={true}
              mask="+38 (999) 999 99 99"
              maskChar="_"
              onChange={this.onChangeInputPhone}
            />
          </div>
          <div>
            <label htmlFor="email"> Email </label>
            <input
              className="form-control"
              type="email"
              id="email"
              ref={this.inputEmail}
              defaultValue={user.email}
            />
          </div>
          <div>
            <label htmlFor="birthday"> Birthday </label>
            <input
              className="form-control"
              type="date"
              id="birthday"
              ref={this.inputBirthday}
              defaultValue={user.birthday}
            />
          </div>
          <div>
            <label htmlFor="startInCompany"> Start in company </label>
            <input
              className="form-control"
              type="date"
              id="startInCompany"
              defaultValue={new Date().toISOString().substring(0, 10)}
              ref={this.inputStartInCompany}
            />
          </div>
          <div>
            <label htmlFor="position"> Position </label>
            <input
              className="form-control"
              type="text"
              id="position"
              ref={this.inputPosition}
              defaultValue={user.position}
            />
          </div>
          <div>
            <label htmlFor="password"> Password <em>{minimumPasswordLength || 6} characters minimum</em></label>
            <input
              className="form-control"
              type="password"
              id="password"
              ref={this.inputPassword}
            />
          </div>
          <div>
            <label htmlFor="confirmPassword"> Confirm password </label>
            <input
              className="form-control"
              type="password"
              id="confirmPassword"
              ref={this.inputConfirmPassword}
            />
          </div>
          <div>
            <label htmlFor="selectProject"> Project </label>
            <SelectProject
              options={projects}
              handleChange={value => this.setState({chooseProjectID: value})}
            />
          </div>
          <div>
            <button onClick={() => this.submitForm()} className="btn btn-warning">Sign up</button>
          </div>
        </div>
      </div>
    </div>);
  }
}

SignUp.propTypes = {
  minimumPasswordLength: PropTypes.number,
  projects: PropTypes.array,
  signUpURL: PropTypes.string,
  user: PropTypes.object
};

export default SignUp;
