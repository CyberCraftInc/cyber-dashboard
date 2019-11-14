import React, { Component } from 'react'

const dropdownHeaderClassName = (isOpen) => {
  let result = 'dropdown__header'
  if (isOpen) { result = result + ' ' + 'is-active' }
  return result
};

const menuItemComponent = (menuItemObject, index) => {
  return <li key={index}>
    <a href={menuItemObject.url} data-method={menuItemObject.dataMethod}>{menuItemObject.title}</a>
  </li>
};

class TopHeaderDropdownMenu extends Component {
  constructor() {
    super()
    this.state = { isOpen: false }
  }
  
  toggleDropdownMenu() {
    this.setState({ isOpen: !this.state.isOpen })
  }
  
  render() {
    let { username, profileLink, editUserLink, adminLink, logoutLink } = this.props
    let menuItems = [
      { title: 'Profile', url: profileLink, },
      { title: 'Edit user', url: editUserLink, },
      { title: 'Admin', url: adminLink, },
      { title: 'Logout', url: logoutLink, dataMethod: 'delete', },
    ]

    return <div className='dropdown'>
        <div
          className={dropdownHeaderClassName(this.state.isOpen)}
          onClick={() => this.toggleDropdownMenu()}
        >
          <span>{username}</span>
          <span
            className='dropdown-toggle'
            data-toggle
          ></span>
        </div>

        <div
          className='dropdown__content'
          onMouseLeave={() => this.toggleDropdownMenu()}
        >
          <ul className='nav navbar-nav'>
            {menuItems.map(menuItemComponent)}
          </ul>
        </div>
    </div>
  };
};

export default TopHeaderDropdownMenu;
