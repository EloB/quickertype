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
let _Definitions;
let _Report;
let _Properties;
let _ClickURL;
let _Info;
let _Paths;
let _MarketResearchLibrarySearch;
let _Get;
let _Parameter;
let _Responses;
let _The200;
let _Schema;
let _Items;
const _Type = PropTypes.oneOf(['string']);
_ClickURL = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _Type,
});
_Properties = PropTypes.shape({
    "click_url": _ClickURL,
    "country": _ClickURL,
    "description": _ClickURL,
    "expiration_date": _ClickURL,
    "id": _ClickURL,
    "industry": _ClickURL,
    "report_type": _ClickURL,
    "source_industry": _ClickURL,
    "title": _ClickURL,
    "url": _ClickURL,
});
_Report = PropTypes.shape({
    "properties": _Properties,
});
_Definitions = PropTypes.shape({
    "Report": _Report,
});
_Info = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Parameter = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "format": _Type,
    "in": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "required": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": _Type,
});
_Items = PropTypes.shape({
    "$ref": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Schema = PropTypes.shape({
    "items": _Items,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_The200 = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "schema": _Schema,
});
_Responses = PropTypes.shape({
    "200": _The200,
});
_Get = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_Parameter)]).isRequired,
    "responses": _Responses,
    "summary": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
});
_MarketResearchLibrarySearch = PropTypes.shape({
    "get": _Get,
});
_Paths = PropTypes.shape({
    "/market_research_library/search": _MarketResearchLibrarySearch,
});
_TopLevel = PropTypes.shape({
    "basePath": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "definitions": _Definitions,
    "host": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "info": _Info,
    "paths": _Paths,
    "produces": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "schemes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "swagger": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
