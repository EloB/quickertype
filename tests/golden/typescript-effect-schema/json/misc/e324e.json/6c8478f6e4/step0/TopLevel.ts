import * as S from "effect/Schema";


export const Type = S.Literal(
    "string",
);
export type Type = S.Schema.Type<typeof Type>;

export class Items extends S.Class<Items>("Items")({
    "$ref": S.String,
}) {}

export class Schema extends S.Class<Schema>("Schema")({
    "items": Items,
    "type": S.String,
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
    "format": Type,
    "in": S.String,
    "name": S.String,
    "required": S.Boolean,
    "type": Type,
}) {}

export class Get extends S.Class<Get>("Get")({
    "description": S.String,
    "parameters": S.Array(Parameter),
    "responses": Responses,
    "summary": S.String,
    "tags": S.Array(S.String),
}) {}

export class TariffRatesSearch extends S.Class<TariffRatesSearch>("TariffRatesSearch")({
    "get": Get,
}) {}

export class Paths extends S.Class<Paths>("Paths")({
    "/tariff_rates/search": TariffRatesSearch,
}) {}

export class Info extends S.Class<Info>("Info")({
    "description": S.String,
    "title": S.String,
    "version": S.String,
}) {}

export class Property extends S.Class<Property>("Property")({
    "description": S.String,
    "type": Type,
}) {}

export class Rate extends S.Class<Rate>("Rate")({
    "properties": S.Record({ key: S.String, value: Property}),
}) {}

export class Definitions extends S.Class<Definitions>("Definitions")({
    "Rate": Rate,
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
