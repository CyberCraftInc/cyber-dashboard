import React from "react";
import PropTypes from "prop-types";
import profileImage from "../images/user-no-logo.png";

class ShowProject extends React.Component {
  constructor(props) {
    super(props);
  }

  renderImageProfile(userImage) {
    return userImage && userImage != "null" ? (
      <img src={userImage} height="50" width="50" alt="user=profile" />
    ) : (
      <img src={profileImage} height="50" width="50" alt="user=profile" />
    );
  }

  render_user(user) {
    return (
      <div className="shadow-sm my-2 p-3 pr-5 bg-white rounded d-flex">
        {this.renderImageProfile(user.avatar)}
        <div className="pl-4">
          <h5>{`${user.first_name} ${user.last_name}`}</h5>
          <div>{user.position}</div>
        </div>
        <div className="ml-auto my-auto">
          <button
            id={`open-profile${user.id}`}
            className="btn btn-info"
            onClick={() => (window.location.href = `/users/${user.id}`)}
          >
            Open profile
          </button>
        </div>
      </div>
    );
  }

  render() {
    const { users, name, desc } = this.props.project;

    return (
      <div className="mt-4">
        <h2>{name}</h2>
        <blockquote>{desc}</blockquote>
        {users.map(user => this.render_user(user))}
      </div>
    );
  }
}

ShowProject.propTypes = {
  project: PropTypes.object
};

export default ShowProject;
