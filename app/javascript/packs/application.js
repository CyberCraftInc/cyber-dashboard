import Vue from "vue";
import * as instances from "../instances";

import axios from "axios";
import "bootstrap";
/// React import
import * as React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
/// React import end

window.moment = require("moment");

/// React components
const components = {};

const context = require.context("../components/", true, /\.js$/);
for (const key of context.keys()) {
  const componentName = key.match(/([^/.]+)\.js/)[1];
  components[componentName] = context(key).default;
}
/// React components end

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
});
