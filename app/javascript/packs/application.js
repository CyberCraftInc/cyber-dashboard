import Vue from "vue/dist/vue.esm";
import UsersList from "../components/users/UsersList.vue";
import UserEdit from "../components/users/edit/UserEdit.vue";
import HeaderDropdown from "../components/header/HeaderDropdown.vue";
import UserInfo from "../components/users/UserInfo.vue";
import UserEvents from "../components/users/UserEvents";
import axios from "axios";
import "bootstrap";
/// React import
import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import App from "../components/App";
/// React import end

window.moment = require("moment");

/// React component
const Hello = props => <div>Hello {props.name}!</div>;
Hello.defaultProps = {
  name: "David"
};

Hello.propTypes = {
  name: PropTypes.string
};
/// React component end

require("../../assets/javascripts/mask");
require("imask");

Vue.prototype.$axios = axios;


window.addEventListener("load", () => {
  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: {
      "users-component": UsersList,
      "users-edit-component": UserEdit,
      "header-dropdown": HeaderDropdown,
      "user-info-component": UserInfo,
      "user-events-component": UserEvents
    }
  });

  if (document.querySelector('meta[name="csrf-token"]')) {
    axios.defaults.headers.common = {
      "X-CSRF-Token": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
      Accept: "application/json"
    };
  } else {
    axios.defaults.headers.common["Accept"] = "application/json";
  }

  // React.js
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement("div"))
  );
});
