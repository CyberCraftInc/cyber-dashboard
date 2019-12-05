import React, { Component } from "react";
import PropTypes from "prop-types";
import axios from "axios";
import { daysInCompany, birthday, position } from "../utils/SortUsers";
import SelectProject from "./SelectProject";
import CurrentTime from "./CurrentTime";
import profileImage from "../images/user-no-logo.png";

class Users extends Component {
  constructor() {
    super();

    this.state = {
      filteredUsers: [],
      usersList: []
    };
  }

  componentDidMount() {
    this.selectProject(this.props.usersPath);
  }

  addActiveClass = element => {
    element.parentNode.childNodes.forEach(el => {
      el.classList.remove("active");
    });
    element.classList.add("active");
  };

  filteredList = (search, currentUsers) =>
    currentUsers.filter(listOfUsers =>
      (
        listOfUsers.email +
        listOfUsers.phone +
        listOfUsers.first_name +
        listOfUsers.last_name +
        listOfUsers.position
      )
        .toLowerCase()
        .includes(search.toLowerCase())
    );

  sortBy = type => {
    switch (type) {
      case "position":
        this.setState({
          usersList: position(this.state.usersList)
        });
        break;
      case "birthday":
        this.setState({
          usersList: birthday(this.state.usersList)
        });
        break;
      case "days in company":
        this.setState({
          usersList: daysInCompany(this.state.usersList)
        });
        break;
      default:
        this.setState({
          usersList: this.props.users
        });
    }
  };

  selectProject = (url, value = 0) => {
    axios
      .get(url, {
        params: {
          id: value
        }
      })
      .then(response => {
        this.setState({
          usersList: response.data,
          filteredUsers: response.data
        });
      })
      .catch(error => console.log(error.response.data));
  };

  sortButtons = buttons => {
    return Object.entries(buttons).map((type, index) => (
      <button
        key={index}
        type="button"
        onClick={e => {
          this.addActiveClass(e.target);
          this.sortBy(type[0]);
        }}
        className={"btn btn btn-primary m-0 mb-2 mr-2"}
      >
        <i className={"fas " + type[1]}></i>
        {type[0]}
      </button>
    ));
  };

  checkBirthday = birthday =>
    new Date(birthday).toLocaleDateString().slice(0, 5) ==
      new Date().toLocaleDateString().slice(0, 5) && "🎂 ";

  render() {
    const { projects, usersPath, users } = this.props;
    const { filteredUsers, usersList } = this.state;

    return (
      <div>
        <h3 className="pl-4">Employees ({users.length})</h3>

        <div className="d-flex flex-wrap justify-content-between mt-4">
          <div className="pl-4">
            {this.sortButtons({
              position: "fa-user",
              birthday: "fa-birthday-cake",
              "days in company": "fa-calendar"
            })}
          </div>

          <div className="d-flex flex-wrap justify-content-between align-items-right">
            <div className="col-sm-12 col-md-6 mb-1 mb-md-0">
              <form id="search">
                <div className="input-group">
                  <div className="input-group-prepend">
                    <div className="input-group-text" id="btnGroupAddon">
                      <i className="fas fa-search" />
                    </div>
                  </div>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Search ..."
                    onChange={e => {
                      this.setState({
                        usersList: this.filteredList(
                          e.target.value,
                          filteredUsers
                        )
                      });
                    }}
                    aria-label="Search users"
                    id="query"
                  />
                </div>
              </form>
            </div>

            <div className="col-sm-12 col-md-6 p-sm-0">
              <div className="input-group">
                <div className="input-group-prepend">
                  <div className="input-group-text" id="btnGroupAddon">
                    <i className="fas fa-filter" />
                  </div>
                </div>
                <SelectProject
                  options={projects}
                  handleChange={value => this.selectProject(usersPath, value)}
                  placeholder="All employees"
                />
              </div>
            </div>
          </div>
        </div>

        <div className="d-flex bd-highlight users">
          <div className="d-flex flex-wrap justify-content-center justify-content-md-start user-list mt-2">
            {usersList.map(user => (
              <div
                key={user.id}
                onClick={() => {
                  location.href = `users/${user.id}`;
                }}
                className="card mb-5 m-md-4 m-sm-0 user"
                style={{ width: "18rem", height: "max-content" }}
              >
                <div
                  className="card-body d-flex align-items-center flex-column"
                  style={{ cursor: "pointer" }}
                >
                  {(() => {
                    if (user.avatar && user.avatar != "null") {
                      return (
                        <div
                          className="mb-2 img-thumbnail"
                          style={{
                            borderRadius: "50%",
                            width: "140px",
                            height: "140px",
                            overflow: "hidden",
                            backgroundImage: `url(${user.avatar})`,
                            backgroundSize: "cover"
                          }}
                        ></div>
                      );
                    } else return <i className="fas fa-user-circle"></i>;
                  })()}

                  <h5 className="card-title mt-3">
                    <strong>{this.checkBirthday(user.birthday)}</strong>
                    <strong>{user.first_name + " " + user.last_name}</strong>
                  </h5>
                  <h6 className="mb-2 justify-content-between user-position">
                    <span className="text-center">
                      <i>{user.position}</i>
                    </span>
                  </h6>

                  <address className="row">
                    <div className="col-1">
                      <ul className="list-unstyled">
                        <li>
                          <i className="fa fa-envelope"></i>
                        </li>
                        <li>
                          <i className="fa fa-phone"></i>
                        </li>
                        <li>
                          <i className="fa fa-birthday-cake"></i>
                        </li>
                      </ul>
                    </div>
                    <div className="col-10">
                      <ul className="list-unstyled">
                        <li className="text-muted">
                          <a
                            href={`mailto:${user.email}`}
                            className="text-info"
                          >
                            {user.email}
                          </a>
                        </li>
                        <li className="text-muted">{user.phone}</li>
                        <li className="text-muted">
                          {new Date(user.birthday).toLocaleDateString()}
                        </li>
                      </ul>
                    </div>
                  </address>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

export default Users;

Users.propTypes = {
  users: PropTypes.array,
  projects: PropTypes.array,
  usersPath: PropTypes.string
};
