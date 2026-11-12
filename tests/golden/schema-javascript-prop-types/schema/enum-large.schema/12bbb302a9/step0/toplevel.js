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
const _Callsign = PropTypes.oneOf(['alpha', 'bravo', 'charlie', 'delta', 'echo', 'foxtrot', 'golf', 'hotel', 'india', 'juliett', 'kilo', 'lima', 'mike', 'november', 'oscar', 'papa', 'quebec', 'romeo', 'sierra', 'tango']);
const _Priority = PropTypes.oneOf(['low', 'medium', 'high']);
_TopLevel = PropTypes.shape({
    "callsign": _Callsign,
    "priority": _Priority,
});

export const TopLevel = _TopLevel;
