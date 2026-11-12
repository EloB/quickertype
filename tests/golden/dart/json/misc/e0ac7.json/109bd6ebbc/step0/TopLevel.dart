// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Datum> data;
    final Meta meta;
    final Pagination pagination;

    TopLevel({
        required this.data,
        required this.meta,
        required this.pagination,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
        "pagination": pagination.toJson(),
    };
}

class Datum {
    final String bitlyGifUrl;
    final String bitlyUrl;
    final String contentUrl;
    final String embedUrl;
    final String id;
    final Images images;
    final String importDatetime;
    final int isIndexable;
    final Rating rating;
    final String slug;
    final String source;
    final String sourcePostUrl;
    final String sourceTld;
    final String trendingDatetime;
    final Type type;
    final String url;
    final User? user;
    final String username;

    Datum({
        required this.bitlyGifUrl,
        required this.bitlyUrl,
        required this.contentUrl,
        required this.embedUrl,
        required this.id,
        required this.images,
        required this.importDatetime,
        required this.isIndexable,
        required this.rating,
        required this.slug,
        required this.source,
        required this.sourcePostUrl,
        required this.sourceTld,
        required this.trendingDatetime,
        required this.type,
        required this.url,
        this.user,
        required this.username,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bitlyGifUrl: json["bitly_gif_url"],
        bitlyUrl: json["bitly_url"],
        contentUrl: json["content_url"],
        embedUrl: json["embed_url"],
        id: json["id"],
        images: Images.fromJson(json["images"]),
        importDatetime: json["import_datetime"],
        isIndexable: json["is_indexable"],
        rating: ratingValues.map[json["rating"]]!,
        slug: json["slug"],
        source: json["source"],
        sourcePostUrl: json["source_post_url"],
        sourceTld: json["source_tld"],
        trendingDatetime: json["trending_datetime"],
        type: typeValues.map[json["type"]]!,
        url: json["url"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "bitly_gif_url": bitlyGifUrl,
        "bitly_url": bitlyUrl,
        "content_url": contentUrl,
        "embed_url": embedUrl,
        "id": id,
        "images": images.toJson(),
        "import_datetime": importDatetime,
        "is_indexable": isIndexable,
        "rating": ratingValues.reverse[rating],
        "slug": slug,
        "source": source,
        "source_post_url": sourcePostUrl,
        "source_tld": sourceTld,
        "trending_datetime": trendingDatetime,
        "type": typeValues.reverse[type],
        "url": url,
        "user": user?.toJson(),
        "username": username,
    };
}

class Images {
    final Downsized downsized;
    final Downsized downsizedLarge;
    final Downsized downsizedMedium;
    final DownsizedSmall downsizedSmall;
    final Downsized downsizedStill;
    final FixedHeight fixedHeight;
    final FixedHeight fixedHeightDownsampled;
    final FixedHeight fixedHeightSmall;
    final Downsized fixedHeightSmallStill;
    final Downsized fixedHeightStill;
    final FixedHeight fixedWidth;
    final FixedHeight fixedWidthDownsampled;
    final FixedHeight fixedWidthSmall;
    final Downsized fixedWidthSmallStill;
    final Downsized fixedWidthStill;
    final DownsizedSmall? hd;
    final Looping looping;
    final FixedHeight original;
    final DownsizedSmall originalMp4;
    final Downsized originalStill;
    final DownsizedSmall preview;
    final Downsized previewGif;
    final Downsized previewWebp;

    Images({
        required this.downsized,
        required this.downsizedLarge,
        required this.downsizedMedium,
        required this.downsizedSmall,
        required this.downsizedStill,
        required this.fixedHeight,
        required this.fixedHeightDownsampled,
        required this.fixedHeightSmall,
        required this.fixedHeightSmallStill,
        required this.fixedHeightStill,
        required this.fixedWidth,
        required this.fixedWidthDownsampled,
        required this.fixedWidthSmall,
        required this.fixedWidthSmallStill,
        required this.fixedWidthStill,
        this.hd,
        required this.looping,
        required this.original,
        required this.originalMp4,
        required this.originalStill,
        required this.preview,
        required this.previewGif,
        required this.previewWebp,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        downsized: Downsized.fromJson(json["downsized"]),
        downsizedLarge: Downsized.fromJson(json["downsized_large"]),
        downsizedMedium: Downsized.fromJson(json["downsized_medium"]),
        downsizedSmall: DownsizedSmall.fromJson(json["downsized_small"]),
        downsizedStill: Downsized.fromJson(json["downsized_still"]),
        fixedHeight: FixedHeight.fromJson(json["fixed_height"]),
        fixedHeightDownsampled: FixedHeight.fromJson(json["fixed_height_downsampled"]),
        fixedHeightSmall: FixedHeight.fromJson(json["fixed_height_small"]),
        fixedHeightSmallStill: Downsized.fromJson(json["fixed_height_small_still"]),
        fixedHeightStill: Downsized.fromJson(json["fixed_height_still"]),
        fixedWidth: FixedHeight.fromJson(json["fixed_width"]),
        fixedWidthDownsampled: FixedHeight.fromJson(json["fixed_width_downsampled"]),
        fixedWidthSmall: FixedHeight.fromJson(json["fixed_width_small"]),
        fixedWidthSmallStill: Downsized.fromJson(json["fixed_width_small_still"]),
        fixedWidthStill: Downsized.fromJson(json["fixed_width_still"]),
        hd: json["hd"] == null ? null : DownsizedSmall.fromJson(json["hd"]),
        looping: Looping.fromJson(json["looping"]),
        original: FixedHeight.fromJson(json["original"]),
        originalMp4: DownsizedSmall.fromJson(json["original_mp4"]),
        originalStill: Downsized.fromJson(json["original_still"]),
        preview: DownsizedSmall.fromJson(json["preview"]),
        previewGif: Downsized.fromJson(json["preview_gif"]),
        previewWebp: Downsized.fromJson(json["preview_webp"]),
    );

    Map<String, dynamic> toJson() => {
        "downsized": downsized.toJson(),
        "downsized_large": downsizedLarge.toJson(),
        "downsized_medium": downsizedMedium.toJson(),
        "downsized_small": downsizedSmall.toJson(),
        "downsized_still": downsizedStill.toJson(),
        "fixed_height": fixedHeight.toJson(),
        "fixed_height_downsampled": fixedHeightDownsampled.toJson(),
        "fixed_height_small": fixedHeightSmall.toJson(),
        "fixed_height_small_still": fixedHeightSmallStill.toJson(),
        "fixed_height_still": fixedHeightStill.toJson(),
        "fixed_width": fixedWidth.toJson(),
        "fixed_width_downsampled": fixedWidthDownsampled.toJson(),
        "fixed_width_small": fixedWidthSmall.toJson(),
        "fixed_width_small_still": fixedWidthSmallStill.toJson(),
        "fixed_width_still": fixedWidthStill.toJson(),
        "hd": hd?.toJson(),
        "looping": looping.toJson(),
        "original": original.toJson(),
        "original_mp4": originalMp4.toJson(),
        "original_still": originalStill.toJson(),
        "preview": preview.toJson(),
        "preview_gif": previewGif.toJson(),
        "preview_webp": previewWebp.toJson(),
    };
}

class Downsized {
    final String height;
    final String? size;
    final String url;
    final String width;

    Downsized({
        required this.height,
        this.size,
        required this.url,
        required this.width,
    });

    factory Downsized.fromJson(Map<String, dynamic> json) => Downsized(
        height: json["height"],
        size: json["size"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "size": size,
        "url": url,
        "width": width,
    };
}

class DownsizedSmall {
    final String height;
    final String mp4;
    final String mp4Size;
    final String width;

    DownsizedSmall({
        required this.height,
        required this.mp4,
        required this.mp4Size,
        required this.width,
    });

    factory DownsizedSmall.fromJson(Map<String, dynamic> json) => DownsizedSmall(
        height: json["height"],
        mp4: json["mp4"],
        mp4Size: json["mp4_size"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "mp4": mp4,
        "mp4_size": mp4Size,
        "width": width,
    };
}

class FixedHeight {
    final String? frames;
    final String? hash;
    final String height;
    final String? mp4;
    final String? mp4Size;
    final String size;
    final String url;
    final String webp;
    final String webpSize;
    final String width;

    FixedHeight({
        this.frames,
        this.hash,
        required this.height,
        this.mp4,
        this.mp4Size,
        required this.size,
        required this.url,
        required this.webp,
        required this.webpSize,
        required this.width,
    });

    factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        frames: json["frames"],
        hash: json["hash"],
        height: json["height"],
        mp4: json["mp4"],
        mp4Size: json["mp4_size"],
        size: json["size"],
        url: json["url"],
        webp: json["webp"],
        webpSize: json["webp_size"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "frames": frames,
        "hash": hash,
        "height": height,
        "mp4": mp4,
        "mp4_size": mp4Size,
        "size": size,
        "url": url,
        "webp": webp,
        "webp_size": webpSize,
        "width": width,
    };
}

class Looping {
    final String mp4;
    final String mp4Size;

    Looping({
        required this.mp4,
        required this.mp4Size,
    });

    factory Looping.fromJson(Map<String, dynamic> json) => Looping(
        mp4: json["mp4"],
        mp4Size: json["mp4_size"],
    );

    Map<String, dynamic> toJson() => {
        "mp4": mp4,
        "mp4_size": mp4Size,
    };
}

enum Rating {
    G,
    PG,
    Y
}

final ratingValues = EnumValues({
    "g": Rating.G,
    "pg": Rating.PG,
    "y": Rating.Y
});

enum Type {
    GIF
}

final typeValues = EnumValues({
    "gif": Type.GIF
});

class User {
    final String avatarUrl;
    final String bannerUrl;
    final String displayName;
    final String profileUrl;
    final String twitter;
    final String username;

    User({
        required this.avatarUrl,
        required this.bannerUrl,
        required this.displayName,
        required this.profileUrl,
        required this.twitter,
        required this.username,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        bannerUrl: json["banner_url"],
        displayName: json["display_name"],
        profileUrl: json["profile_url"],
        twitter: json["twitter"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "banner_url": bannerUrl,
        "display_name": displayName,
        "profile_url": profileUrl,
        "twitter": twitter,
        "username": username,
    };
}

class Meta {
    final String msg;
    final String responseId;
    final int status;

    Meta({
        required this.msg,
        required this.responseId,
        required this.status,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        msg: json["msg"],
        responseId: json["response_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "response_id": responseId,
        "status": status,
    };
}

class Pagination {
    final int count;
    final int offset;
    final int totalCount;

    Pagination({
        required this.count,
        required this.offset,
        required this.totalCount,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        offset: json["offset"],
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "offset": offset,
        "total_count": totalCount,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
