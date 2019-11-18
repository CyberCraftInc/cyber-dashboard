import React from "react";

class UserHeader extends React.Component {
  render() {
    const { user, project, image_path, project_path } = this.props;

    return (
      <div className="container row pt-3 px-4">
        <div className="py-2">
          <img className="user-avatar" src={image_path} />
        </div>
        <div className="col-9 px-4">
          <div className="row bordered">
            <div className="col-5 first-last-user-name mr-5 py-2 br">
              <h2>
                {user.first_name} {user.last_name}
              </h2>
              <div className="position text-muted">
                <span>{user.position}</span>
                <div className="company">
                  <a href={project_path}>
                    <i className="fa fa-building short"></i>
                    {project.name}
                  </a>
                </div>
              </div>
              <div className="actions py-4">
                <a className="btn btn-success" href="#">
                  <i className="fas fa-calendar-plus short"></i>
                  <span>Create Event</span>
                </a>
                <a
                  className="mail btn btn-primary"
                  href="mailto:`${user.email}`"
                >
                  <i className="fas fa-envelope"></i>
                </a>
              </div>
            </div>
            <div className="py-3">
              <h6>
                <b>USER INFO</b>
              </h6>
              <div className="row">
                <div className="col-7">
                  <ul className="list-unstyled">
                    <li>
                      <i className="fa fa-envelope"></i>
                      Email:
                    </li>
                    <li>
                      <i className="fa fa-phone"></i>
                      Phone:
                    </li>
                    <li>
                      <i className="fa fa-birthday-cake"></i>
                      Birthday:
                    </li>
                    <li>
                      <i className="fa fa-calendar-check"></i>
                      Start in Company:
                    </li>
                  </ul>
                </div>
                <div className="col-5">
                  <ul className="list-unstyled">
                    <li className="text-muted">{user.email}</li>
                    <li className="text-muted">{user.phone}</li>
                    <li className="text-muted">{user.birthday}</li>
                    <li className="text-muted">{user.start_in_company}</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default UserHeader;
