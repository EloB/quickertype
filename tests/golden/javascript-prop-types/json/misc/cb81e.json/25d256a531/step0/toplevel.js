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

let _TopLevel;
let _Description;
_Description = PropTypes.shape({
    "base_period": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "missing": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "units": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.objectOf(PropTypes.string)]).isRequired,
    "description": _Description,
});

export const TopLevel = _TopLevel;
