import * as S from "effect/Schema";


export class Schema extends S.Class<Schema>("Schema")({
    "$ref": S.String,
}) {}

export class The200 extends S.Class<The200>("The200")({
    "description": S.String,
    "schema": Schema,
}) {}

export class Responses extends S.Class<Responses>("Responses")({
    "200": The200,
}) {}

export class Parameter extends S.Class<Parameter>("Parameter")({
    "description": S.String,
    "format": S.String,
    "in": S.String,
    "name": S.String,
    "required": S.Boolean,
    "type": S.String,
}) {}

export class Get extends S.Class<Get>("Get")({
    "description": S.String,
    "parameters": S.Array(Parameter),
    "responses": Responses,
    "summary": S.String,
    "tags": S.Array(S.String),
}) {}

export class ItaTaxonomiesSearch extends S.Class<ItaTaxonomiesSearch>("ItaTaxonomiesSearch")({
    "get": Get,
}) {}

export class Paths extends S.Class<Paths>("Paths")({
    "/ita_taxonomies/search": ItaTaxonomiesSearch,
}) {}

export class Info extends S.Class<Info>("Info")({
    "description": S.String,
    "title": S.String,
    "version": S.String,
}) {}

export class Annotations extends S.Class<Annotations>("Annotations")({
    "description": S.String,
    "type": S.String,
}) {}

export class Properties extends S.Class<Properties>("Properties")({
    "annotations": Annotations,
    "datatype_properties": Annotations,
    "id": Annotations,
    "label": Annotations,
    "sub_class_of": Annotations,
    "type": Annotations,
}) {}

export class Taxonomy extends S.Class<Taxonomy>("Taxonomy")({
    "properties": Properties,
}) {}

export class Definitions extends S.Class<Definitions>("Definitions")({
    "Taxonomy": Taxonomy,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "basePath": S.String,
    "definitions": Definitions,
    "host": S.String,
    "info": Info,
    "paths": Paths,
    "produces": S.Array(S.String),
    "schemes": S.Array(S.String),
    "swagger": S.String,
}) {}
