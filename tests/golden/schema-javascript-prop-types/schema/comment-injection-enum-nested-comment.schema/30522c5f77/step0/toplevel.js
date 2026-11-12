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
const _Kind = PropTypes.oneOf(['ok']);
_TopLevel = PropTypes.shape({
    "kind": _Kind,
});

export const TopLevel = _TopLevel;
