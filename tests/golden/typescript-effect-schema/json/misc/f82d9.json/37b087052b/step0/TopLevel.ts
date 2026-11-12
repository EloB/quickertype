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

export class MarketResearchLibrarySearch extends S.Class<MarketResearchLibrarySearch>("MarketResearchLibrarySearch")({
    "get": Get,
}) {}

export class Paths extends S.Class<Paths>("Paths")({
    "/market_research_library/search": MarketResearchLibrarySearch,
}) {}

export class Info extends S.Class<Info>("Info")({
    "description": S.String,
    "title": S.String,
    "version": S.String,
}) {}

export class ClickUrl extends S.Class<ClickUrl>("ClickUrl")({
    "description": S.String,
    "type": Type,
}) {}

export class Properties extends S.Class<Properties>("Properties")({
    "click_url": ClickUrl,
    "country": ClickUrl,
    "description": ClickUrl,
    "expiration_date": ClickUrl,
    "id": ClickUrl,
    "industry": ClickUrl,
    "report_type": ClickUrl,
    "source_industry": ClickUrl,
    "title": ClickUrl,
    "url": ClickUrl,
}) {}

export class Report extends S.Class<Report>("Report")({
    "properties": Properties,
}) {}

export class Definitions extends S.Class<Definitions>("Definitions")({
    "Report": Report,
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
