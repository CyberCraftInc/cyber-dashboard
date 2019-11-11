import React from 'react';

class TopHeader extends React.Component {
  render() {
    let { username } = this.props

    return <div>
      Top header
      <br />
      <span>Attribute from props: Hello, <b>{username}</b>!</span>
    </div>;
  };
};

export default TopHeader;
