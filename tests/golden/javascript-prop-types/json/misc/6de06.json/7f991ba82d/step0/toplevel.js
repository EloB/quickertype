// Example usage:
//
// import { MyShape } from ./myShape.js;
//
// class MyComponent extends React.Component {
//   //
// }
//
// MyComponent.propTypes = {
//   input: MyShape
// };

import PropTypes from "prop-types";
const Integer = (props, name) => props[name] == null || Number.isInteger(props[name]) ? null : new Error("Expected integer");

let _TopLevel;
let _TopLevelData;
let _Child;
let _ChildData;
let _Media;
let _Oembed;
let _MediaEmbed;
let _Preview;
let _Image;
let _Source;
let _Variants;
let _GIF;
const _PostHint = PropTypes.oneOf(['link', 'image', 'rich:video']);
const _SubredditType = PropTypes.oneOf(['public']);
const _Kind = PropTypes.oneOf(['t3']);
_Oembed = PropTypes.shape({
    "description": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "height": PropTypes.oneOfType([Integer]).isRequired,
    "html": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "provider_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "provider_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "thumbnail_height": PropTypes.oneOfType([Integer]).isRequired,
    "thumbnail_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "thumbnail_width": PropTypes.oneOfType([Integer]).isRequired,
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "version": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([Integer]).isRequired,
});
_Media = PropTypes.shape({
    "oembed": _Oembed,
    "type": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_MediaEmbed = PropTypes.shape({
    "content": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "height": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
    "scrolling": PropTypes.oneOfType([PropTypes.bool, PropTypes.oneOf([null])]),
    "width": PropTypes.oneOfType([Integer, PropTypes.oneOf([null])]),
});
_Source = PropTypes.shape({
    "height": PropTypes.oneOfType([Integer]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([Integer]).isRequired,
});
_GIF = PropTypes.shape({
    "resolutions": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "source": _Source,
});
_Variants = PropTypes.shape({
    "gif": PropTypes.oneOfType([_GIF, PropTypes.oneOf([null])]),
    "mp4": PropTypes.oneOfType([_GIF, PropTypes.oneOf([null])]),
    "nsfw": PropTypes.oneOfType([_GIF, PropTypes.oneOf([null])]),
    "obfuscated": PropTypes.oneOfType([_GIF, PropTypes.oneOf([null])]),
});
_Image = PropTypes.shape({
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "resolutions": PropTypes.oneOfType([PropTypes.arrayOf(_Source)]).isRequired,
    "source": _Source,
    "variants": _Variants,
});
_Preview = PropTypes.shape({
    "enabled": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "images": PropTypes.oneOfType([PropTypes.arrayOf(_Image)]).isRequired,
});
_ChildData = PropTypes.shape({
    "approved_at_utc": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "approved_by": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "archived": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "author": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "author_flair_css_class": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "author_flair_text": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "banned_at_utc": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "banned_by": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "brand_safe": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "can_gild": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "can_mod_post": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "clicked": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "contest_mode": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "created": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "created_utc": PropTypes.oneOfType([PropTypes.number]).isRequired,
    "distinguished": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "domain": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "downs": PropTypes.oneOfType([Integer]).isRequired,
    "edited": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "gilded": PropTypes.oneOfType([Integer]).isRequired,
    "hidden": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "hide_score": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "is_self": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "is_video": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "likes": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "link_flair_css_class": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "link_flair_text": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "locked": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "media": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Media, PropTypes.oneOf([null])])])(props, name, ...args),
    "media_embed": _MediaEmbed,
    "mod_reports": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "num_comments": PropTypes.oneOfType([Integer]).isRequired,
    "num_reports": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "over_18": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "permalink": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "post_hint": PropTypes.oneOfType([_PostHint, PropTypes.oneOf([null])]),
    "preview": PropTypes.oneOfType([_Preview, PropTypes.oneOf([null])]),
    "quarantine": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "removal_reason": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "report_reasons": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "saved": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "score": PropTypes.oneOfType([Integer]).isRequired,
    "secure_media": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([_Media, PropTypes.oneOf([null])])])(props, name, ...args),
    "secure_media_embed": _MediaEmbed,
    "selftext": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "selftext_html": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "spoiler": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "stickied": PropTypes.oneOfType([PropTypes.bool]).isRequired,
    "subreddit": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subreddit_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subreddit_name_prefixed": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "subreddit_type": _SubredditType,
    "suggested_sort": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string])])(props, name, ...args),
    "thumbnail": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "thumbnail_height": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "thumbnail_width": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOfType([Integer, PropTypes.oneOf([null])])])(props, name, ...args),
    "title": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "ups": PropTypes.oneOfType([Integer]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user_reports": PropTypes.oneOfType([PropTypes.arrayOf(PropTypes.any)]).isRequired,
    "view_count": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "visited": PropTypes.oneOfType([PropTypes.bool]).isRequired,
});
_Child = PropTypes.shape({
    "data": _ChildData,
    "kind": _Kind,
});
_TopLevelData = PropTypes.shape({
    "after": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "before": (props, name, ...args) => props[name] === undefined ? new Error("Expected required property") : PropTypes.oneOfType([PropTypes.oneOf([null])])(props, name, ...args),
    "children": PropTypes.oneOfType([PropTypes.arrayOf(_Child)]).isRequired,
    "modhash": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_TopLevel = PropTypes.shape({
    "data": _TopLevelData,
    "kind": PropTypes.oneOfType([PropTypes.string]).isRequired,
});

export const TopLevel = _TopLevel;
