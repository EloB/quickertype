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
const _Booster = PropTypes.oneOf(['rare', 'uncommon', 'common']);
const _ColorIdentity = PropTypes.oneOf(['U', 'B', 'W', 'G', 'R']);
const _Color = PropTypes.oneOf(['Blue', 'Black', 'White', 'Green', 'Red']);
const _Layout = PropTypes.oneOf(['normal']);
const _Format = PropTypes.oneOf(['Commander', 'Legacy', 'Modern', 'Vintage', 'Time Spiral Block', 'Ravnica Block', 'Ice Age Block', 'Tempest Block', 'Onslaught Block', 'Masques Block', 'Mirage Block', 'Urza Block', 'Scars of Mirrodin Block', 'Mirrodin Block', 'Amonkhet Block', 'Battle for Zendikar Block', 'Innistrad Block', 'Invasion Block', 'Kaladesh Block', 'Kamigawa Block', 'Khans of Tarkir Block', 'Lorwyn-Shadowmoor Block', 'Odyssey Block', 'Return to Ravnica Block', 'Shadows over Innistrad Block', 'Shards of Alara Block', 'Standard', 'Theros Block', 'Un-Sets', 'Zendikar Block']);
const _LegalityEnum = PropTypes.oneOf(['Legal', 'Banned', 'Restricted']);
const _Rarity = PropTypes.oneOf(['Uncommon', 'Rare', 'Common', 'Basic Land']);
const _Supertype = PropTypes.oneOf(['Basic']);
const _Type = PropTypes.oneOf(['Creature', 'Instant', 'Enchantment', 'Artifact', 'Sorcery', 'Land']);
_LegalityElement = PropTypes.shape({
    "format": _Format,
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
    "colors": PropTypes.oneOfType([PropTypes.arrayOf(_Color), PropTypes.oneOf([null])]),
    "flavor": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "imageName": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "layout": _Layout,
    "legalities": PropTypes.oneOfType([PropTypes.arrayOf(_LegalityElement)]).isRequired,
    "manaCost": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "mciNumber": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "multiverseid": PropTypes.oneOfType([Integer]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "originalText": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "originalType": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "power": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "printings": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
    "rarity": _Rarity,
    "reserved": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "rulings": PropTypes.oneOfType([PropTypes.arrayOf(_Ruling), PropTypes.oneOf([null])]),
    "subtypes": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string), PropTypes.oneOf([null])]),
    "supertypes": PropTypes.oneOfType([PropTypes.arrayOf(_Supertype), PropTypes.oneOf([null])]),
    "text": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "toughness": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "types": PropTypes.oneOfType([PropTypes.arrayOf(_Type)]).isRequired,
    "variations": PropTypes.oneOfType([PropTypes.arrayOf(Integer), PropTypes.oneOf([null])]),
});
_TopLevel = PropTypes.shape({
    "booster": PropTypes.oneOfType([PropTypes.arrayOf(_Booster)]).isRequired,
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
