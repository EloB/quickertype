import * as S from "effect/Schema";


export const Scheme = S.Literal(
    "SPDX",
    "Trove",
    "DEP5",
);
export type Scheme = S.Schema.Type<typeof Scheme>;


export const Keyword = S.Literal(
    "discouraged",
    "non-reusable",
    "osi-approved",
);
export type Keyword = S.Schema.Type<typeof Keyword>;


export const Note = S.Literal(
    "OSI Page",
);
export type Note = S.Schema.Type<typeof Note>;


export const MediaType = S.Literal(
    "text/html",
);
export type MediaType = S.Schema.Type<typeof MediaType>;


export const Title = S.Literal(
    "HTML",
);
export type Title = S.Schema.Type<typeof Title>;

export class Text extends S.Class<Text>("Text")({
    "media_type": MediaType,
    "title": Title,
    "url": S.String,
}) {}

export class Link extends S.Class<Link>("Link")({
    "note": Note,
    "url": S.String,
}) {}

export class Identifier extends S.Class<Identifier>("Identifier")({
    "identifier": S.String,
    "scheme": Scheme,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "id": S.String,
    "identifiers": S.Array(Identifier),
    "keywords": S.Array(Keyword),
    "links": S.Array(Link),
    "name": S.String,
    "other_names": S.Array(S.Any),
    "superseded_by": S.Null,
    "text": S.Array(Text),
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
