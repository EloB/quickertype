import * as S from "effect/Schema";


export const Language = S.Literal(
    "Markdown",
);
export type Language = S.Schema.Type<typeof Language>;


export const Type = S.Literal(
    "text/plain",
);
export type Type = S.Schema.Type<typeof Type>;

export class File extends S.Class<File>("File")({
    "filename": S.String,
    "language": S.NullOr(Language),
    "raw_url": S.String,
    "size": S.Int,
    "type": Type,
}) {}

export class TopLevelElement extends S.Class<TopLevelElement>("TopLevelElement")({
    "comments": S.Int,
    "comments_url": S.String,
    "commits_url": S.String,
    "created_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "description": S.NullOr(S.String),
    "files": S.Record({ key: S.String, value: File}),
    "forks_url": S.String,
    "git_pull_url": S.String,
    "git_push_url": S.String,
    "html_url": S.String,
    "id": S.String,
    "public": S.Boolean,
    "truncated": S.Boolean,
    "updated_at": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "url": S.String,
    "user": S.Null,
}) {}

export const TopLevel = S.Array(TopLevelElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;
