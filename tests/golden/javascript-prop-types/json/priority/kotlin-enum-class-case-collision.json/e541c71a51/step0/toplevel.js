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
const _Category = PropTypes.oneOf([' ', '']);
_TopLevel = PropTypes.shape({
    "category": _Category,
});

export const TopLevel = PropTypes.arrayOf(_TopLevel);
