import React from "react";
import PropTypes from "prop-types";

const SelectProject = props => {
  const { handleChange, options, placeholder } = props;

  return (
    <select
      onChange={e => handleChange(e.target.value)}
      className="form-control select"
    >
      {placeholder && <option value={0}>{placeholder}</option>}
      {options.map(project => (
        <option key={project.id} value={project.id}>
          {project.name}
        </option>
      ))}
    </select>
  );
};

export default SelectProject;

SelectProject.propTypes = {
  handleChange: PropTypes.func,
  options: PropTypes.array,
  placeholder: PropTypes.string
};