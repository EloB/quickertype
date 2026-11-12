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
let _UnionListClass;
_UnionListClass = PropTypes.shape({
    "next": PropTypes.oneOfType([PropTypes.oneOfType([_UnionListClass, PropTypes.number])]).isRequired,
});
_TopLevel = PropTypes.shape({
    "list": PropTypes.oneOfType([PropTypes.oneOfType([_UnionListClass, PropTypes.number])]).isRequired,
});

export const TopLevel = _TopLevel;
