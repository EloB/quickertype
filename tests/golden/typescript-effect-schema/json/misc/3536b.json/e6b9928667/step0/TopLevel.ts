import * as S from "effect/Schema";


export const Scheme = S.Literal(
    "SPDX",
    "DEP5",
    "Trove",
);
export type Scheme = S.Schema.Type<typeof Scheme>;


export const Keyword = S.Literal(
    "discouraged",
    "obsolete",
    "osi-approved",
);
export type Keyword = S.Schema.Type<typeof Keyword>;

export class Text extends S.Class<Text>("Text")({
    "media_type": S.String,
    "title": S.String,
    "url": S.String,
}) {}

export class Link extends S.Class<Link>("Link")({
    "note": S.String,
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
    "superseded_by": S.String,
    "text": S.Array(Text),
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
