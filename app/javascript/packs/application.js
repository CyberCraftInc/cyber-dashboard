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

/// React components
const components = {};
const context = require.context("../components", false, /\.js$/);

for (const key of context.keys()) {
  const componentName = key.match(/([^/.]+)\.js/)[1];
  components[componentName] = context(key).default;
}
/// React components end

require("../../assets/javascripts/mask");
require("imask");

Vue.prototype.$axios = axios;

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "[data-behavior=\"vue\"]",
    components: {
      "users-component": UsersList,
      "users-edit-component": UserEdit,
      "header-dropdown": HeaderDropdown,
      "user-info-component": UserInfo,
      "user-events-component": UserEvents
    }
  });

  if (document.querySelector("meta[name=\"csrf-token\"]")) {
    axios.defaults.headers.common = {
      "X-CSRF-Token": document
        .querySelector("meta[name=\"csrf-token\"]")
        .getAttribute("content"),
      Accept: "application/json"
    };
  } else {
    axios.defaults.headers.common["Accept"] = "application/json";
  }

  // Mounting elements by selector

  const mountingElements = document.querySelectorAll("[data-react-component]");
  for (const element of mountingElements) {
    const { name, props } = JSON.parse(
      element.getAttribute("data-react-component")
    );
    const component = components[name];
    if (!component) {
      console.log(`Component ${name} not found`);
      continue
    }
    ReactDOM.render(React.createElement(component, props || {}), element);
  }
});
