import Vue from "vue";
import * as instances from "../instances";

import axios from "axios";
import "bootstrap";
/// React import
import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import { BrowserRouter as Router, Route } from "react-router-dom";
import App from "../components/App";
/// end React import

window.moment = require("moment");

/// React components
const components = {};

const context = require.context("../components/", true, /\.js$/);
for (const key of context.keys()) {
  const componentName = key.match(/([^/.]+)\.js/)[1];
  components[componentName] = context(key).default;
}
/// end React components

require("../../assets/javascripts/mask");
require("imask");

Vue.prototype.$axios = axios;

window.addEventListener("load", () => {
  Object.keys(instances).forEach(instanceName => {
    const instance = instances[instanceName];
    const elements = document.querySelectorAll(`.${instance.el}`);

    elements.forEach(element => {
      const props = JSON.parse(element.getAttribute("data-props"));

      new Vue({
        el: element,
        render: h => h(instance.component, { props })
      });
    });
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

  // Mounting elements by selector
  const mountingElements = document.querySelectorAll("[data-react-component]");

  for (const element of mountingElements) {
    const { name, props } = JSON.parse(
      element.getAttribute("data-react-component")
    );

    const component = components[name];
    if (!component) {
      console.log(`Component ${name} not found`);
      continue;
    }

    ReactDOM.render(React.createElement(component, props || {}), element);
  }
  /// end Mounting elements by selector

  const footer = document.getElementsByTagName("footer")[0];
  ReactDOM.render(
    <Router>
      <Route path="/" component={App} />
    </Router>,
    document.body.insertBefore(document.createElement("main"), footer)
  );
});
