import React, { Component } from 'react'

const klassName = 'dropdown__header';
const dropdownHeaderClassName = function(isOpen) {
  return (isOpen ? klassName + ' is-active' : klassName);
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
    super()
    this.state = { isOpen: false };
  };
  
  toggleDropdownMenu() {
    this.setState({ isOpen: !this.state.isOpen });
  };
  
  render() {
    const { username, profileLink, editUserLink, adminLink, logoutLink } = this.props;
    const menuItems = [
      { title: 'Profile', url: profileLink, },
      { title: 'Edit user', url: editUserLink, },
      { title: 'Admin', url: adminLink, },
      { title: 'Logout', url: logoutLink, dataMethod: 'delete', },
    ];

    return (
      <div className='dropdown'>
        <div className={dropdownHeaderClassName(this.state.isOpen)} onClick={() => this.toggleDropdownMenu()}>
          <span>{username}</span>
          <span className='dropdown-toggle' data-toggle></span>
        </div>

        <div className='dropdown__content' onMouseLeave={() => this.toggleDropdownMenu()}>
          <ul className='nav navbar-nav'>{menuItems.map(menuItemComponent)}</ul>
        </div>
      </div>
    );
  };
};

export default TopHeaderDropdownMenu;
