import * as S from "effect/Schema";


export const DetailLanguage = S.Literal(
    "en",
    "th",
);
export type DetailLanguage = S.Schema.Type<typeof DetailLanguage>;


export const Type = S.Literal(
    "Poster",
    "Backdrop",
);
export type Type = S.Schema.Type<typeof Type>;


export const ResultLanguage = S.Literal(
    "en",
    "-",
);
export type ResultLanguage = S.Schema.Type<typeof ResultLanguage>;

export class VoteScore extends S.Class<VoteScore>("VoteScore")({
    "avg": S.Int,
    "score": S.Int,
    "total": S.Int,
}) {}

export class Video extends S.Class<Video>("Video")({
    "kind": S.String,
    "language": ResultLanguage,
    "source": S.String,
    "url": S.String,
}) {}

export class Image extends S.Class<Image>("Image")({
    "favs": S.Int,
    "id": S.Int,
    "thumbnail": S.String,
    "type": Type,
    "url": S.String,
}) {}

export class FavMovie extends S.Class<FavMovie>("FavMovie")({
    "follow": S.Boolean,
    "star": S.Boolean,
    "watched": S.Boolean,
}) {}

export class Detail extends S.Class<Detail>("Detail")({
    "cast": S.String,
    "director": S.String,
    "id": S.Int,
    "language": DetailLanguage,
    "storyline": S.String,
    "tagline": S.String,
    "title": S.String,
}) {}

export class Collection extends S.Class<Collection>("Collection")({
    "id": S.Int,
    "movies": S.Array(S.Int),
    "name": S.String,
    "slug": S.String,
}) {}

export class Result extends S.Class<Result>("Result")({
    "active_screens": S.Int,
    "collections": S.Array(Collection),
    "details": S.Array(Detail),
    "duration": S.Int,
    "fav_movie": FavMovie,
    "id": S.Int,
    "images": S.Array(Image),
    "language": ResultLanguage,
    "release_date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "stars": S.Int,
    "tags": S.NullOr(S.Array(S.Any)),
    "title": S.String,
    "videos": S.Array(Video),
    "vote_score": VoteScore,
    "watches": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "count": S.Int,
    "next": S.String,
    "previous": S.Null,
    "results": S.Array(Result),
}) {}
