import * as S from "effect/Schema";


export class Image extends S.Class<Image>("Image")({
    "height": S.Int,
    "url": S.String,
    "width": S.Int,
}) {}

export class ExternalIds extends S.Class<ExternalIds>("ExternalIds")({
    "upc": S.String,
}) {}

export class Copyright extends S.Class<Copyright>("Copyright")({
    "text": S.String,
    "type": S.String,
}) {}

export class Item extends S.Class<Item>("Item")({
    "artists": S.Array(S.suspend(() => Artist)),
    "available_markets": S.Array(S.String),
    "disc_number": S.Int,
    "duration_ms": S.Int,
    "explicit": S.Boolean,
    "external_urls": S.suspend(() => ExternalUrls),
    "href": S.String,
    "id": S.String,
    "name": S.String,
    "preview_url": S.String,
    "track_number": S.Int,
    "type": S.String,
    "uri": S.String,
}) {}

export class Tracks extends S.Class<Tracks>("Tracks")({
    "href": S.String,
    "items": S.Array(Item),
    "limit": S.Int,
    "next": S.Null,
    "offset": S.Int,
    "previous": S.Null,
    "total": S.Int,
}) {}

export class ExternalUrls extends S.Class<ExternalUrls>("ExternalUrls")({
    "spotify": S.String,
}) {}

export class Artist extends S.Class<Artist>("Artist")({
    "external_urls": ExternalUrls,
    "href": S.String,
    "id": S.String,
    "name": S.String,
    "type": S.String,
    "uri": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "album_type": S.String,
    "artists": S.Array(Artist),
    "available_markets": S.Array(S.String),
    "copyrights": S.Array(Copyright),
    "external_ids": ExternalIds,
    "external_urls": ExternalUrls,
    "genres": S.Array(S.Any),
    "href": S.String,
    "id": S.String,
    "images": S.Array(Image),
    "name": S.String,
    "popularity": S.Int,
    "release_date": S.String.pipe(S.pattern(/^-?\d+$/)),
    "release_date_precision": S.String,
    "tracks": Tracks,
    "type": S.String,
    "uri": S.String,
}) {}
