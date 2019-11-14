import React from 'react';
import TopHeaderDropdownMenu from './TopHeaderDropdownMenu';

class TopHeader extends React.Component {
  render() {
    let { username, isAdmin, profileLink, editUserLink, adminLink, logoutLink } = this.props;

    let topHeaderDropdownMenuComponent = () => {
      if (username) {
        return <TopHeaderDropdownMenu
          username={username}
          isAdmin={isAdmin}

          profileLink={profileLink}
          editUserLink={editUserLink}
          adminLink={adminLink}
          logoutLink={logoutLink}
        />
      } else {
        return null;
      };
    };

    return <nav className='navbar navbar-dark bg-dark'>
      <a className='navbar-brand' href='/'>
        <img className='d-inline-block align-top' alt='' width='90' height='35' src='/images/logo.png' />
        <div className='header_text'>CyberCraft Dashboard</div>
      </a>
      {topHeaderDropdownMenuComponent()}
    </nav>
  };
};

export default TopHeader;
