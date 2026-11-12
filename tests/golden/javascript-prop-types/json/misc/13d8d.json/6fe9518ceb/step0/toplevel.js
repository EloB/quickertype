// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Location;
let _Street;
let _OutcomeStatus;
_Street = PropTypes.shape({
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Location = PropTypes.shape({
    "latitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "longitude": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "street": _Street,
});
_OutcomeStatus = PropTypes.shape({
    "category": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "category": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "context": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "location": _Location,
    "location_subtype": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "location_type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "month": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "outcome_status": _OutcomeStatus,
    "persistent_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
