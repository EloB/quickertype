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
let _Args;
let _Headers;
_Args = PropTypes.shape({
});
_Headers = PropTypes.shape({
    "Accept-Encoding": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Connection": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "Host": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "User-Agent": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "args": _Args,
    "data": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "files": _Args,
    "form": _Args,
    "headers": _Headers,
    "origin": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
