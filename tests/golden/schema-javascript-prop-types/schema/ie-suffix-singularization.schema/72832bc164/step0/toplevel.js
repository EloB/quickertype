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
let _Cookie;
_Cookie = PropTypes.shape({
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "value": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "cookies": PropTypes.oneOfType([PropTypes.arrayOf(_Cookie)]).isRequired,
});

export const TopLevel = _TopLevel;
