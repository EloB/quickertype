import * as S from "effect/Schema";


export const Rating = S.Literal(
    "g",
    "y",
    "pg",
    "pg-13",
);
export type Rating = S.Schema.Type<typeof Rating>;


export const Type = S.Literal(
    "gif",
);
export type Type = S.Schema.Type<typeof Type>;


export const Username = S.Literal(
    "",
    "producthunt",
    "meetaiko",
    "cheezburger",
);
export type Username = S.Schema.Type<typeof Username>;

export class Pagination extends S.Class<Pagination>("Pagination")({
    "count": S.Int,
    "offset": S.Int,
    "total_count": S.Int,
}) {}

export class Meta extends S.Class<Meta>("Meta")({
    "msg": S.String,
    "response_id": S.String,
    "status": S.Int,
}) {}

export class User extends S.Class<User>("User")({
    "avatar_url": S.String,
    "banner_url": S.String,
    "display_name": S.String,
    "profile_url": S.String,
    "twitter": S.String,
    "username": Username,
}) {}

export class Looping extends S.Class<Looping>("Looping")({
    "mp4": S.String,
    "mp4_size": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class FixedHeight extends S.Class<FixedHeight>("FixedHeight")({
    "frames": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "hash": S.optional(S.String),
    "height": S.String.pipe(S.pattern(/^-?\d+$/)),
    "mp4": S.optional(S.String),
    "mp4_size": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "size": S.String.pipe(S.pattern(/^-?\d+$/)),
    "url": S.String,
    "webp": S.String,
    "webp_size": S.String.pipe(S.pattern(/^-?\d+$/)),
    "width": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class DownsizedSmall extends S.Class<DownsizedSmall>("DownsizedSmall")({
    "height": S.String.pipe(S.pattern(/^-?\d+$/)),
    "mp4": S.String,
    "mp4_size": S.String.pipe(S.pattern(/^-?\d+$/)),
    "width": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class The480_WStill extends S.Class<The480_WStill>("The480_WStill")({
    "height": S.String.pipe(S.pattern(/^-?\d+$/)),
    "size": S.optional(S.String.pipe(S.pattern(/^-?\d+$/))),
    "url": S.String,
    "width": S.String.pipe(S.pattern(/^-?\d+$/)),
}) {}

export class Images extends S.Class<Images>("Images")({
    "downsized": The480_WStill,
    "downsized_large": The480_WStill,
    "downsized_medium": The480_WStill,
    "downsized_small": DownsizedSmall,
    "downsized_still": The480_WStill,
    "fixed_height": FixedHeight,
    "fixed_height_downsampled": FixedHeight,
    "fixed_height_small": FixedHeight,
    "fixed_height_small_still": The480_WStill,
    "fixed_height_still": The480_WStill,
    "fixed_width": FixedHeight,
    "fixed_width_downsampled": FixedHeight,
    "fixed_width_small": FixedHeight,
    "fixed_width_small_still": The480_WStill,
    "fixed_width_still": The480_WStill,
    "looping": Looping,
    "original": FixedHeight,
    "original_mp4": DownsizedSmall,
    "original_still": The480_WStill,
    "preview": DownsizedSmall,
    "preview_gif": The480_WStill,
    "preview_webp": The480_WStill,
    "480w_still": S.optional(The480_WStill),
}) {}

export class Datum extends S.Class<Datum>("Datum")({
    "bitly_gif_url": S.String,
    "bitly_url": S.String,
    "content_url": S.String,
    "embed_url": S.String,
    "id": S.String,
    "images": Images,
    "import_datetime": S.String,
    "is_indexable": S.Int,
    "rating": Rating,
    "slug": S.String,
    "source": S.String,
    "source_post_url": S.String,
    "source_tld": S.String,
    "trending_datetime": S.String,
    "type": Type,
    "url": S.String,
    "user": S.optional(User),
    "username": Username,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": S.Array(Datum),
    "meta": Meta,
    "pagination": Pagination,
}) {}
