import React from "react";
import moment from "moment";
import axios from "axios";
import PropTypes from "prop-types";

class UserEvents extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      events: {},
      targets: new Map()
    };
  }

  changeTargetAchieved(target) {
    const isChecked = target.checked;

    axios
      .put(target.toggle_achieved_path, {
        params: {
          id: target.id
        }
      })
      .then(() =>
        this.setState(prevState => ({
          targets: prevState.targets.set(target.id, isChecked)
        }))
      )
      .catch(() => (this.axiosFlashNotice = "Failed change checkbox "));
  }

  showButtonForCanEditEvent() {
    return this.$parent.showButtonForCanEditEvent();
  }

  isFieldNotEmpty(field) {
    return !(field === null || field === "");
  }

  dateYear(index) {
    let date = this.props.events[index].finish_date;
    return moment(date).format("ll");
  }

  addTagDelToEventDescription(eventStatus) {
    return ["canceled"].includes(eventStatus);
  }

  getMonthAndDate(date) {
    return new Date(date)
      .toLocaleDateString("en-US", { month: "short", day: "numeric" })
      .toLocaleLowerCase();
  }

  getYearMonthAndDate(date) {
    return new Date(date).toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric"
    });
  }

  changeActiveEvent(eventId) {
    document
      .getElementById("event" + eventId)
      .classList.toggle("display-block");
    document
      .getElementById("open-event" + eventId)
      .classList.toggle("fa-angle-up");
  }

  openedEventData(eventId) {
    return document
      .getElementById("event" + eventId)
      .classList.contains("display-block");
  }

  onClickButton(event) {
    this.$emit("eventProps", event);
  }

  toggleEvent(index) {
    const val = this.state.events[index];
    this.setState({
      events: {
        [index]: !val
      }
    });
  }

  eventList(events) {
    let children = [];

    for (const [index, event] of events.entries()) {
      let className = "cont left " + event.status;
      let statusIcon = "";
      switch (event.status) {
        case "canceled":
          statusIcon += "fa fa-ban";
          break;
        case "scheduled":
          statusIcon += "fas fa-clock";
          break;
        case "done":
          statusIcon += "fas fa-check-circle";
          break;
      }

      children.push(
        <div className="row pt-1" key={event.id}>
          <div className={className}>
            <div className="pt-2">
              <h6>{this.dateYear(index)}</h6>
            </div>
            <i className={statusIcon}></i>
          </div>
          <div className="cont right">
            <div className="col-12 pl-0 ml-4">
              <div className="d-flex flex-wrap">
                {this.state.events[index] !== true && (
                  <div className="triangle"></div>
                )}
                <div
                  onClick={this.toggleEvent.bind(this, index)}
                  className="col-12 py-1 d-flex align-items-center flex-row pl-2 event-visible-item"
                >
                  <div className="col-11 py-1">
                    <div className="row">
                      <div className="px-3">
                        <span>{event.description}</span>
                      </div>
                      <div data-toggle="modal" data-target="#popUpModal">
                        <i className="fas fa-edit edit-event-icon"></i>
                      </div>
                    </div>
                  </div>
                  <div className="col-1 angle-up-down">
                    <i className="fas fa-angle-down fa-2x"></i>
                  </div>
                </div>
              </div>
              {this.state.events[index] === true && (
                <div className="event-full-data-item px-3 pt-1 pad-bot12 mt-0 border border-top-0 border-width-2">
                  <div className="py-3">
                    <div className="row">
                      <div className="col-8 br">
                        <h6 className="mb-1">
                          <b>COMMENTS</b>
                        </h6>
                        <div className="mb-3">{event.comments}</div>
                        <h6 className="mb-1">
                          <b>SUMMARY</b>
                        </h6>
                        <div className="mb-3">{event.summary}</div>
                        <h6 className="mb-1">
                          <b>TARGETS</b>
                        </h6>
                        <div className="round">
                          {this.targetList(event.targets)}
                        </div>
                      </div>
                      <div className="col-3 ml-4">
                        <div className="row">
                          <div className="dates ml-3">
                            <ul className="list-unstyled">
                              <li>
                                <i className="fas fa-calendar"></i>
                                Start Date:
                              </li>
                              <li>
                                <i className="fas fa-calendar"></i>
                                End Date:
                              </li>
                            </ul>
                          </div>
                          <div>
                            <ul className="list-unstyled">
                              <li className="text-muted">
                                {this.getYearMonthAndDate(event.start_date)}
                              </li>
                              <li className="text-muted">
                                {this.getYearMonthAndDate(event.finish_date)}
                              </li>
                            </ul>
                          </div>
                        </div>
                        <div className={"status-badge " + event.status}>
                          <i className={statusIcon}></i>
                          {event.status}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      );
    }

    return children;
  }

  targetList(targets) {
    let children = [];

    targets.forEach(target => {
      children.push(
        <div key={target.id}>
          <div className="d-inline">
            <input
              className="pt-1 checkbox"
              id={"target" + target.id}
              type="checkbox"
              defaultChecked={target.achieved}
              checked={this.state.targets.get(target.id)}
              onChange={this.changeTargetAchieved.bind(this, target)}
              disabled={!this.props.canEditEvent}
            />
          </div>
          <label className="ml-2 d-inline" htmlFor={"target" + target.id}>
            {target.description}
          </label>

          <div className="row pt-1">{target.name}</div>
        </div>
      );
    });

    return children;
  }

  render() {
    const { events, noImage } = this.props;

    if (events.length === 0) {
      return (
        <div className="user-events pt-3 no-events">
          <h2>There are no available events</h2>
          <img src={noImage} />
        </div>
      );
    } else {
      return (
        <div className="user-events pt-3">
          <div className="mt-2"/>
          <h4>
            <b>Events Timeline</b>
          </h4>
          <div className="row">
            <div className="timeline mt-3 mx-5">{this.eventList(events)}</div>
          </div>
        </div>
      );
    }
  }
}

UserEvents.propTypes = {
  events: PropTypes.array,
  noImage: PropTypes.string,
  canEditEvent: PropTypes.bool
};

export default UserEvents;
