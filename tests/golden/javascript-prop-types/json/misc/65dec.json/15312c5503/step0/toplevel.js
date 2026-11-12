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
let _Card;
let _LegalityElement;
let _Ruling;
const _ColorIdentity = PropTypes.oneOf(['W', 'R', 'B', 'G', 'U']);
const _Watermark = PropTypes.oneOf(['White', 'Red', 'Black', 'Green', 'Blue']);
const _Layout = PropTypes.oneOf(['normal']);
const _LegalityEnum = PropTypes.oneOf(['Legal', 'Banned', 'Restricted']);
const _Rarity = PropTypes.oneOf(['Uncommon', 'Rare', 'Common', 'Basic Land']);
const _Type = PropTypes.oneOf(['Creature', 'Artifact', 'Instant', 'Land', 'Enchantment', 'Sorcery']);
_LegalityElement = PropTypes.shape({
    "format": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "legality": _LegalityEnum,
});
_Ruling = PropTypes.shape({
    "date": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "text": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Card = PropTypes.shape({
    "artist": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "cmc": PropTypes.oneOfType([Integer]).isRequired,
    "colorIdentity": PropTypes.oneOfType([PropTypes.arrayOf(_ColorIdentity), PropTypes.oneOf([null])]),
    "colors": PropTypes.oneOfType([PropTypes.arrayOf(_Watermark), PropTypes.oneOf([null])]),
    "flavor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "imageName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "layout": _Layout,
    "legalities": PropTypes.oneOfType([PropTypes.arrayOf(_LegalityElement)]).isRequired,
    "manaCost": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "mciNumber": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "multiverseid": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "originalText": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "originalType": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "power": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "printings": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "rarity": _Rarity,
    "reserved": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "rulings": PropTypes.oneOfType([PropTypes.arrayOf(_Ruling), PropTypes.oneOf([null])]),
    "subtypes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "supertypes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "toughness": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "types": PropTypes.oneOfType([PropTypes.arrayOf(_Type)]).isRequired,
    "variations": PropTypes.oneOfType([PropTypes.arrayOf(Integer), PropTypes.oneOf([null])]),
    "watermark": PropTypes.oneOfType([_Watermark, PropTypes.oneOf([null])]),
});
_TopLevel = PropTypes.shape({
    "booster": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "border": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "cards": PropTypes.oneOfType([PropTypes.arrayOf(_Card)]).isRequired,
    "code": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "gathererCode": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "magicCardsInfoCode": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mkm_id": PropTypes.oneOfType([Integer]).isRequired,
    "mkm_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "releaseDate": PropTypes.oneOfType([(props, name) => props[name] == null || typeof props[name] === "string" && !Number.isNaN(Date.parse(props[name])) ? null : new Error("Expected date-time")]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
