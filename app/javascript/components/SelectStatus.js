import React from "react";
import PropTypes from "prop-types";

const SelectStatus = props => {
  const {handleChange} = props;
  const statuses = [
    {value: "scheduled", label: "scheduled", id: "0"},
    {value: "done", label: "done", id: "1"},
    {value: "canceled", label: "canceled", id: "2"}
   ];

  return(
    <select
    onChange={e => handleChange(e.target.value)}
    className="form-control select">
      {statuses.map(status => (
        <option key={status.id} value={status.id}>
          {status.value}
        </option>
      ))}
    </select>
  );
};

export default SelectStatus;

SelectStatus.propTypes = {
  handleChange: PropTypes.func,
  statuses: PropTypes.array
};
