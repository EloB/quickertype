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
_TopLevel = PropTypes.shape({
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "stop-and-search": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
