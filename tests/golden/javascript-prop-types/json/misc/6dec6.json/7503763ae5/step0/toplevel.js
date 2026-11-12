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
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _Query;
let _Results;
let _Channel;
let _Astronomy;
let _Atmosphere;
let _Image;
let _Item;
let _Condition;
let _Forecast;
let _GUID;
let _Location;
let _Units;
let _Wind;
const _Text = PropTypes.oneOf(['Showers', 'Mostly Sunny', 'Partly Cloudy']);
_Astronomy = PropTypes.shape({
    "sunrise": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "sunset": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Atmosphere = PropTypes.shape({
    "humidity": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pressure": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "rising": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "visibility": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Image = PropTypes.shape({
    "height": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "link": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Condition = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "temp": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "text": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Forecast = PropTypes.shape({
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "date": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "day": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "high": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "low": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "text": _Text,
});
_GUID = PropTypes.shape({
    "isPermaLink": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Item = PropTypes.shape({
    "condition": _Condition,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "forecast": PropTypes.oneOfType([PropTypes.arrayOf(_Forecast)]).isRequired,
    "guid": _GUID,
    "lat": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "link": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "long": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pubDate": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Location = PropTypes.shape({
    "city": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "country": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "region": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Units = PropTypes.shape({
    "distance": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pressure": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "speed": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "temperature": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Wind = PropTypes.shape({
    "chill": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "direction": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "speed": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Channel = PropTypes.shape({
    "astronomy": _Astronomy,
    "atmosphere": _Atmosphere,
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "image": _Image,
    "item": _Item,
    "language": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "lastBuildDate": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "link": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "location": _Location,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "ttl": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "units": _Units,
    "wind": _Wind,
});
_Results = PropTypes.shape({
    "channel": _Channel,
});
_Query = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "created": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "lang": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "results": _Results,
});
_TopLevel = PropTypes.shape({
    "query": _Query,
});

export const TopLevel = _TopLevel;
