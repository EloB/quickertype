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
let _Headers;
_Headers = PropTypes.shape({
    "Accept-Encoding": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Connection": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Host": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "User-Agent": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "headers": _Headers,
});

export const TopLevel = _TopLevel;
