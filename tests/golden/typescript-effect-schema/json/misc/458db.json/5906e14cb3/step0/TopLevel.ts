import * as S from "effect/Schema";


export const Name = S.Literal(
    "Office on Violence Against Women",
);
export type Name = S.Schema.Type<typeof Name>;

export class Component extends S.Class<Component>("Component")({
    "name": Name,
    "uuid": S.UUID,
}) {}

export class Result extends S.Class<Result>("Result")({
    "attachments": S.Array(S.Any),
    "body": S.String,
    "changed": S.String.pipe(S.pattern(/^-?\d+$/)),
    "component": S.Array(Component),
    "created": S.String.pipe(S.pattern(/^-?\d+$/)),
    "date": S.String,
    "image": S.Array(S.Any),
    "teaser": S.Array(S.Any),
    "title": S.String,
    "topic": S.Array(S.Any),
    "url": S.String,
    "uuid": S.UUID,
    "vuuid": S.UUID,
}) {}

export class Resultset extends S.Class<Resultset>("Resultset")({
    "count": S.Int,
    "page": S.Int,
    "pagesize": S.Int,
}) {}

export class ResponseInfo extends S.Class<ResponseInfo>("ResponseInfo")({
    "developerMessage": S.String,
    "status": S.Int,
}) {}

export class Metadata extends S.Class<Metadata>("Metadata")({
    "executionTime": S.Number,
    "responseInfo": ResponseInfo,
    "resultset": Resultset,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "metadata": Metadata,
    "results": S.Array(Result),
}) {}
