import React from "react";
import axios from "axios";
import TopHeaderDropdownMenu from "./TopHeaderDropdownMenu";

class TopHeader extends React.Component {
  constructor() {
    super();

    this.state = {
      username: "Guest",
      isAdmin: false,
      profileLink: "/", // change when profile page will be rewrited to react
      editUserLink: "/edit",
      adminLink: "/admin",
      logoutLink: "/logout"
    };
  }

  componentDidMount() {
    axios
      .get("/api/v1/header", {})
      .then(response => {
        response &&
          this.setState({
            username: response.data.username,
            isAdmin: response.data.isAdmin,
            profileLink: response.data.profileLink,
            adminLink: response.data.adminLink,
            logoutLink: response.data.logoutLink
          });
      })
      .catch(error =>
        this.setState({ errorFromAPI: error.response.data.error })
      );
  }

  render() {
    const {
      username,
      isAdmin,
      profileLink,
      editUserLink,
      adminLink,
      logoutLink
    } = this.state;
    const topHeaderDropdownMenuComponent = function() {
      return (
        <TopHeaderDropdownMenu
          username={username}
          isAdmin={isAdmin}
          profileLink={profileLink}
          editUserLink={editUserLink}
          adminLink={adminLink}
          logoutLink={logoutLink}
        />
      );
    };

    return (
      <nav className="navbar navbar-dark bg-dark">
        <a className="navbar-brand" href="/">
          <img
            className="d-inline-block align-top"
            alt=""
            width="90"
            height="35"
            src="/images/logo.png"
          />
          <div className="header_text">CyberCraft Dashboard</div>
        </a>
        {username && topHeaderDropdownMenuComponent()}
      </nav>
    );
  }
}

export default TopHeader;
