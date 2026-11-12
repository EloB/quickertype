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
let _Datum;
let _Images;
let _Downsized;
let _DownsizedSmall;
let _FixedHeight;
let _Looping;
let _User;
let _Meta;
let _Pagination;
const _Rating = PropTypes.oneOf(['g', 'pg', 'y', 'pg-13']);
const _Type = PropTypes.oneOf(['gif']);
_Downsized = PropTypes.shape({
    "height": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "size": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_DownsizedSmall = PropTypes.shape({
    "height": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mp4": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mp4_size": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_FixedHeight = PropTypes.shape({
    "frames": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "height": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mp4": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "mp4_size": PropTypes.oneOfType([PropTypes.oneOf([null]), PropTypes.string]),
    "size": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "webp": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "webp_size": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "width": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Looping = PropTypes.shape({
    "mp4": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "mp4_size": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Images = PropTypes.shape({
    "downsized": _Downsized,
    "downsized_large": _Downsized,
    "downsized_medium": _Downsized,
    "downsized_small": _DownsizedSmall,
    "downsized_still": _Downsized,
    "fixed_height": _FixedHeight,
    "fixed_height_downsampled": _FixedHeight,
    "fixed_height_small": _FixedHeight,
    "fixed_height_small_still": _Downsized,
    "fixed_height_still": _Downsized,
    "fixed_width": _FixedHeight,
    "fixed_width_downsampled": _FixedHeight,
    "fixed_width_small": _FixedHeight,
    "fixed_width_small_still": _Downsized,
    "fixed_width_still": _Downsized,
    "looping": _Looping,
    "original": _FixedHeight,
    "original_mp4": _DownsizedSmall,
    "original_still": _Downsized,
    "preview": _DownsizedSmall,
    "preview_gif": _Downsized,
    "preview_webp": _Downsized,
});
_User = PropTypes.shape({
    "avatar_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "banner_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "display_name": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "profile_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "twitter": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "username": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Datum = PropTypes.shape({
    "bitly_gif_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "bitly_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "content_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "embed_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "images": _Images,
    "import_datetime": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "is_indexable": PropTypes.oneOfType([Integer]).isRequired,
    "rating": _Rating,
    "slug": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "source": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "source_post_url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "source_tld": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "trending_datetime": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "type": _Type,
    "url": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "user": PropTypes.oneOfType([_User, PropTypes.oneOf([null])]),
    "username": PropTypes.oneOfType([PropTypes.string]).isRequired,
});
_Meta = PropTypes.shape({
    "msg": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "response_id": PropTypes.oneOfType([PropTypes.string]).isRequired,
    "status": PropTypes.oneOfType([Integer]).isRequired,
});
_Pagination = PropTypes.shape({
    "count": PropTypes.oneOfType([Integer]).isRequired,
    "offset": PropTypes.oneOfType([Integer]).isRequired,
    "total_count": PropTypes.oneOfType([Integer]).isRequired,
});
_TopLevel = PropTypes.shape({
    "data": PropTypes.oneOfType([PropTypes.arrayOf(_Datum)]).isRequired,
    "meta": _Meta,
    "pagination": _Pagination,
});

export const TopLevel = _TopLevel;
