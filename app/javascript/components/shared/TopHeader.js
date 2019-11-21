import React from "react";
import PropTypes from "prop-types";
import TopHeaderDropdownMenu from "./TopHeaderDropdownMenu";

class TopHeader extends React.Component {
  render() {
    const { username, isAdmin, profileLink, editUserLink, adminLink, logoutLink } = this.props;
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
          <img className="d-inline-block align-top" alt="" width="90" height="35" src="/images/logo.png" />
          <div className="header_text">CyberCraft Dashboard</div>
        </a>
        {(username && topHeaderDropdownMenuComponent())}
      </nav>
    );
  }
}

TopHeader.propTypes = {
  username: PropTypes.string,
  isAdmin: PropTypes.bool,
  profileLink: PropTypes.string,
  editUserLink: PropTypes.string,
  adminLink: PropTypes.string,
  logoutLink: PropTypes.string,
};

export default TopHeader;
