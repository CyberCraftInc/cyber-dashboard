import React, { Component } from 'react'

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
    let menuItemComponent = (menuItemObject) => {
      return <li>
        <a href={menuItemObject.url} data-method={menuItemObject.dataMethod}>{menuItemObject.title}</a>
      </li>
    }

    return <div class="dropdown">
        <div
          className={"dropdown__header" + (this.state.isOpen ? ' is-active' : '')}
          onClick={() => this.toggleDropdownMenu()}
        >
          <span>{username}</span>
          <span
            class="dropdown-toggle"
            data-toggle
            href
          ></span>
        </div>

        <div
          className={"dropdown__content" + (this.state.isOpen ? ' is-active' : '')}
          onMouseLeave={() => this.toggleDropdownMenu()}
        >
          <ul class="nav navbar-nav">
            {menuItems.map(menuItemComponent)}
          </ul>
        </div>
    </div>
  };
};

export default TopHeaderDropdownMenu;