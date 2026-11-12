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
let _Category;
let _LinkElement;
let _LinkLink;
let _CategoryThumbnail;
let _Details;
let _Date;
let _Eonandyear;
let _Xmlschematype;
let _ProductElement;
let _ProductProduct;
let _Currency;
let _Rating;
let _Useraveragerating;
let _Specification;
let _Format;
let _FormatsClass;
_LinkLink = PropTypes.shape({
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_LinkElement = PropTypes.shape({
    "link": _LinkLink,
});
_CategoryThumbnail = PropTypes.shape({
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Category = PropTypes.shape({
    "concatenatecategoryname": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hasoffer": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "isfinal": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_LinkElement)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parentcategoryid": PropTypes.oneOfType([Integer]).isRequired,
    "thumbnail": _CategoryThumbnail,
});
_Eonandyear = PropTypes.shape({
    "lowestsetbit": PropTypes.oneOfType([Integer]).isRequired,
});
_Xmlschematype = PropTypes.shape({
    "localpart": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "namespaceuri": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "prefix": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Date = PropTypes.shape({
    "day": PropTypes.oneOfType([Integer]).isRequired,
    "eonandyear": _Eonandyear,
    "hour": PropTypes.oneOfType([Integer]).isRequired,
    "millisecond": PropTypes.oneOfType([Integer]).isRequired,
    "minute": PropTypes.oneOfType([Integer]).isRequired,
    "month": PropTypes.oneOfType([Integer]).isRequired,
    "second": PropTypes.oneOfType([Integer]).isRequired,
    "timezone": PropTypes.oneOfType([Integer]).isRequired,
    "valid": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "xmlschematype": _Xmlschematype,
    "year": PropTypes.oneOfType([Integer]).isRequired,
});
_Details = PropTypes.shape({
    "applicationid": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "applicationversion": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "code": PropTypes.oneOfType([Integer]).isRequired,
    "date": _Date,
    "elapsedtime": PropTypes.oneOfType([Integer]).isRequired,
    "message": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Currency = PropTypes.shape({
    "abbreviation": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Useraveragerating = PropTypes.shape({
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_LinkElement)]).isRequired,
    "numcomments": PropTypes.oneOfType([Integer]).isRequired,
    "rating": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Rating = PropTypes.shape({
    "useraveragerating": _Useraveragerating,
});
_Specification = PropTypes.shape({
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_LinkElement)]).isRequired,
});
_ProductProduct = PropTypes.shape({
    "categoryid": PropTypes.oneOfType([Integer]).isRequired,
    "currency": _Currency,
    "eco": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "fulldescription": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hasmetasearch": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([Integer]).isRequired,
    "links": PropTypes.oneOfType([PropTypes.arrayOf(_LinkElement)]).isRequired,
    "numoffers": PropTypes.oneOfType([Integer]).isRequired,
    "pricemax": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "pricemin": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "productname": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "quantity": PropTypes.oneOfType([Integer]).isRequired,
    "rating": _Rating,
    "specification": _Specification,
    "thumbnail": (...args) => _FormatsClass(...args),
    "totalsellers": PropTypes.oneOfType([Integer]).isRequired,
});
_ProductElement = PropTypes.shape({
    "product": _ProductProduct,
});
_TopLevel = PropTypes.shape({
    "category": _Category,
    "details": _Details,
    "match": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "page": PropTypes.oneOfType([Integer]).isRequired,
    "product": PropTypes.oneOfType([PropTypes.arrayOf(_ProductElement)]).isRequired,
    "schk": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "totallooseoffers": PropTypes.oneOfType([Integer]).isRequired,
    "totalpages": PropTypes.oneOfType([Integer]).isRequired,
    "totalresultsavailable": PropTypes.oneOfType([Integer]).isRequired,
    "totalresultsreturned": PropTypes.oneOfType([Integer]).isRequired,
});
_Format = PropTypes.shape({
    "formats": (...args) => _FormatsClass(...args),
});
_FormatsClass = PropTypes.shape({
    "formats": PropTypes.oneOfType([PropTypes.arrayOf(_Format), PropTypes.oneOf([null])]),
    "height": PropTypes.oneOfType([Integer]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([Integer]).isRequired,
});

export const TopLevel = _TopLevel;
