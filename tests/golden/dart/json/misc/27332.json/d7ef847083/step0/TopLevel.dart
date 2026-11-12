// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final TopLevelData data;
    final String kind;

    TopLevel({
        required this.data,
        required this.kind,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: TopLevelData.fromJson(json["data"]),
        kind: json["kind"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "kind": kind,
    };
}

class TopLevelData {
    final String after;
    final dynamic before;
    final List<Child> children;
    final String modhash;

    TopLevelData({
        required this.after,
        required this.before,
        required this.children,
        required this.modhash,
    });

    factory TopLevelData.fromJson(Map<String, dynamic> json) => TopLevelData(
        after: json["after"],
        before: (json.containsKey("before") ? json["before"] : throw FormatException('Missing required property')),
        children: List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
        modhash: json["modhash"],
    );

    Map<String, dynamic> toJson() => {
        "after": after,
        "before": before,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "modhash": modhash,
    };
}

class Child {
    final ChildData data;
    final Kind kind;

    Child({
        required this.data,
        required this.kind,
    });

    factory Child.fromJson(Map<String, dynamic> json) => Child(
        data: ChildData.fromJson(json["data"]),
        kind: kindValues.map[json["kind"]]!,
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "kind": kindValues.reverse[kind],
    };
}

class ChildData {
    final dynamic approvedAtUtc;
    final dynamic approvedBy;
    final bool archived;
    final String author;
    final String? authorFlairCssClass;
    final String? authorFlairText;
    final dynamic bannedAtUtc;
    final dynamic bannedBy;
    final bool brandSafe;
    final bool canGild;
    final bool canModPost;
    final bool clicked;
    final bool contestMode;
    final double created;
    final double createdUtc;
    final String? distinguished;
    final Domain domain;
    final int downs;
    final bool edited;
    final int gilded;
    final bool hidden;
    final bool hideScore;
    final String id;
    final bool isSelf;
    final bool isVideo;
    final dynamic likes;
    final String? linkFlairCssClass;
    final String? linkFlairText;
    final bool locked;
    final Media? media;
    final MediaEmbed mediaEmbed;
    final List<dynamic> modReports;
    final String name;
    final int numComments;
    final dynamic numReports;
    final bool over18;
    final String permalink;
    final PostHint? postHint;
    final Preview? preview;
    final bool quarantine;
    final dynamic removalReason;
    final dynamic reportReasons;
    final bool saved;
    final int score;
    final Media? secureMedia;
    final MediaEmbed secureMediaEmbed;
    final String selftext;
    final String? selftextHtml;
    final bool spoiler;
    final bool stickied;
    final Subreddit subreddit;
    final SubredditId subredditId;
    final SubredditNamePrefixed subredditNamePrefixed;
    final SubredditType subredditType;
    final dynamic suggestedSort;
    final String thumbnail;
    final int? thumbnailHeight;
    final int? thumbnailWidth;
    final String title;
    final int ups;
    final String url;
    final List<dynamic> userReports;
    final dynamic viewCount;
    final bool visited;

    ChildData({
        required this.approvedAtUtc,
        required this.approvedBy,
        required this.archived,
        required this.author,
        required this.authorFlairCssClass,
        required this.authorFlairText,
        required this.bannedAtUtc,
        required this.bannedBy,
        required this.brandSafe,
        required this.canGild,
        required this.canModPost,
        required this.clicked,
        required this.contestMode,
        required this.created,
        required this.createdUtc,
        required this.distinguished,
        required this.domain,
        required this.downs,
        required this.edited,
        required this.gilded,
        required this.hidden,
        required this.hideScore,
        required this.id,
        required this.isSelf,
        required this.isVideo,
        required this.likes,
        required this.linkFlairCssClass,
        required this.linkFlairText,
        required this.locked,
        required this.media,
        required this.mediaEmbed,
        required this.modReports,
        required this.name,
        required this.numComments,
        required this.numReports,
        required this.over18,
        required this.permalink,
        this.postHint,
        this.preview,
        required this.quarantine,
        required this.removalReason,
        required this.reportReasons,
        required this.saved,
        required this.score,
        required this.secureMedia,
        required this.secureMediaEmbed,
        required this.selftext,
        required this.selftextHtml,
        required this.spoiler,
        required this.stickied,
        required this.subreddit,
        required this.subredditId,
        required this.subredditNamePrefixed,
        required this.subredditType,
        required this.suggestedSort,
        required this.thumbnail,
        required this.thumbnailHeight,
        required this.thumbnailWidth,
        required this.title,
        required this.ups,
        required this.url,
        required this.userReports,
        required this.viewCount,
        required this.visited,
    });

    factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        approvedAtUtc: (json.containsKey("approved_at_utc") ? json["approved_at_utc"] : throw FormatException('Missing required property')),
        approvedBy: (json.containsKey("approved_by") ? json["approved_by"] : throw FormatException('Missing required property')),
        archived: json["archived"],
        author: json["author"],
        authorFlairCssClass: (json.containsKey("author_flair_css_class") ? json["author_flair_css_class"] : throw FormatException('Missing required property')),
        authorFlairText: (json.containsKey("author_flair_text") ? json["author_flair_text"] : throw FormatException('Missing required property')),
        bannedAtUtc: (json.containsKey("banned_at_utc") ? json["banned_at_utc"] : throw FormatException('Missing required property')),
        bannedBy: (json.containsKey("banned_by") ? json["banned_by"] : throw FormatException('Missing required property')),
        brandSafe: json["brand_safe"],
        canGild: json["can_gild"],
        canModPost: json["can_mod_post"],
        clicked: json["clicked"],
        contestMode: json["contest_mode"],
        created: json["created"]?.toDouble(),
        createdUtc: json["created_utc"]?.toDouble(),
        distinguished: (json.containsKey("distinguished") ? json["distinguished"] : throw FormatException('Missing required property')),
        domain: domainValues.map[json["domain"]]!,
        downs: json["downs"],
        edited: json["edited"],
        gilded: json["gilded"],
        hidden: json["hidden"],
        hideScore: json["hide_score"],
        id: json["id"],
        isSelf: json["is_self"],
        isVideo: json["is_video"],
        likes: (json.containsKey("likes") ? json["likes"] : throw FormatException('Missing required property')),
        linkFlairCssClass: (json.containsKey("link_flair_css_class") ? json["link_flair_css_class"] : throw FormatException('Missing required property')),
        linkFlairText: (json.containsKey("link_flair_text") ? json["link_flair_text"] : throw FormatException('Missing required property')),
        locked: json["locked"],
        media: (json.containsKey("media") ? json["media"] : throw FormatException('Missing required property')) == null ? null : Media.fromJson((json.containsKey("media") ? json["media"] : throw FormatException('Missing required property'))),
        mediaEmbed: MediaEmbed.fromJson(json["media_embed"]),
        modReports: List<dynamic>.from(json["mod_reports"].map((x) => x)),
        name: json["name"],
        numComments: json["num_comments"],
        numReports: (json.containsKey("num_reports") ? json["num_reports"] : throw FormatException('Missing required property')),
        over18: json["over_18"],
        permalink: json["permalink"],
        postHint: json["post_hint"] == null ? null : postHintValues.map[json["post_hint"]]!,
        preview: json["preview"] == null ? null : Preview.fromJson(json["preview"]),
        quarantine: json["quarantine"],
        removalReason: (json.containsKey("removal_reason") ? json["removal_reason"] : throw FormatException('Missing required property')),
        reportReasons: (json.containsKey("report_reasons") ? json["report_reasons"] : throw FormatException('Missing required property')),
        saved: json["saved"],
        score: json["score"],
        secureMedia: (json.containsKey("secure_media") ? json["secure_media"] : throw FormatException('Missing required property')) == null ? null : Media.fromJson((json.containsKey("secure_media") ? json["secure_media"] : throw FormatException('Missing required property'))),
        secureMediaEmbed: MediaEmbed.fromJson(json["secure_media_embed"]),
        selftext: json["selftext"],
        selftextHtml: (json.containsKey("selftext_html") ? json["selftext_html"] : throw FormatException('Missing required property')),
        spoiler: json["spoiler"],
        stickied: json["stickied"],
        subreddit: subredditValues.map[json["subreddit"]]!,
        subredditId: subredditIdValues.map[json["subreddit_id"]]!,
        subredditNamePrefixed: subredditNamePrefixedValues.map[json["subreddit_name_prefixed"]]!,
        subredditType: subredditTypeValues.map[json["subreddit_type"]]!,
        suggestedSort: (json.containsKey("suggested_sort") ? json["suggested_sort"] : throw FormatException('Missing required property')),
        thumbnail: json["thumbnail"],
        thumbnailHeight: (json.containsKey("thumbnail_height") ? json["thumbnail_height"] : throw FormatException('Missing required property')),
        thumbnailWidth: (json.containsKey("thumbnail_width") ? json["thumbnail_width"] : throw FormatException('Missing required property')),
        title: json["title"],
        ups: json["ups"],
        url: json["url"],
        userReports: List<dynamic>.from(json["user_reports"].map((x) => x)),
        viewCount: (json.containsKey("view_count") ? json["view_count"] : throw FormatException('Missing required property')),
        visited: json["visited"],
    );

    Map<String, dynamic> toJson() => {
        "approved_at_utc": approvedAtUtc,
        "approved_by": approvedBy,
        "archived": archived,
        "author": author,
        "author_flair_css_class": authorFlairCssClass,
        "author_flair_text": authorFlairText,
        "banned_at_utc": bannedAtUtc,
        "banned_by": bannedBy,
        "brand_safe": brandSafe,
        "can_gild": canGild,
        "can_mod_post": canModPost,
        "clicked": clicked,
        "contest_mode": contestMode,
        "created": created,
        "created_utc": createdUtc,
        "distinguished": distinguished,
        "domain": domainValues.reverse[domain],
        "downs": downs,
        "edited": edited,
        "gilded": gilded,
        "hidden": hidden,
        "hide_score": hideScore,
        "id": id,
        "is_self": isSelf,
        "is_video": isVideo,
        "likes": likes,
        "link_flair_css_class": linkFlairCssClass,
        "link_flair_text": linkFlairText,
        "locked": locked,
        "media": media?.toJson(),
        "media_embed": mediaEmbed.toJson(),
        "mod_reports": List<dynamic>.from(modReports.map((x) => x)),
        "name": name,
        "num_comments": numComments,
        "num_reports": numReports,
        "over_18": over18,
        "permalink": permalink,
        "post_hint": postHintValues.reverse[postHint],
        "preview": preview?.toJson(),
        "quarantine": quarantine,
        "removal_reason": removalReason,
        "report_reasons": reportReasons,
        "saved": saved,
        "score": score,
        "secure_media": secureMedia?.toJson(),
        "secure_media_embed": secureMediaEmbed.toJson(),
        "selftext": selftext,
        "selftext_html": selftextHtml,
        "spoiler": spoiler,
        "stickied": stickied,
        "subreddit": subredditValues.reverse[subreddit],
        "subreddit_id": subredditIdValues.reverse[subredditId],
        "subreddit_name_prefixed": subredditNamePrefixedValues.reverse[subredditNamePrefixed],
        "subreddit_type": subredditTypeValues.reverse[subredditType],
        "suggested_sort": suggestedSort,
        "thumbnail": thumbnail,
        "thumbnail_height": thumbnailHeight,
        "thumbnail_width": thumbnailWidth,
        "title": title,
        "ups": ups,
        "url": url,
        "user_reports": List<dynamic>.from(userReports.map((x) => x)),
        "view_count": viewCount,
        "visited": visited,
    };
}

enum Domain {
    SELF_PICS,
    IMGUR_COM,
    I_IMGUR_COM,
    I_REDD_IT
}

final domainValues = EnumValues({
    "self.pics": Domain.SELF_PICS,
    "imgur.com": Domain.IMGUR_COM,
    "i.imgur.com": Domain.I_IMGUR_COM,
    "i.redd.it": Domain.I_REDD_IT
});

class Media {
    final Oembed oembed;
    final Domain type;

    Media({
        required this.oembed,
        required this.type,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        oembed: Oembed.fromJson(json["oembed"]),
        type: domainValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "oembed": oembed.toJson(),
        "type": domainValues.reverse[type],
    };
}

class Oembed {
    final String description;
    final int height;
    final String html;
    final String providerName;
    final String providerUrl;
    final int thumbnailHeight;
    final String thumbnailUrl;
    final int thumbnailWidth;
    final String title;
    final String type;
    final String version;
    final int width;

    Oembed({
        required this.description,
        required this.height,
        required this.html,
        required this.providerName,
        required this.providerUrl,
        required this.thumbnailHeight,
        required this.thumbnailUrl,
        required this.thumbnailWidth,
        required this.title,
        required this.type,
        required this.version,
        required this.width,
    });

    factory Oembed.fromJson(Map<String, dynamic> json) => Oembed(
        description: json["description"],
        height: json["height"],
        html: json["html"],
        providerName: json["provider_name"],
        providerUrl: json["provider_url"],
        thumbnailHeight: json["thumbnail_height"],
        thumbnailUrl: json["thumbnail_url"],
        thumbnailWidth: json["thumbnail_width"],
        title: json["title"],
        type: json["type"],
        version: json["version"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "height": height,
        "html": html,
        "provider_name": providerName,
        "provider_url": providerUrl,
        "thumbnail_height": thumbnailHeight,
        "thumbnail_url": thumbnailUrl,
        "thumbnail_width": thumbnailWidth,
        "title": title,
        "type": type,
        "version": version,
        "width": width,
    };
}

class MediaEmbed {
    final String? content;
    final int? height;
    final bool? scrolling;
    final int? width;

    MediaEmbed({
        this.content,
        this.height,
        this.scrolling,
        this.width,
    });

    factory MediaEmbed.fromJson(Map<String, dynamic> json) => MediaEmbed(
        content: json["content"],
        height: json["height"],
        scrolling: json["scrolling"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "height": height,
        "scrolling": scrolling,
        "width": width,
    };
}

enum PostHint {
    LINK,
    IMAGE
}

final postHintValues = EnumValues({
    "link": PostHint.LINK,
    "image": PostHint.IMAGE
});

class Preview {
    final bool enabled;
    final List<Image> images;

    Preview({
        required this.enabled,
        required this.images,
    });

    factory Preview.fromJson(Map<String, dynamic> json) => Preview(
        enabled: json["enabled"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    final String id;
    final List<Source> resolutions;
    final Source source;
    final Variants variants;

    Image({
        required this.id,
        required this.resolutions,
        required this.source,
        required this.variants,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        resolutions: List<Source>.from(json["resolutions"].map((x) => Source.fromJson(x))),
        source: Source.fromJson(json["source"]),
        variants: Variants.fromJson(json["variants"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "resolutions": List<dynamic>.from(resolutions.map((x) => x.toJson())),
        "source": source.toJson(),
        "variants": variants.toJson(),
    };
}

class Source {
    final int height;
    final String url;
    final int width;

    Source({
        required this.height,
        required this.url,
        required this.width,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

class Variants {
    Variants();

    factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    );

    Map<String, dynamic> toJson() => {
    };
}

enum Subreddit {
    PICS
}

final subredditValues = EnumValues({
    "pics": Subreddit.PICS
});

enum SubredditId {
    T5_2_QH0_U
}

final subredditIdValues = EnumValues({
    "t5_2qh0u": SubredditId.T5_2_QH0_U
});

enum SubredditNamePrefixed {
    R_PICS
}

final subredditNamePrefixedValues = EnumValues({
    "r/pics": SubredditNamePrefixed.R_PICS
});

enum SubredditType {
    PUBLIC
}

final subredditTypeValues = EnumValues({
    "public": SubredditType.PUBLIC
});

enum Kind {
    T3
}

final kindValues = EnumValues({
    "t3": Kind.T3
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
