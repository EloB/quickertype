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
let _Country;
_Country = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "countries": PropTypes.oneOfType([PropTypes.arrayOf(_Country)]).isRequired,
});

export const TopLevel = _TopLevel;
