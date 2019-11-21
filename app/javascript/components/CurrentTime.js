import { Component } from "react";

class CurrentTime extends Component {
  constructor() {
    super();

    this.state = {
      time: new Date().toLocaleString()
    };
  }

  componentDidMount() {
    this.intervalID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.intervalID);
  }

  tick() {
    this.setState({
      time: new Date().toLocaleString()
    });
  }

  render() {
    return this.state.time;
  }
}

export default CurrentTime;
