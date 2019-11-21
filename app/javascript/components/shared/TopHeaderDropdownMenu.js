import React, { Component } from "react";
import PropTypes from "prop-types";

const klassName = "dropdown__header";
const dropdownHeaderClassName = function(isOpen) {
  return (isOpen ? klassName + " is-active" : klassName);
};
const menuItemComponent = function(menuItemObject, index) {
  return (
    <li key={index}>
      <a href={menuItemObject.url} data-method={menuItemObject.dataMethod}>{menuItemObject.title}</a>
    </li>
  );
};

class TopHeaderDropdownMenu extends Component {
  constructor() {
    super();
    this.state = { isOpen: false };
  }
  
  toggleDropdownMenu() {
    this.setState({ isOpen: !this.state.isOpen });
  }
  
  render() {
    const { username, profileLink, editUserLink, adminLink, logoutLink, isAdmin } = this.props;
    const menuItems = [
      { title: "Profile", url: profileLink, },
      { title: "Edit profile", url: editUserLink, },
      { title: "Logout", url: logoutLink, dataMethod: "delete", },
    ];
    isAdmin && menuItems.splice(2, 0, { title: "Admin", url: adminLink, });
    return (
      <div className="dropdown">
        <div className={dropdownHeaderClassName(this.state.isOpen)} onClick={() => this.toggleDropdownMenu()}>
          <span>{username}</span>
          <span className="dropdown-toggle" data-toggle></span>
        </div>

        <div className="dropdown__content" onMouseLeave={() => this.toggleDropdownMenu()}>
          <ul className="nav navbar-nav">{menuItems.map(menuItemComponent)}</ul>
        </div>
      </div>
    );
  }
}

TopHeaderDropdownMenu.propTypes = {
  username: PropTypes.string,
  profileLink: PropTypes.string,
  editUserLink: PropTypes.string,
  adminLink: PropTypes.string,
  logoutLink: PropTypes.string,
  isAdmin: PropTypes.bool
};

export default TopHeaderDropdownMenu;
