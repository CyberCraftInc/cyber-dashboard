import * as React from "react";
import axios from "axios";
import PropTypes from "prop-types";
import GoogleImage from "../images/google+.png";

class SignIn extends React.Component {
  constructor(props) {
    super(props);
    this.state = {remember_me: 0, errorFromAPI: ""};
    this.inputEmail = React.createRef();
    this.inputPassword = React.createRef();
  }

  signIn() {
    axios
      .post(this.props.signInPath, {
        user: {
          password: this.inputPassword.current.value,
          email: this.inputEmail.current.value,
          remember_me: this.state.remember_me
        }
      })
      .then(() => location.href = this.props.root)
      .catch(error => this.setState({errorFromAPI: error.response.data.error}));
  }

  renderErrorSection(flash) {
    return (flash.length > 0 ? flash.map(errorItem => (
      <div key={errorItem[1]} className="alert alert-danger flash_notice"
           role={errorItem[0]}>{errorItem[1]}</div>)) : this.state.errorFromAPI.length > 0 &&
      <div className="alert alert-danger flash_notice">{this.state.errorFromAPI}</div>);
  }

  render() {
    const {flash, googleOauthPath, signUpPath, newPasswordPath} = this.props;
    return (<div id="logging-box">
      <div className="row">
        <div className="offset-md-2.col-md-8">
          <h4>Log in</h4>
          {this.renderErrorSection(flash)}
          <div>
            <label htmlFor="email"> Email </label>
            <input
              className="form-control"
              type="email"
              id="email"
              ref={this.inputEmail}
            />
          </div>
          <div>
            <label htmlFor="password"> Password </label>
            <input
              className="form-control"
              type="password"
              id="password"
              ref={this.inputPassword}
            />
          </div>
          <div>
            <button className="btn" onClick={() => this.signIn()}>Log in</button>
            <a className="btn btn-primary ml-3" href={signUpPath}>Sign Up</a>
            <a id='oauth' className="btn" href={googleOauthPath}><img alt="google+" src={GoogleImage} border="0" width="50"
                                                           height="50"/></a>
            <div><a href={newPasswordPath} title="New password">Forgot your password?</a></div>
          </div>
        </div>
      </div>
    </div>);
  }
}

SignIn.propTypes = {
  signInPath: PropTypes.string,
  flash: PropTypes.array,
  root: PropTypes.string,
  signUpPath: PropTypes.string,
  googleOauthPath: PropTypes.string,
  forgotPasswordPath: PropTypes.string,
  newPasswordPath: PropTypes.string,
};

export default SignIn;
