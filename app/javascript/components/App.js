import React from "react";
import { Route, Switch } from "react-router-dom";

import Users from "./Users";
import EditUser from "./EditUser";

class App extends React.Component {
  render() {
    return (
      <div>
        <div className="container">
          <Switch>
            <Route exact path="/" component={Users} />
            <Route exact path="/edit" component={EditUser} />
          </Switch>
        </div>
      </div>
    );
  }
}

export default App;
