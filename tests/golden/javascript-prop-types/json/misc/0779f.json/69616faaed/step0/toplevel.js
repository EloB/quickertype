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
let _Status;
let _Weather;
let _Meta;
_Status = PropTypes.shape({
    "avgDelay": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "closureBegin": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "closureEnd": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "endTime": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "maxDelay": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "minDelay": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "reason": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "trend": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Meta = PropTypes.shape({
    "credit": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "updated": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Weather = PropTypes.shape({
    "meta": _Meta,
    "temp": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "visibility": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "weather": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "wind": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "IATA": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "ICAO": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "city": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "delay": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "state": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": _Status,
    "weather": _Weather,
});

export const TopLevel = _TopLevel;
