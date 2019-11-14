import * as React from "react";
import axios from "axios";
import PropTypes from "prop-types";

class SignIn extends React.Component {
  constructor(props) {
    super(props);
    this.state = {remember_me: 0};
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
      .catch(error => console.log(error.response));
  }

  render() {
    const {flash} = this.props;
    return (<div id="logging-box">
      <div className="row">
        <div className="offset-md-2.col-md-8">
          <h4>Log in</h4>
          { flash.length > 0 && flash.map(errorItem => (<div className="alert alert-danger flash_notice" role={errorItem[0]}>{errorItem[1]}</div>)) }
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
          <div><button className="btn" onClick={() => this.signIn()}>Log in</button></div>
        </div>
      </div>
    </div>);
  }
}

SignIn.propTypes = {
  signInPath: PropTypes.string,
  flash: PropTypes.object,
  root: PropTypes.string
};

export default SignIn;
