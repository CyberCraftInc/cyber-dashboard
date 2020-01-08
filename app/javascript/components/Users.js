import React, { Component } from "react";
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
      usersList: [],
      projects: [],
      usersPath: "/users"
    };
  }

  componentDidMount() {
    this.selectProject(this.state.usersPath);

    axios
      .get(this.state.usersPath, {
        params: {
          id: 0
        }
      })
      .then(response => {
        this.setState({
          usersList: response.data.users,
          projects: JSON.parse(response.data.projects),
          filteredUsers: response.data.users
        });
      })
      .catch(error => console.log(error.response.data));
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
          usersList: this.state.usersList
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
          usersList: response.data.users,
          filteredUsers: response.data.users
        });
      })
      .catch(error => console.log(error.response.data));
  };

  sortButtons = buttons => {
    return buttons.map((type, index) => (
      <button
        key={index}
        type="button"
        onClick={e => {
          this.addActiveClass(e.target);
          this.sortBy(type);
        }}
        className={"btn btn-outline-dark m-0 mb-2 mr-2"}
      >
        {type}
      </button>
    ));
  };

  checkBirthday = birthday =>
    new Date(birthday).toLocaleDateString().slice(0, 5) ==
      new Date().toLocaleDateString().slice(0, 5) && "🎂 ";

  render() {
    const { projects, usersPath, filteredUsers, usersList } = this.state;

    return (
      <div className="mt-3">
        <div className="d-flex flex-wrap justify-content-between align-items-center">
          <div className="col-sm-12 col-md-3 mb-1 mb-md-0">
            <form id="search">
              <input
                type="text"
                className="form-control"
                placeholder="Search"
                onChange={e => {
                  this.setState({
                    usersList: this.filteredList(e.target.value, filteredUsers)
                  });
                }}
                aria-label="Search users"
                id="query"
              />
            </form>
          </div>

          <div className="col-sm-12 col-md-3 mb-1 d-flex justify-content-center">
            <CurrentTime />
          </div>

          <div className="col-sm-12 col-md-3 p-sm-0">
            <SelectProject
              options={projects}
              handleChange={value => this.selectProject(usersPath, value)}
              placeholder="All employees"
            />
          </div>
        </div>
        <div className="d-flex flex-wrap justify-content-between mt-4">
          <div className="pl-4">
            {this.sortButtons(["position", "birthday", "days in company"])}
          </div>
          <span>
            Number of employees <strong>{usersList.length}</strong>
          </span>
        </div>

        <div
          className="d-flex bd-highlight users"
          style={{ height: "65vh", overflowY: "scroll" }}
        >
          <div className="d-flex flex-wrap justify-content-center justify-content-md-start">
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
                  className="card-body d-flex align-items-center flex-column btn-outline-dark"
                  style={{ cursor: "pointer" }}
                >
                  <div
                    className="mb-2 img-thumbnail"
                    style={{
                      borderRadius: "50%",
                      width: "120px",
                      height: "120px",
                      overflow: "hidden",
                      backgroundImage: `url(
                        ${
                          user.avatar && user.avatar != "null"
                            ? user.avatar
                            : profileImage
                        }
                      )`,
                      backgroundSize: "cover"
                    }}
                  ></div>
                  <h5 className="card-title">
                    <strong>{this.checkBirthday(user.birthday)}</strong>
                    <strong>{user.first_name + " " + user.last_name}</strong>
                  </h5>
                  <h6 className="d-flex flex-wrap card-subtitle mb-2 justify-content-center">
                    <span className="text-center">{user.position}</span>
                  </h6>

                  <address className="d-flex flex-column align-items-center">
                    <a href={`mailto:${user.email}`} className="text-info">
                      {user.email}
                    </a>
                    <h6>{new Date(user.birthday).toLocaleDateString()}</h6>
                    <h6>{user.phone}</h6>
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
