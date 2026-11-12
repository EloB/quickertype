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
let _Article;
let _Property;
let _DeMinimis;
let _DeMinimisProperties;
let _FAQ;
let _FAQProperties;
let _Report;
let _ReportProperties;
let _Taxonomy;
let _TaxonomyProperties;
let _Info;
let _Paths;
let _BusinessServiceProvidersSearchClass;
let _BusinessServiceProvidersSearchGet;
let _Parameter;
let _PurpleResponses;
let _Purple200;
let _ItemsClass;
let _ConsolidatedScreeningListSearchClass;
let _ConsolidatedScreeningListSearchGet;
let _FluffyResponses;
let _Fluffy200;
let _PurpleSchema;
const _FormatEnum = PropTypes.oneOf(['string']);
const _In = PropTypes.oneOf(['query']);
const _SchemaType = PropTypes.oneOf(['array']);
_Property = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _FormatEnum,
});
_Article = PropTypes.shape({
    "properties": PropTypes.oneOfType([PropTypes.objectOf(_Property)]).isRequired,
});
_DeMinimisProperties = PropTypes.shape({
    "countries": _Property,
    "country": _Property,
    "de_minimis_currency": _Property,
    "de_minimis_value": _Property,
    "notes": _Property,
    "vat_amount": _Property,
    "vat_currency": _Property,
});
_DeMinimis = PropTypes.shape({
    "properties": _DeMinimisProperties,
});
_FAQProperties = PropTypes.shape({
    "answer": _Property,
    "countries": _Property,
    "first_published_date": _Property,
    "id": _Property,
    "industries": _Property,
    "last_published_date": _Property,
    "question": _Property,
    "topics": _Property,
    "trade_regions": _Property,
    "url": _Property,
    "world_regions": _Property,
});
_FAQ = PropTypes.shape({
    "properties": _FAQProperties,
});
_ReportProperties = PropTypes.shape({
    "countries": _Property,
    "description": _Property,
    "expiration_date": _Property,
    "id": _Property,
    "industries": _Property,
    "ita_industries": _Property,
    "report_type": _Property,
    "title": _Property,
    "url": _Property,
});
_Report = PropTypes.shape({
    "properties": _ReportProperties,
});
_TaxonomyProperties = PropTypes.shape({
    "annotations": _Property,
    "datatype_properties": _Property,
    "id": _Property,
    "label": _Property,
    "sub_class_of": _Property,
    "type": _Property,
});
_Taxonomy = PropTypes.shape({
    "properties": _TaxonomyProperties,
});
_Definitions = PropTypes.shape({
    "Article": _Article,
    "Center": _Article,
    "DeMinimis": _DeMinimis,
    "Event": _Article,
    "FAQ": _FAQ,
    "Lead": _Article,
    "List": _Article,
    "MarketIntelligence": _Article,
    "Office": _Article,
    "Provider": _Article,
    "Rate": _Article,
    "Report": _Report,
    "Taxonomy": _Taxonomy,
});
_Info = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Parameter = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "format": _FormatEnum,
    "in": _In,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "required": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "type": _FormatEnum,
});
_ItemsClass = PropTypes.shape({
    "$ref": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Purple200 = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "schema": _ItemsClass,
});
_PurpleResponses = PropTypes.shape({
    "200": _Purple200,
});
_BusinessServiceProvidersSearchGet = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_Parameter)]).isRequired,
    "responses": _PurpleResponses,
    "summary": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
});
_BusinessServiceProvidersSearchClass = PropTypes.shape({
    "get": _BusinessServiceProvidersSearchGet,
});
_PurpleSchema = PropTypes.shape({
    "items": _ItemsClass,
    "type": _SchemaType,
});
_Fluffy200 = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "schema": _PurpleSchema,
});
_FluffyResponses = PropTypes.shape({
    "200": _Fluffy200,
});
_ConsolidatedScreeningListSearchGet = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "parameters": PropTypes.oneOfType([PropTypes.arrayOf(_Parameter)]).isRequired,
    "responses": _FluffyResponses,
    "summary": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "tags": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.string)]).isRequired,
});
_ConsolidatedScreeningListSearchClass = PropTypes.shape({
    "get": _ConsolidatedScreeningListSearchGet,
});
_Paths = PropTypes.shape({
    "/business_service_providers/search": _BusinessServiceProvidersSearchClass,
    "/consolidated_screening_list/search": _ConsolidatedScreeningListSearchClass,
    "/de_minimis/search": _ConsolidatedScreeningListSearchClass,
    "/ita_faqs/search": _ConsolidatedScreeningListSearchClass,
    "/ita_office_locations/search": _ConsolidatedScreeningListSearchClass,
    "/ita_taxonomies/search": _BusinessServiceProvidersSearchClass,
    "/ita_zipcode_to_post/search": _BusinessServiceProvidersSearchClass,
    "/market_intelligence/search": _ConsolidatedScreeningListSearchClass,
    "/market_research_library/search": _ConsolidatedScreeningListSearchClass,
    "/tariff_rates/search": _ConsolidatedScreeningListSearchClass,
    "/trade_articles/search": _ConsolidatedScreeningListSearchClass,
    "/trade_events/search": _ConsolidatedScreeningListSearchClass,
    "/trade_leads/search": _ConsolidatedScreeningListSearchClass,
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
