from enum import Enum
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_dict(f: Callable[[Any], T], x: Any) -> dict[str, T]:
    assert isinstance(x, dict)
    return { k: f(v) for (k, v) in x.items() }


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Contains(Enum):
    """Determines how size calculation should be performed, one of `"content"` or `"padding"`.
    The default setting (`"content"`) interprets the width and height settings as the data
    rectangle (plotting) dimensions, to which padding is then added. In contrast, the
    `"padding"` setting includes the padding within the view size calculations, such that the
    width and height settings indicate the **total** intended size of the view.
    
    __Default value__: `"content"`
    """
    CONTENT = "content"
    PADDING = "padding"


class AutosizeType(Enum):
    """The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
    type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
    descriptions of each.
    
    __Default value__: `"pad"`
    """
    PAD = "pad"
    FIT = "fit"
    NONE = "none"


@dataclass
class AutoSizeParams:
    contains: Contains | None = None
    """Determines how size calculation should be performed, one of `"content"` or `"padding"`.
    The default setting (`"content"`) interprets the width and height settings as the data
    rectangle (plotting) dimensions, to which padding is then added. In contrast, the
    `"padding"` setting includes the padding within the view size calculations, such that the
    width and height settings indicate the **total** intended size of the view.
    
    __Default value__: `"content"`
    """
    resize: bool | None = None
    """A boolean flag indicating if autosize layout should be re-calculated on every view
    update.
    
    __Default value__: `false`
    """
    type: AutosizeType | None = None
    """The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
    type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
    descriptions of each.
    
    __Default value__: `"pad"`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'AutoSizeParams':
        assert isinstance(obj, dict)
        contains = from_union([Contains, from_none], obj.get("contains"))
        resize = from_union([from_bool, from_none], obj.get("resize"))
        type = from_union([AutosizeType, from_none], obj.get("type"))
        return AutoSizeParams(contains, resize, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.contains is not None:
            result["contains"] = from_union([lambda x: to_enum(Contains, x), from_none], self.contains)
        if self.resize is not None:
            result["resize"] = from_union([from_bool, from_none], self.resize)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(AutosizeType, x), from_none], self.type)
        return result


class HorizontalAlign(Enum):
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    LEFT = "left"
    RIGHT = "right"
    CENTER = "center"


class VerticalAlign(Enum):
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    
    Vertical text baseline for title text.
    """
    TOP = "top"
    MIDDLE = "middle"
    BOTTOM = "bottom"


class Cursor(Enum):
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    AUTO = "auto"
    DEFAULT = "default"
    NONE = "none"
    CONTEXT_MENU = "context-menu"
    HELP = "help"
    POINTER = "pointer"
    PROGRESS = "progress"
    WAIT = "wait"
    CELL = "cell"
    CROSSHAIR = "crosshair"
    TEXT = "text"
    VERTICAL_TEXT = "vertical-text"
    ALIAS = "alias"
    COPY = "copy"
    MOVE = "move"
    NO_DROP = "no-drop"
    NOT_ALLOWED = "not-allowed"
    E_RESIZE = "e-resize"
    N_RESIZE = "n-resize"
    NE_RESIZE = "ne-resize"
    NW_RESIZE = "nw-resize"
    S_RESIZE = "s-resize"
    SE_RESIZE = "se-resize"
    SW_RESIZE = "sw-resize"
    W_RESIZE = "w-resize"
    EW_RESIZE = "ew-resize"
    NS_RESIZE = "ns-resize"
    NESW_RESIZE = "nesw-resize"
    NWSE_RESIZE = "nwse-resize"
    COL_RESIZE = "col-resize"
    ROW_RESIZE = "row-resize"
    ALL_SCROLL = "all-scroll"
    ZOOM_IN = "zoom-in"
    ZOOM_OUT = "zoom-out"
    GRAB = "grab"
    GRABBING = "grabbing"


class FontStyle(Enum):
    """The font style (e.g., `"italic"`)."""

    NORMAL = "normal"
    ITALIC = "italic"


class FontWeight(Enum):
    NORMAL = "normal"
    BOLD = "bold"


class Interpolate(Enum):
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    LINEAR = "linear"
    LINEAR_CLOSED = "linear-closed"
    STEP = "step"
    STEP_BEFORE = "step-before"
    STEP_AFTER = "step-after"
    BASIS = "basis"
    BASIS_OPEN = "basis-open"
    BASIS_CLOSED = "basis-closed"
    CARDINAL = "cardinal"
    CARDINAL_OPEN = "cardinal-open"
    CARDINAL_CLOSED = "cardinal-closed"
    BUNDLE = "bundle"
    MONOTONE = "monotone"


class Orient(Enum):
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    HORIZONTAL = "horizontal"
    VERTICAL = "vertical"


@dataclass
class MarkConfig:
    """Area-Specific Config
    
    Circle-Specific Config
    
    Geoshape-Specific Config
    
    Line-Specific Config
    
    Mark Config
    
    Point-Specific Config
    
    Rect-Specific Config
    
    Rule-Specific Config
    
    Square-Specific Config
    """
    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    color: str | None = None
    """Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    will override `color`.
    
    __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    filled: bool | None = None
    """Whether the mark's color should be used as fill color instead of stroke color.
    
    __Default value:__ `true` for all marks except `point` and `false` for `point`.
    
    __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """

    @staticmethod
    def from_dict(obj: Any) -> 'MarkConfig':
        assert isinstance(obj, dict)
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        color = from_union([from_str, from_none], obj.get("color"))
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        filled = from_union([from_bool, from_none], obj.get("filled"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        return MarkConfig(align, angle, baseline, color, cursor, dx, dy, fill, filled, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, tension, text, theta)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.filled is not None:
            result["filled"] = from_union([from_bool, from_none], self.filled)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        return result


class LabelOverlapEnum(Enum):
    PARITY = "parity"
    GREEDY = "greedy"


@dataclass
class AxisConfig:
    """Axis configuration, which determines default properties for all `x` and `y`
    [axes](axis.html). For a full list of axis configuration options, please see the
    [corresponding section of the axis documentation](axis.html#config).
    """
    band_position: float | None = None
    """An interpolation fraction indicating where, for `band` scales, axis ticks should be
    positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    places ticks in the middle of their bands.
    """
    domain: bool | None = None
    """A boolean flag indicating if the domain (the axis baseline) should be included as part of
    the axis.
    
    __Default value:__ `true`
    """
    domain_color: str | None = None
    """Color of axis domain line.
    
    __Default value:__  (none, using Vega default).
    """
    domain_width: float | None = None
    """Stroke width of axis domain line
    
    __Default value:__  (none, using Vega default).
    """
    grid: bool | None = None
    """A boolean flag indicating if grid lines should be included as part of the axis
    
    __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    binned; otherwise, `false`.
    """
    grid_color: str | None = None
    """Color of gridlines."""

    grid_dash: list[float] | None = None
    """The offset (in pixels) into which to begin drawing with the grid dash array."""

    grid_opacity: float | None = None
    """The stroke opacity of grid (value between [0,1])
    
    __Default value:__ (`1` by default)
    """
    grid_width: float | None = None
    """The grid width, in pixels."""

    label_angle: float | None = None
    """The rotation angle of the axis labels.
    
    __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    """
    label_bound: float | bool | None = None
    """Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    they exceed the axis range by more than 1 pixel. If this property is a number, it
    specifies the pixel tolerance: the maximum amount by which a label bounding box may
    exceed the axis range.
    
    __Default value:__ `false`.
    """
    label_color: str | None = None
    """The color of the tick label, can be in hex color code or regular color name."""

    label_flush: float | bool | None = None
    """Indicates if the first and last axis labels should be aligned flush with the scale range.
    Flush alignment for a horizontal axis will left-align the first label and right-align the
    last label. For vertical axes, bottom and top text baselines are applied instead. If this
    property is a number, it also indicates the number of pixels by which to offset the first
    and last labels; for example, a value of 2 will flush-align the first and last labels and
    also push them 2 pixels outward from the center of the axis. The additional adjustment
    can sometimes help the labels better visually group with corresponding axis ticks.
    
    __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    """
    label_font: str | None = None
    """The font of the tick label."""

    label_font_size: float | None = None
    """The font size of the label, in pixels."""

    label_limit: float | None = None
    """Maximum allowed pixel width of axis tick labels."""

    label_overlap: bool | LabelOverlapEnum | None = None
    """The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    every other label is used (this works well for standard linear axes). If set to
    `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    with the last visible label (this often works better for log-scaled axes).
    
    __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    scales; otherwise `false`.
    """
    label_padding: float | None = None
    """The padding, in pixels, between axis and text labels."""

    labels: bool | None = None
    """A boolean flag indicating if labels should be included as part of the axis.
    
    __Default value:__  `true`.
    """
    max_extent: float | None = None
    """The maximum extent in pixels that axis ticks and labels should use. This determines a
    maximum offset value for axis titles.
    
    __Default value:__ `undefined`.
    """
    min_extent: float | None = None
    """The minimum extent in pixels that axis ticks and labels should use. This determines a
    minimum offset value for axis titles.
    
    __Default value:__ `30` for y-axis; `undefined` for x-axis.
    """
    short_time_labels: bool | None = None
    """Whether month names and weekday names should be abbreviated.
    
    __Default value:__  `false`
    """
    tick_color: str | None = None
    """The color of the axis's tick."""

    tick_round: bool | None = None
    """Boolean flag indicating if pixel position values should be rounded to the nearest integer."""

    ticks: bool | None = None
    """Boolean value that determines whether the axis should include ticks."""

    tick_size: float | None = None
    """The size in pixels of axis ticks."""

    tick_width: float | None = None
    """The width, in pixels, of ticks."""

    title_align: str | None = None
    """Horizontal text alignment of axis titles."""

    title_angle: float | None = None
    """Angle in degrees of axis titles."""

    title_baseline: str | None = None
    """Vertical text baseline for axis titles."""

    title_color: str | None = None
    """Color of the title, can be in hex color code or regular color name."""

    title_font: str | None = None
    """Font of the title. (e.g., `"Helvetica Neue"`)."""

    title_font_size: float | None = None
    """Font size of the title."""

    title_font_weight: float | str | None = None
    """Font weight of the title. (e.g., `"bold"`)."""

    title_limit: float | None = None
    """Maximum allowed pixel width of axis titles."""

    title_max_length: float | None = None
    """Max length for axis title if the title is automatically generated from the field's
    description.
    """
    title_padding: float | None = None
    """The padding, in pixels, between title and axis."""

    title_x: float | None = None
    """X-coordinate of the axis title relative to the axis group."""

    title_y: float | None = None
    """Y-coordinate of the axis title relative to the axis group."""

    @staticmethod
    def from_dict(obj: Any) -> 'AxisConfig':
        assert isinstance(obj, dict)
        band_position = from_union([from_float, from_none], obj.get("bandPosition"))
        domain = from_union([from_bool, from_none], obj.get("domain"))
        domain_color = from_union([from_str, from_none], obj.get("domainColor"))
        domain_width = from_union([from_float, from_none], obj.get("domainWidth"))
        grid = from_union([from_bool, from_none], obj.get("grid"))
        grid_color = from_union([from_str, from_none], obj.get("gridColor"))
        grid_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("gridDash"))
        grid_opacity = from_union([from_float, from_none], obj.get("gridOpacity"))
        assert grid_opacity is None or 0 <= grid_opacity
        assert grid_opacity is None or grid_opacity <= 1
        grid_width = from_union([from_float, from_none], obj.get("gridWidth"))
        assert grid_width is None or 0 <= grid_width
        label_angle = from_union([from_float, from_none], obj.get("labelAngle"))
        assert label_angle is None or -360 <= label_angle
        assert label_angle is None or label_angle <= 360
        label_bound = from_union([from_float, from_bool, from_none], obj.get("labelBound"))
        label_color = from_union([from_str, from_none], obj.get("labelColor"))
        label_flush = from_union([from_float, from_bool, from_none], obj.get("labelFlush"))
        label_font = from_union([from_str, from_none], obj.get("labelFont"))
        label_font_size = from_union([from_float, from_none], obj.get("labelFontSize"))
        assert label_font_size is None or 0 <= label_font_size
        label_limit = from_union([from_float, from_none], obj.get("labelLimit"))
        label_overlap = from_union([from_bool, LabelOverlapEnum, from_none], obj.get("labelOverlap"))
        label_padding = from_union([from_float, from_none], obj.get("labelPadding"))
        labels = from_union([from_bool, from_none], obj.get("labels"))
        max_extent = from_union([from_float, from_none], obj.get("maxExtent"))
        min_extent = from_union([from_float, from_none], obj.get("minExtent"))
        short_time_labels = from_union([from_bool, from_none], obj.get("shortTimeLabels"))
        tick_color = from_union([from_str, from_none], obj.get("tickColor"))
        tick_round = from_union([from_bool, from_none], obj.get("tickRound"))
        ticks = from_union([from_bool, from_none], obj.get("ticks"))
        tick_size = from_union([from_float, from_none], obj.get("tickSize"))
        assert tick_size is None or 0 <= tick_size
        tick_width = from_union([from_float, from_none], obj.get("tickWidth"))
        assert tick_width is None or 0 <= tick_width
        title_align = from_union([from_str, from_none], obj.get("titleAlign"))
        title_angle = from_union([from_float, from_none], obj.get("titleAngle"))
        title_baseline = from_union([from_str, from_none], obj.get("titleBaseline"))
        title_color = from_union([from_str, from_none], obj.get("titleColor"))
        title_font = from_union([from_str, from_none], obj.get("titleFont"))
        title_font_size = from_union([from_float, from_none], obj.get("titleFontSize"))
        assert title_font_size is None or 0 <= title_font_size
        title_font_weight = from_union([from_float, from_str, from_none], obj.get("titleFontWeight"))
        title_limit = from_union([from_float, from_none], obj.get("titleLimit"))
        title_max_length = from_union([from_float, from_none], obj.get("titleMaxLength"))
        title_padding = from_union([from_float, from_none], obj.get("titlePadding"))
        title_x = from_union([from_float, from_none], obj.get("titleX"))
        title_y = from_union([from_float, from_none], obj.get("titleY"))
        return AxisConfig(band_position, domain, domain_color, domain_width, grid, grid_color, grid_dash, grid_opacity, grid_width, label_angle, label_bound, label_color, label_flush, label_font, label_font_size, label_limit, label_overlap, label_padding, labels, max_extent, min_extent, short_time_labels, tick_color, tick_round, ticks, tick_size, tick_width, title_align, title_angle, title_baseline, title_color, title_font, title_font_size, title_font_weight, title_limit, title_max_length, title_padding, title_x, title_y)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.band_position is not None:
            result["bandPosition"] = from_union([to_float, from_none], self.band_position)
        if self.domain is not None:
            result["domain"] = from_union([from_bool, from_none], self.domain)
        if self.domain_color is not None:
            result["domainColor"] = from_union([from_str, from_none], self.domain_color)
        if self.domain_width is not None:
            result["domainWidth"] = from_union([to_float, from_none], self.domain_width)
        if self.grid is not None:
            result["grid"] = from_union([from_bool, from_none], self.grid)
        if self.grid_color is not None:
            result["gridColor"] = from_union([from_str, from_none], self.grid_color)
        if self.grid_dash is not None:
            result["gridDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.grid_dash)
        if self.grid_opacity is not None:
            result["gridOpacity"] = from_union([to_float, from_none], self.grid_opacity)
        if self.grid_width is not None:
            result["gridWidth"] = from_union([to_float, from_none], self.grid_width)
        if self.label_angle is not None:
            result["labelAngle"] = from_union([to_float, from_none], self.label_angle)
        if self.label_bound is not None:
            result["labelBound"] = from_union([to_float, from_bool, from_none], self.label_bound)
        if self.label_color is not None:
            result["labelColor"] = from_union([from_str, from_none], self.label_color)
        if self.label_flush is not None:
            result["labelFlush"] = from_union([to_float, from_bool, from_none], self.label_flush)
        if self.label_font is not None:
            result["labelFont"] = from_union([from_str, from_none], self.label_font)
        if self.label_font_size is not None:
            result["labelFontSize"] = from_union([to_float, from_none], self.label_font_size)
        if self.label_limit is not None:
            result["labelLimit"] = from_union([to_float, from_none], self.label_limit)
        if self.label_overlap is not None:
            result["labelOverlap"] = from_union([from_bool, lambda x: to_enum(LabelOverlapEnum, x), from_none], self.label_overlap)
        if self.label_padding is not None:
            result["labelPadding"] = from_union([to_float, from_none], self.label_padding)
        if self.labels is not None:
            result["labels"] = from_union([from_bool, from_none], self.labels)
        if self.max_extent is not None:
            result["maxExtent"] = from_union([to_float, from_none], self.max_extent)
        if self.min_extent is not None:
            result["minExtent"] = from_union([to_float, from_none], self.min_extent)
        if self.short_time_labels is not None:
            result["shortTimeLabels"] = from_union([from_bool, from_none], self.short_time_labels)
        if self.tick_color is not None:
            result["tickColor"] = from_union([from_str, from_none], self.tick_color)
        if self.tick_round is not None:
            result["tickRound"] = from_union([from_bool, from_none], self.tick_round)
        if self.ticks is not None:
            result["ticks"] = from_union([from_bool, from_none], self.ticks)
        if self.tick_size is not None:
            result["tickSize"] = from_union([to_float, from_none], self.tick_size)
        if self.tick_width is not None:
            result["tickWidth"] = from_union([to_float, from_none], self.tick_width)
        if self.title_align is not None:
            result["titleAlign"] = from_union([from_str, from_none], self.title_align)
        if self.title_angle is not None:
            result["titleAngle"] = from_union([to_float, from_none], self.title_angle)
        if self.title_baseline is not None:
            result["titleBaseline"] = from_union([from_str, from_none], self.title_baseline)
        if self.title_color is not None:
            result["titleColor"] = from_union([from_str, from_none], self.title_color)
        if self.title_font is not None:
            result["titleFont"] = from_union([from_str, from_none], self.title_font)
        if self.title_font_size is not None:
            result["titleFontSize"] = from_union([to_float, from_none], self.title_font_size)
        if self.title_font_weight is not None:
            result["titleFontWeight"] = from_union([to_float, from_str, from_none], self.title_font_weight)
        if self.title_limit is not None:
            result["titleLimit"] = from_union([to_float, from_none], self.title_limit)
        if self.title_max_length is not None:
            result["titleMaxLength"] = from_union([to_float, from_none], self.title_max_length)
        if self.title_padding is not None:
            result["titlePadding"] = from_union([to_float, from_none], self.title_padding)
        if self.title_x is not None:
            result["titleX"] = from_union([to_float, from_none], self.title_x)
        if self.title_y is not None:
            result["titleY"] = from_union([to_float, from_none], self.title_y)
        return result


@dataclass
class VGAxisConfig:
    """Specific axis config for axes with "band" scales.
    
    Specific axis config for x-axis along the bottom edge of the chart.
    
    Specific axis config for y-axis along the left edge of the chart.
    
    Specific axis config for y-axis along the right edge of the chart.
    
    Specific axis config for x-axis along the top edge of the chart.
    
    X-axis specific config.
    
    Y-axis specific config.
    """
    band_position: float | None = None
    """An interpolation fraction indicating where, for `band` scales, axis ticks should be
    positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
    places ticks in the middle of their bands.
    """
    domain: bool | None = None
    """A boolean flag indicating if the domain (the axis baseline) should be included as part of
    the axis.
    
    __Default value:__ `true`
    """
    domain_color: str | None = None
    """Color of axis domain line.
    
    __Default value:__  (none, using Vega default).
    """
    domain_width: float | None = None
    """Stroke width of axis domain line
    
    __Default value:__  (none, using Vega default).
    """
    grid: bool | None = None
    """A boolean flag indicating if grid lines should be included as part of the axis
    
    __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    binned; otherwise, `false`.
    """
    grid_color: str | None = None
    """Color of gridlines."""

    grid_dash: list[float] | None = None
    """The offset (in pixels) into which to begin drawing with the grid dash array."""

    grid_opacity: float | None = None
    """The stroke opacity of grid (value between [0,1])
    
    __Default value:__ (`1` by default)
    """
    grid_width: float | None = None
    """The grid width, in pixels."""

    label_angle: float | None = None
    """The rotation angle of the axis labels.
    
    __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    """
    label_bound: float | bool | None = None
    """Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    they exceed the axis range by more than 1 pixel. If this property is a number, it
    specifies the pixel tolerance: the maximum amount by which a label bounding box may
    exceed the axis range.
    
    __Default value:__ `false`.
    """
    label_color: str | None = None
    """The color of the tick label, can be in hex color code or regular color name."""

    label_flush: float | bool | None = None
    """Indicates if the first and last axis labels should be aligned flush with the scale range.
    Flush alignment for a horizontal axis will left-align the first label and right-align the
    last label. For vertical axes, bottom and top text baselines are applied instead. If this
    property is a number, it also indicates the number of pixels by which to offset the first
    and last labels; for example, a value of 2 will flush-align the first and last labels and
    also push them 2 pixels outward from the center of the axis. The additional adjustment
    can sometimes help the labels better visually group with corresponding axis ticks.
    
    __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    """
    label_font: str | None = None
    """The font of the tick label."""

    label_font_size: float | None = None
    """The font size of the label, in pixels."""

    label_limit: float | None = None
    """Maximum allowed pixel width of axis tick labels."""

    label_overlap: bool | LabelOverlapEnum | None = None
    """The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    every other label is used (this works well for standard linear axes). If set to
    `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    with the last visible label (this often works better for log-scaled axes).
    
    __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    scales; otherwise `false`.
    """
    label_padding: float | None = None
    """The padding, in pixels, between axis and text labels."""

    labels: bool | None = None
    """A boolean flag indicating if labels should be included as part of the axis.
    
    __Default value:__  `true`.
    """
    max_extent: float | None = None
    """The maximum extent in pixels that axis ticks and labels should use. This determines a
    maximum offset value for axis titles.
    
    __Default value:__ `undefined`.
    """
    min_extent: float | None = None
    """The minimum extent in pixels that axis ticks and labels should use. This determines a
    minimum offset value for axis titles.
    
    __Default value:__ `30` for y-axis; `undefined` for x-axis.
    """
    tick_color: str | None = None
    """The color of the axis's tick."""

    tick_round: bool | None = None
    """Boolean flag indicating if pixel position values should be rounded to the nearest integer."""

    ticks: bool | None = None
    """Boolean value that determines whether the axis should include ticks."""

    tick_size: float | None = None
    """The size in pixels of axis ticks."""

    tick_width: float | None = None
    """The width, in pixels, of ticks."""

    title_align: str | None = None
    """Horizontal text alignment of axis titles."""

    title_angle: float | None = None
    """Angle in degrees of axis titles."""

    title_baseline: str | None = None
    """Vertical text baseline for axis titles."""

    title_color: str | None = None
    """Color of the title, can be in hex color code or regular color name."""

    title_font: str | None = None
    """Font of the title. (e.g., `"Helvetica Neue"`)."""

    title_font_size: float | None = None
    """Font size of the title."""

    title_font_weight: float | str | None = None
    """Font weight of the title. (e.g., `"bold"`)."""

    title_limit: float | None = None
    """Maximum allowed pixel width of axis titles."""

    title_max_length: float | None = None
    """Max length for axis title if the title is automatically generated from the field's
    description.
    """
    title_padding: float | None = None
    """The padding, in pixels, between title and axis."""

    title_x: float | None = None
    """X-coordinate of the axis title relative to the axis group."""

    title_y: float | None = None
    """Y-coordinate of the axis title relative to the axis group."""

    @staticmethod
    def from_dict(obj: Any) -> 'VGAxisConfig':
        assert isinstance(obj, dict)
        band_position = from_union([from_float, from_none], obj.get("bandPosition"))
        domain = from_union([from_bool, from_none], obj.get("domain"))
        domain_color = from_union([from_str, from_none], obj.get("domainColor"))
        domain_width = from_union([from_float, from_none], obj.get("domainWidth"))
        grid = from_union([from_bool, from_none], obj.get("grid"))
        grid_color = from_union([from_str, from_none], obj.get("gridColor"))
        grid_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("gridDash"))
        grid_opacity = from_union([from_float, from_none], obj.get("gridOpacity"))
        assert grid_opacity is None or 0 <= grid_opacity
        assert grid_opacity is None or grid_opacity <= 1
        grid_width = from_union([from_float, from_none], obj.get("gridWidth"))
        assert grid_width is None or 0 <= grid_width
        label_angle = from_union([from_float, from_none], obj.get("labelAngle"))
        assert label_angle is None or -360 <= label_angle
        assert label_angle is None or label_angle <= 360
        label_bound = from_union([from_float, from_bool, from_none], obj.get("labelBound"))
        label_color = from_union([from_str, from_none], obj.get("labelColor"))
        label_flush = from_union([from_float, from_bool, from_none], obj.get("labelFlush"))
        label_font = from_union([from_str, from_none], obj.get("labelFont"))
        label_font_size = from_union([from_float, from_none], obj.get("labelFontSize"))
        assert label_font_size is None or 0 <= label_font_size
        label_limit = from_union([from_float, from_none], obj.get("labelLimit"))
        label_overlap = from_union([from_bool, LabelOverlapEnum, from_none], obj.get("labelOverlap"))
        label_padding = from_union([from_float, from_none], obj.get("labelPadding"))
        labels = from_union([from_bool, from_none], obj.get("labels"))
        max_extent = from_union([from_float, from_none], obj.get("maxExtent"))
        min_extent = from_union([from_float, from_none], obj.get("minExtent"))
        tick_color = from_union([from_str, from_none], obj.get("tickColor"))
        tick_round = from_union([from_bool, from_none], obj.get("tickRound"))
        ticks = from_union([from_bool, from_none], obj.get("ticks"))
        tick_size = from_union([from_float, from_none], obj.get("tickSize"))
        assert tick_size is None or 0 <= tick_size
        tick_width = from_union([from_float, from_none], obj.get("tickWidth"))
        assert tick_width is None or 0 <= tick_width
        title_align = from_union([from_str, from_none], obj.get("titleAlign"))
        title_angle = from_union([from_float, from_none], obj.get("titleAngle"))
        title_baseline = from_union([from_str, from_none], obj.get("titleBaseline"))
        title_color = from_union([from_str, from_none], obj.get("titleColor"))
        title_font = from_union([from_str, from_none], obj.get("titleFont"))
        title_font_size = from_union([from_float, from_none], obj.get("titleFontSize"))
        assert title_font_size is None or 0 <= title_font_size
        title_font_weight = from_union([from_float, from_str, from_none], obj.get("titleFontWeight"))
        title_limit = from_union([from_float, from_none], obj.get("titleLimit"))
        title_max_length = from_union([from_float, from_none], obj.get("titleMaxLength"))
        title_padding = from_union([from_float, from_none], obj.get("titlePadding"))
        title_x = from_union([from_float, from_none], obj.get("titleX"))
        title_y = from_union([from_float, from_none], obj.get("titleY"))
        return VGAxisConfig(band_position, domain, domain_color, domain_width, grid, grid_color, grid_dash, grid_opacity, grid_width, label_angle, label_bound, label_color, label_flush, label_font, label_font_size, label_limit, label_overlap, label_padding, labels, max_extent, min_extent, tick_color, tick_round, ticks, tick_size, tick_width, title_align, title_angle, title_baseline, title_color, title_font, title_font_size, title_font_weight, title_limit, title_max_length, title_padding, title_x, title_y)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.band_position is not None:
            result["bandPosition"] = from_union([to_float, from_none], self.band_position)
        if self.domain is not None:
            result["domain"] = from_union([from_bool, from_none], self.domain)
        if self.domain_color is not None:
            result["domainColor"] = from_union([from_str, from_none], self.domain_color)
        if self.domain_width is not None:
            result["domainWidth"] = from_union([to_float, from_none], self.domain_width)
        if self.grid is not None:
            result["grid"] = from_union([from_bool, from_none], self.grid)
        if self.grid_color is not None:
            result["gridColor"] = from_union([from_str, from_none], self.grid_color)
        if self.grid_dash is not None:
            result["gridDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.grid_dash)
        if self.grid_opacity is not None:
            result["gridOpacity"] = from_union([to_float, from_none], self.grid_opacity)
        if self.grid_width is not None:
            result["gridWidth"] = from_union([to_float, from_none], self.grid_width)
        if self.label_angle is not None:
            result["labelAngle"] = from_union([to_float, from_none], self.label_angle)
        if self.label_bound is not None:
            result["labelBound"] = from_union([to_float, from_bool, from_none], self.label_bound)
        if self.label_color is not None:
            result["labelColor"] = from_union([from_str, from_none], self.label_color)
        if self.label_flush is not None:
            result["labelFlush"] = from_union([to_float, from_bool, from_none], self.label_flush)
        if self.label_font is not None:
            result["labelFont"] = from_union([from_str, from_none], self.label_font)
        if self.label_font_size is not None:
            result["labelFontSize"] = from_union([to_float, from_none], self.label_font_size)
        if self.label_limit is not None:
            result["labelLimit"] = from_union([to_float, from_none], self.label_limit)
        if self.label_overlap is not None:
            result["labelOverlap"] = from_union([from_bool, lambda x: to_enum(LabelOverlapEnum, x), from_none], self.label_overlap)
        if self.label_padding is not None:
            result["labelPadding"] = from_union([to_float, from_none], self.label_padding)
        if self.labels is not None:
            result["labels"] = from_union([from_bool, from_none], self.labels)
        if self.max_extent is not None:
            result["maxExtent"] = from_union([to_float, from_none], self.max_extent)
        if self.min_extent is not None:
            result["minExtent"] = from_union([to_float, from_none], self.min_extent)
        if self.tick_color is not None:
            result["tickColor"] = from_union([from_str, from_none], self.tick_color)
        if self.tick_round is not None:
            result["tickRound"] = from_union([from_bool, from_none], self.tick_round)
        if self.ticks is not None:
            result["ticks"] = from_union([from_bool, from_none], self.ticks)
        if self.tick_size is not None:
            result["tickSize"] = from_union([to_float, from_none], self.tick_size)
        if self.tick_width is not None:
            result["tickWidth"] = from_union([to_float, from_none], self.tick_width)
        if self.title_align is not None:
            result["titleAlign"] = from_union([from_str, from_none], self.title_align)
        if self.title_angle is not None:
            result["titleAngle"] = from_union([to_float, from_none], self.title_angle)
        if self.title_baseline is not None:
            result["titleBaseline"] = from_union([from_str, from_none], self.title_baseline)
        if self.title_color is not None:
            result["titleColor"] = from_union([from_str, from_none], self.title_color)
        if self.title_font is not None:
            result["titleFont"] = from_union([from_str, from_none], self.title_font)
        if self.title_font_size is not None:
            result["titleFontSize"] = from_union([to_float, from_none], self.title_font_size)
        if self.title_font_weight is not None:
            result["titleFontWeight"] = from_union([to_float, from_str, from_none], self.title_font_weight)
        if self.title_limit is not None:
            result["titleLimit"] = from_union([to_float, from_none], self.title_limit)
        if self.title_max_length is not None:
            result["titleMaxLength"] = from_union([to_float, from_none], self.title_max_length)
        if self.title_padding is not None:
            result["titlePadding"] = from_union([to_float, from_none], self.title_padding)
        if self.title_x is not None:
            result["titleX"] = from_union([to_float, from_none], self.title_x)
        if self.title_y is not None:
            result["titleY"] = from_union([to_float, from_none], self.title_y)
        return result


@dataclass
class BarConfig:
    """Bar-Specific Config"""

    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    bin_spacing: float | None = None
    """Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
    statisticians) or 1 (Vega-Lite Default, D3 example style).
    
    __Default value:__ `1`
    """
    color: str | None = None
    """Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    will override `color`.
    
    __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    continuous_band_size: float | None = None
    """The default size of the bars on continuous scales.
    
    __Default value:__ `5`
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    discrete_band_size: float | None = None
    """The size of the bars.  If unspecified, the default size is  `bandSize-1`,
    which provides 1 pixel offset between bars.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    filled: bool | None = None
    """Whether the mark's color should be used as fill color instead of stroke color.
    
    __Default value:__ `true` for all marks except `point` and `false` for `point`.
    
    __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """

    @staticmethod
    def from_dict(obj: Any) -> 'BarConfig':
        assert isinstance(obj, dict)
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        bin_spacing = from_union([from_float, from_none], obj.get("binSpacing"))
        assert bin_spacing is None or 0 <= bin_spacing
        color = from_union([from_str, from_none], obj.get("color"))
        continuous_band_size = from_union([from_float, from_none], obj.get("continuousBandSize"))
        assert continuous_band_size is None or 0 <= continuous_band_size
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        discrete_band_size = from_union([from_float, from_none], obj.get("discreteBandSize"))
        assert discrete_band_size is None or 0 <= discrete_band_size
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        filled = from_union([from_bool, from_none], obj.get("filled"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        return BarConfig(align, angle, baseline, bin_spacing, color, continuous_band_size, cursor, discrete_band_size, dx, dy, fill, filled, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, tension, text, theta)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.bin_spacing is not None:
            result["binSpacing"] = from_union([to_float, from_none], self.bin_spacing)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.continuous_band_size is not None:
            result["continuousBandSize"] = from_union([to_float, from_none], self.continuous_band_size)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.discrete_band_size is not None:
            result["discreteBandSize"] = from_union([to_float, from_none], self.discrete_band_size)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.filled is not None:
            result["filled"] = from_union([from_bool, from_none], self.filled)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        return result


class FieldTitle(Enum):
    """Defines how Vega-Lite generates title for fields.  There are three possible styles:
    
    - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
    "Year-month of date", "field (binned)").
    - `"function"` - displays function using parentheses and capitalized texts (e.g.,
    "SUM(field)", "YEARMONTH(date)", "BIN(field)").
    - `"plain"` - displays only the field name without functions (e.g., "field", "date",
    "field").
    """
    VERBAL = "verbal"
    FUNCTIONAL = "functional"
    PLAIN = "plain"


class InvalidValues(Enum):
    """Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
    - If set to `"filter"` (default), all data items with null values are filtered.
    - If `null`, all data items are included. In this case, invalid values will be
    interpreted as zeroes.
    """
    FILTER = "filter"


class LegendOrient(Enum):
    """The orientation of the legend, which determines how the legend is positioned within the
    scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    "none".
    
    __Default value:__ `"right"`
    """
    LEFT = "left"
    RIGHT = "right"
    TOP_LEFT = "top-left"
    TOP_RIGHT = "top-right"
    BOTTOM_LEFT = "bottom-left"
    BOTTOM_RIGHT = "bottom-right"
    NONE = "none"


@dataclass
class LegendConfig:
    """Legend configuration, which determines default properties for all [legends](legend.html).
    For a full list of legend configuration options, please see the [corresponding section of
    in the legend documentation](legend.html#config).
    """
    corner_radius: float | None = None
    """Corner radius for the full legend."""

    entry_padding: float | None = None
    """Padding (in pixels) between legend entries in a symbol legend."""

    fill_color: str | None = None
    """Background fill color for the full legend."""

    gradient_height: float | None = None
    """The height of the gradient, in pixels."""

    gradient_label_baseline: str | None = None
    """Text baseline for color ramp gradient labels."""

    gradient_label_limit: float | None = None
    """The maximum allowed length in pixels of color ramp gradient labels."""

    gradient_label_offset: float | None = None
    """Vertical offset in pixels for color ramp gradient labels."""

    gradient_stroke_color: str | None = None
    """The color of the gradient stroke, can be in hex color code or regular color name."""

    gradient_stroke_width: float | None = None
    """The width of the gradient stroke, in pixels."""

    gradient_width: float | None = None
    """The width of the gradient, in pixels."""

    label_align: str | None = None
    """The alignment of the legend label, can be left, middle or right."""

    label_baseline: str | None = None
    """The position of the baseline of legend label, can be top, middle or bottom."""

    label_color: str | None = None
    """The color of the legend label, can be in hex color code or regular color name."""

    label_font: str | None = None
    """The font of the legend label."""

    label_font_size: float | None = None
    """The font size of legend label.
    
    __Default value:__ `10`.
    """
    label_limit: float | None = None
    """Maximum allowed pixel width of axis tick labels."""

    label_offset: float | None = None
    """The offset of the legend label."""

    offset: float | None = None
    """The offset, in pixels, by which to displace the legend from the edge of the enclosing
    group or data rectangle.
    
    __Default value:__  `0`
    """
    orient: LegendOrient | None = None
    """The orientation of the legend, which determines how the legend is positioned within the
    scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    "none".
    
    __Default value:__ `"right"`
    """
    padding: float | None = None
    """The padding, in pixels, between the legend and axis."""

    short_time_labels: bool | None = None
    """Whether month names and weekday names should be abbreviated.
    
    __Default value:__  `false`
    """
    stroke_color: str | None = None
    """Border stroke color for the full legend."""

    stroke_dash: list[float] | None = None
    """Border stroke dash pattern for the full legend."""

    stroke_width: float | None = None
    """Border stroke width for the full legend."""

    symbol_color: str | None = None
    """The color of the legend symbol,"""

    symbol_size: float | None = None
    """The size of the legend symbol, in pixels."""

    symbol_stroke_width: float | None = None
    """The width of the symbol's stroke."""

    symbol_type: str | None = None
    """Default shape type (such as "circle") for legend symbols."""

    title_align: str | None = None
    """Horizontal text alignment for legend titles."""

    title_baseline: str | None = None
    """Vertical text baseline for legend titles."""

    title_color: str | None = None
    """The color of the legend title, can be in hex color code or regular color name."""

    title_font: str | None = None
    """The font of the legend title."""

    title_font_size: float | None = None
    """The font size of the legend title."""

    title_font_weight: float | str | None = None
    """The font weight of the legend title."""

    title_limit: float | None = None
    """Maximum allowed pixel width of axis titles."""

    title_padding: float | None = None
    """The padding, in pixels, between title and legend."""

    @staticmethod
    def from_dict(obj: Any) -> 'LegendConfig':
        assert isinstance(obj, dict)
        corner_radius = from_union([from_float, from_none], obj.get("cornerRadius"))
        entry_padding = from_union([from_float, from_none], obj.get("entryPadding"))
        fill_color = from_union([from_str, from_none], obj.get("fillColor"))
        gradient_height = from_union([from_float, from_none], obj.get("gradientHeight"))
        assert gradient_height is None or 0 <= gradient_height
        gradient_label_baseline = from_union([from_str, from_none], obj.get("gradientLabelBaseline"))
        gradient_label_limit = from_union([from_float, from_none], obj.get("gradientLabelLimit"))
        gradient_label_offset = from_union([from_float, from_none], obj.get("gradientLabelOffset"))
        gradient_stroke_color = from_union([from_str, from_none], obj.get("gradientStrokeColor"))
        gradient_stroke_width = from_union([from_float, from_none], obj.get("gradientStrokeWidth"))
        assert gradient_stroke_width is None or 0 <= gradient_stroke_width
        gradient_width = from_union([from_float, from_none], obj.get("gradientWidth"))
        assert gradient_width is None or 0 <= gradient_width
        label_align = from_union([from_str, from_none], obj.get("labelAlign"))
        label_baseline = from_union([from_str, from_none], obj.get("labelBaseline"))
        label_color = from_union([from_str, from_none], obj.get("labelColor"))
        label_font = from_union([from_str, from_none], obj.get("labelFont"))
        label_font_size = from_union([from_float, from_none], obj.get("labelFontSize"))
        assert label_font_size is None or 0 <= label_font_size
        label_limit = from_union([from_float, from_none], obj.get("labelLimit"))
        label_offset = from_union([from_float, from_none], obj.get("labelOffset"))
        assert label_offset is None or 0 <= label_offset
        offset = from_union([from_float, from_none], obj.get("offset"))
        orient = from_union([LegendOrient, from_none], obj.get("orient"))
        padding = from_union([from_float, from_none], obj.get("padding"))
        short_time_labels = from_union([from_bool, from_none], obj.get("shortTimeLabels"))
        stroke_color = from_union([from_str, from_none], obj.get("strokeColor"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        symbol_color = from_union([from_str, from_none], obj.get("symbolColor"))
        symbol_size = from_union([from_float, from_none], obj.get("symbolSize"))
        assert symbol_size is None or 0 <= symbol_size
        symbol_stroke_width = from_union([from_float, from_none], obj.get("symbolStrokeWidth"))
        assert symbol_stroke_width is None or 0 <= symbol_stroke_width
        symbol_type = from_union([from_str, from_none], obj.get("symbolType"))
        title_align = from_union([from_str, from_none], obj.get("titleAlign"))
        title_baseline = from_union([from_str, from_none], obj.get("titleBaseline"))
        title_color = from_union([from_str, from_none], obj.get("titleColor"))
        title_font = from_union([from_str, from_none], obj.get("titleFont"))
        title_font_size = from_union([from_float, from_none], obj.get("titleFontSize"))
        title_font_weight = from_union([from_float, from_str, from_none], obj.get("titleFontWeight"))
        title_limit = from_union([from_float, from_none], obj.get("titleLimit"))
        title_padding = from_union([from_float, from_none], obj.get("titlePadding"))
        return LegendConfig(corner_radius, entry_padding, fill_color, gradient_height, gradient_label_baseline, gradient_label_limit, gradient_label_offset, gradient_stroke_color, gradient_stroke_width, gradient_width, label_align, label_baseline, label_color, label_font, label_font_size, label_limit, label_offset, offset, orient, padding, short_time_labels, stroke_color, stroke_dash, stroke_width, symbol_color, symbol_size, symbol_stroke_width, symbol_type, title_align, title_baseline, title_color, title_font, title_font_size, title_font_weight, title_limit, title_padding)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.corner_radius is not None:
            result["cornerRadius"] = from_union([to_float, from_none], self.corner_radius)
        if self.entry_padding is not None:
            result["entryPadding"] = from_union([to_float, from_none], self.entry_padding)
        if self.fill_color is not None:
            result["fillColor"] = from_union([from_str, from_none], self.fill_color)
        if self.gradient_height is not None:
            result["gradientHeight"] = from_union([to_float, from_none], self.gradient_height)
        if self.gradient_label_baseline is not None:
            result["gradientLabelBaseline"] = from_union([from_str, from_none], self.gradient_label_baseline)
        if self.gradient_label_limit is not None:
            result["gradientLabelLimit"] = from_union([to_float, from_none], self.gradient_label_limit)
        if self.gradient_label_offset is not None:
            result["gradientLabelOffset"] = from_union([to_float, from_none], self.gradient_label_offset)
        if self.gradient_stroke_color is not None:
            result["gradientStrokeColor"] = from_union([from_str, from_none], self.gradient_stroke_color)
        if self.gradient_stroke_width is not None:
            result["gradientStrokeWidth"] = from_union([to_float, from_none], self.gradient_stroke_width)
        if self.gradient_width is not None:
            result["gradientWidth"] = from_union([to_float, from_none], self.gradient_width)
        if self.label_align is not None:
            result["labelAlign"] = from_union([from_str, from_none], self.label_align)
        if self.label_baseline is not None:
            result["labelBaseline"] = from_union([from_str, from_none], self.label_baseline)
        if self.label_color is not None:
            result["labelColor"] = from_union([from_str, from_none], self.label_color)
        if self.label_font is not None:
            result["labelFont"] = from_union([from_str, from_none], self.label_font)
        if self.label_font_size is not None:
            result["labelFontSize"] = from_union([to_float, from_none], self.label_font_size)
        if self.label_limit is not None:
            result["labelLimit"] = from_union([to_float, from_none], self.label_limit)
        if self.label_offset is not None:
            result["labelOffset"] = from_union([to_float, from_none], self.label_offset)
        if self.offset is not None:
            result["offset"] = from_union([to_float, from_none], self.offset)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(LegendOrient, x), from_none], self.orient)
        if self.padding is not None:
            result["padding"] = from_union([to_float, from_none], self.padding)
        if self.short_time_labels is not None:
            result["shortTimeLabels"] = from_union([from_bool, from_none], self.short_time_labels)
        if self.stroke_color is not None:
            result["strokeColor"] = from_union([from_str, from_none], self.stroke_color)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.symbol_color is not None:
            result["symbolColor"] = from_union([from_str, from_none], self.symbol_color)
        if self.symbol_size is not None:
            result["symbolSize"] = from_union([to_float, from_none], self.symbol_size)
        if self.symbol_stroke_width is not None:
            result["symbolStrokeWidth"] = from_union([to_float, from_none], self.symbol_stroke_width)
        if self.symbol_type is not None:
            result["symbolType"] = from_union([from_str, from_none], self.symbol_type)
        if self.title_align is not None:
            result["titleAlign"] = from_union([from_str, from_none], self.title_align)
        if self.title_baseline is not None:
            result["titleBaseline"] = from_union([from_str, from_none], self.title_baseline)
        if self.title_color is not None:
            result["titleColor"] = from_union([from_str, from_none], self.title_color)
        if self.title_font is not None:
            result["titleFont"] = from_union([from_str, from_none], self.title_font)
        if self.title_font_size is not None:
            result["titleFontSize"] = from_union([to_float, from_none], self.title_font_size)
        if self.title_font_weight is not None:
            result["titleFontWeight"] = from_union([to_float, from_str, from_none], self.title_font_weight)
        if self.title_limit is not None:
            result["titleLimit"] = from_union([to_float, from_none], self.title_limit)
        if self.title_padding is not None:
            result["titlePadding"] = from_union([to_float, from_none], self.title_padding)
        return result


@dataclass
class PaddingClass:
    bottom: float | None = None
    left: float | None = None
    right: float | None = None
    top: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'PaddingClass':
        assert isinstance(obj, dict)
        bottom = from_union([from_float, from_none], obj.get("bottom"))
        left = from_union([from_float, from_none], obj.get("left"))
        right = from_union([from_float, from_none], obj.get("right"))
        top = from_union([from_float, from_none], obj.get("top"))
        return PaddingClass(bottom, left, right, top)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bottom is not None:
            result["bottom"] = from_union([to_float, from_none], self.bottom)
        if self.left is not None:
            result["left"] = from_union([to_float, from_none], self.left)
        if self.right is not None:
            result["right"] = from_union([to_float, from_none], self.right)
        if self.top is not None:
            result["top"] = from_union([to_float, from_none], self.top)
        return result


class VGProjectionType(Enum):
    """The cartographic projection to use. This value is case-insensitive, for example
    `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    projection types [in the
    documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    
    __Default value:__ `mercator`
    """
    ALBERS = "albers"
    ALBERS_USA = "albersUsa"
    AZIMUTHAL_EQUAL_AREA = "azimuthalEqualArea"
    AZIMUTHAL_EQUIDISTANT = "azimuthalEquidistant"
    CONIC_CONFORMAL = "conicConformal"
    CONIC_EQUAL_AREA = "conicEqualArea"
    CONIC_EQUIDISTANT = "conicEquidistant"
    EQUIRECTANGULAR = "equirectangular"
    GNOMONIC = "gnomonic"
    MERCATOR = "mercator"
    ORTHOGRAPHIC = "orthographic"
    STEREOGRAPHIC = "stereographic"
    TRANSVERSE_MERCATOR = "transverseMercator"


@dataclass
class ProjectionConfig:
    """Projection configuration, which determines default properties for all
    [projections](projection.html). For a full list of projection configuration options,
    please see the [corresponding section of the projection
    documentation](projection.html#config).
    
    Any property of Projection can be in config
    """
    center: list[float] | None = None
    """Sets the projection’s center to the specified center, a two-element array of longitude
    and latitude in degrees.
    
    __Default value:__ `[0, 0]`
    """
    clip_angle: float | None = None
    """Sets the projection’s clipping circle radius to the specified angle in degrees. If
    `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    than small-circle clipping.
    """
    clip_extent: list[list[float]] | None = None
    """Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    viewport clipping is performed.
    """
    coefficient: float | None = None
    distance: float | None = None
    fraction: float | None = None
    lobes: float | None = None
    parallel: float | None = None
    precision: dict[str, float | str] | None = None
    """Sets the threshold for the projection’s [adaptive
    resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    value corresponds to the [Douglas–Peucker
    distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    If precision is not specified, returns the projection’s current resampling precision
    which defaults to `√0.5 ≅ 0.70710…`.
    """
    radius: float | None = None
    ratio: float | None = None
    rotate: list[float] | None = None
    """Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    
    __Default value:__ `[0, 0, 0]`
    """
    spacing: float | None = None
    tilt: float | None = None
    type: VGProjectionType | None = None
    """The cartographic projection to use. This value is case-insensitive, for example
    `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    projection types [in the
    documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    
    __Default value:__ `mercator`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ProjectionConfig':
        assert isinstance(obj, dict)
        center = from_union([lambda x: from_list(from_float, x), from_none], obj.get("center"))
        clip_angle = from_union([from_float, from_none], obj.get("clipAngle"))
        clip_extent = from_union([lambda x: from_list(lambda x: from_list(from_float, x), x), from_none], obj.get("clipExtent"))
        coefficient = from_union([from_float, from_none], obj.get("coefficient"))
        distance = from_union([from_float, from_none], obj.get("distance"))
        fraction = from_union([from_float, from_none], obj.get("fraction"))
        lobes = from_union([from_float, from_none], obj.get("lobes"))
        parallel = from_union([from_float, from_none], obj.get("parallel"))
        precision = from_union([lambda x: from_dict(lambda x: from_union([from_float, from_str], x), x), from_none], obj.get("precision"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        ratio = from_union([from_float, from_none], obj.get("ratio"))
        rotate = from_union([lambda x: from_list(from_float, x), from_none], obj.get("rotate"))
        spacing = from_union([from_float, from_none], obj.get("spacing"))
        tilt = from_union([from_float, from_none], obj.get("tilt"))
        type = from_union([VGProjectionType, from_none], obj.get("type"))
        return ProjectionConfig(center, clip_angle, clip_extent, coefficient, distance, fraction, lobes, parallel, precision, radius, ratio, rotate, spacing, tilt, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.center is not None:
            result["center"] = from_union([lambda x: from_list(to_float, x), from_none], self.center)
        if self.clip_angle is not None:
            result["clipAngle"] = from_union([to_float, from_none], self.clip_angle)
        if self.clip_extent is not None:
            result["clipExtent"] = from_union([lambda x: from_list(lambda x: from_list(to_float, x), x), from_none], self.clip_extent)
        if self.coefficient is not None:
            result["coefficient"] = from_union([to_float, from_none], self.coefficient)
        if self.distance is not None:
            result["distance"] = from_union([to_float, from_none], self.distance)
        if self.fraction is not None:
            result["fraction"] = from_union([to_float, from_none], self.fraction)
        if self.lobes is not None:
            result["lobes"] = from_union([to_float, from_none], self.lobes)
        if self.parallel is not None:
            result["parallel"] = from_union([to_float, from_none], self.parallel)
        if self.precision is not None:
            result["precision"] = from_union([lambda x: from_dict(lambda x: from_union([to_float, from_str], x), x), from_none], self.precision)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.ratio is not None:
            result["ratio"] = from_union([to_float, from_none], self.ratio)
        if self.rotate is not None:
            result["rotate"] = from_union([lambda x: from_list(to_float, x), from_none], self.rotate)
        if self.spacing is not None:
            result["spacing"] = from_union([to_float, from_none], self.spacing)
        if self.tilt is not None:
            result["tilt"] = from_union([to_float, from_none], self.tilt)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(VGProjectionType, x), from_none], self.type)
        return result


@dataclass
class VGScheme:
    count: float | None = None
    extent: list[float] | None = None
    scheme: str | None = None
    step: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'VGScheme':
        assert isinstance(obj, dict)
        count = from_union([from_float, from_none], obj.get("count"))
        extent = from_union([lambda x: from_list(from_float, x), from_none], obj.get("extent"))
        scheme = from_union([from_str, from_none], obj.get("scheme"))
        step = from_union([from_float, from_none], obj.get("step"))
        return VGScheme(count, extent, scheme, step)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.count is not None:
            result["count"] = from_union([to_float, from_none], self.count)
        if self.extent is not None:
            result["extent"] = from_union([lambda x: from_list(to_float, x), from_none], self.extent)
        if self.scheme is not None:
            result["scheme"] = from_union([from_str, from_none], self.scheme)
        if self.step is not None:
            result["step"] = from_union([to_float, from_none], self.step)
        return result


@dataclass
class ScaleConfig:
    """Scale configuration determines default properties for all [scales](scale.html). For a
    full list of scale configuration options, please see the [corresponding section of the
    scale documentation](scale.html#config).
    """
    band_padding_inner: float | None = None
    """Default inner padding for `x` and `y` band-ordinal scales.
    
    __Default value:__ `0.1`
    """
    band_padding_outer: float | None = None
    """Default outer padding for `x` and `y` band-ordinal scales.
    If not specified, by default, band scale's paddingOuter is paddingInner/2.
    """
    clamp: bool | None = None
    """If true, values that exceed the data domain are clamped to either the minimum or maximum
    range value
    """
    continuous_padding: float | None = None
    """Default padding for continuous scales.
    
    __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
    horizontal bar.; `0` otherwise.
    """
    max_band_size: float | None = None
    """The default max value for mapping quantitative fields to bar's size/bandSize.
    
    If undefined (default), we will use the scale's `rangeStep` - 1.
    """
    max_font_size: float | None = None
    """The default max value for mapping quantitative fields to text's size/fontSize.
    
    __Default value:__ `40`
    """
    max_opacity: float | None = None
    """Default max opacity for mapping a field to opacity.
    
    __Default value:__ `0.8`
    """
    max_size: float | None = None
    """Default max value for point size scale."""

    max_stroke_width: float | None = None
    """Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
    
    __Default value:__ `4`
    """
    min_band_size: float | None = None
    """The default min value for mapping quantitative fields to bar and tick's size/bandSize
    scale with zero=false.
    
    __Default value:__ `2`
    """
    min_font_size: float | None = None
    """The default min value for mapping quantitative fields to tick's size/fontSize scale with
    zero=false
    
    __Default value:__ `8`
    """
    min_opacity: float | None = None
    """Default minimum opacity for mapping a field to opacity.
    
    __Default value:__ `0.3`
    """
    min_size: float | None = None
    """Default minimum value for point size scale with zero=false.
    
    __Default value:__ `9`
    """
    min_stroke_width: float | None = None
    """Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
    
    __Default value:__ `1`
    """
    point_padding: float | None = None
    """Default outer padding for `x` and `y` point-ordinal scales.
    
    __Default value:__ `0.5`
    """
    range_step: float | None = None
    """Default range step for band and point scales of (1) the `y` channel
    and (2) the `x` channel when the mark is not `text`.
    
    __Default value:__ `21`
    """
    round: bool | None = None
    """If true, rounds numeric output values to integers.
    This can be helpful for snapping to the pixel grid.
    (Only available for `x`, `y`, and `size` scales.)
    """
    text_x_range_step: float | None = None
    """Default range step for `x` band and point scales of text marks.
    
    __Default value:__ `90`
    """
    use_unaggregated_domain: bool | None = None
    """Use the source data range before aggregation as scale domain instead of aggregated data
    for aggregate axis.
    
    This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
    fields by default.
    
    This property only works with aggregate functions that produce values within the raw data
    domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
    aggregations that produce values outside of the raw data domain (e.g. `"count"`,
    `"sum"`), this property is ignored.
    
    __Default value:__ `false`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ScaleConfig':
        assert isinstance(obj, dict)
        band_padding_inner = from_union([from_float, from_none], obj.get("bandPaddingInner"))
        assert band_padding_inner is None or 0 <= band_padding_inner
        assert band_padding_inner is None or band_padding_inner <= 1
        band_padding_outer = from_union([from_float, from_none], obj.get("bandPaddingOuter"))
        assert band_padding_outer is None or 0 <= band_padding_outer
        assert band_padding_outer is None or band_padding_outer <= 1
        clamp = from_union([from_bool, from_none], obj.get("clamp"))
        continuous_padding = from_union([from_float, from_none], obj.get("continuousPadding"))
        assert continuous_padding is None or 0 <= continuous_padding
        max_band_size = from_union([from_float, from_none], obj.get("maxBandSize"))
        assert max_band_size is None or 0 <= max_band_size
        max_font_size = from_union([from_float, from_none], obj.get("maxFontSize"))
        assert max_font_size is None or 0 <= max_font_size
        max_opacity = from_union([from_float, from_none], obj.get("maxOpacity"))
        assert max_opacity is None or 0 <= max_opacity
        assert max_opacity is None or max_opacity <= 1
        max_size = from_union([from_float, from_none], obj.get("maxSize"))
        assert max_size is None or 0 <= max_size
        max_stroke_width = from_union([from_float, from_none], obj.get("maxStrokeWidth"))
        assert max_stroke_width is None or 0 <= max_stroke_width
        min_band_size = from_union([from_float, from_none], obj.get("minBandSize"))
        assert min_band_size is None or 0 <= min_band_size
        min_font_size = from_union([from_float, from_none], obj.get("minFontSize"))
        assert min_font_size is None or 0 <= min_font_size
        min_opacity = from_union([from_float, from_none], obj.get("minOpacity"))
        assert min_opacity is None or 0 <= min_opacity
        assert min_opacity is None or min_opacity <= 1
        min_size = from_union([from_float, from_none], obj.get("minSize"))
        assert min_size is None or 0 <= min_size
        min_stroke_width = from_union([from_float, from_none], obj.get("minStrokeWidth"))
        assert min_stroke_width is None or 0 <= min_stroke_width
        point_padding = from_union([from_float, from_none], obj.get("pointPadding"))
        assert point_padding is None or 0 <= point_padding
        assert point_padding is None or point_padding <= 1
        range_step = from_union([from_none, from_float], obj.get("rangeStep"))
        round = from_union([from_bool, from_none], obj.get("round"))
        text_x_range_step = from_union([from_float, from_none], obj.get("textXRangeStep"))
        assert text_x_range_step is None or 0 <= text_x_range_step
        use_unaggregated_domain = from_union([from_bool, from_none], obj.get("useUnaggregatedDomain"))
        return ScaleConfig(band_padding_inner, band_padding_outer, clamp, continuous_padding, max_band_size, max_font_size, max_opacity, max_size, max_stroke_width, min_band_size, min_font_size, min_opacity, min_size, min_stroke_width, point_padding, range_step, round, text_x_range_step, use_unaggregated_domain)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.band_padding_inner is not None:
            result["bandPaddingInner"] = from_union([to_float, from_none], self.band_padding_inner)
        if self.band_padding_outer is not None:
            result["bandPaddingOuter"] = from_union([to_float, from_none], self.band_padding_outer)
        if self.clamp is not None:
            result["clamp"] = from_union([from_bool, from_none], self.clamp)
        if self.continuous_padding is not None:
            result["continuousPadding"] = from_union([to_float, from_none], self.continuous_padding)
        if self.max_band_size is not None:
            result["maxBandSize"] = from_union([to_float, from_none], self.max_band_size)
        if self.max_font_size is not None:
            result["maxFontSize"] = from_union([to_float, from_none], self.max_font_size)
        if self.max_opacity is not None:
            result["maxOpacity"] = from_union([to_float, from_none], self.max_opacity)
        if self.max_size is not None:
            result["maxSize"] = from_union([to_float, from_none], self.max_size)
        if self.max_stroke_width is not None:
            result["maxStrokeWidth"] = from_union([to_float, from_none], self.max_stroke_width)
        if self.min_band_size is not None:
            result["minBandSize"] = from_union([to_float, from_none], self.min_band_size)
        if self.min_font_size is not None:
            result["minFontSize"] = from_union([to_float, from_none], self.min_font_size)
        if self.min_opacity is not None:
            result["minOpacity"] = from_union([to_float, from_none], self.min_opacity)
        if self.min_size is not None:
            result["minSize"] = from_union([to_float, from_none], self.min_size)
        if self.min_stroke_width is not None:
            result["minStrokeWidth"] = from_union([to_float, from_none], self.min_stroke_width)
        if self.point_padding is not None:
            result["pointPadding"] = from_union([to_float, from_none], self.point_padding)
        if self.range_step is not None:
            result["rangeStep"] = from_union([from_none, to_float], self.range_step)
        if self.round is not None:
            result["round"] = from_union([from_bool, from_none], self.round)
        if self.text_x_range_step is not None:
            result["textXRangeStep"] = from_union([to_float, from_none], self.text_x_range_step)
        if self.use_unaggregated_domain is not None:
            result["useUnaggregatedDomain"] = from_union([from_bool, from_none], self.use_unaggregated_domain)
        return result


class BindEnum(Enum):
    """Establishes a two-way binding between the interval selection and the scales
    used within the same view. This allows a user to interactively pan and
    zoom the view.
    """
    SCALES = "scales"


class Empty(Enum):
    """By default, all data values are considered to lie within an empty selection.
    When set to `none`, empty selections contain no data values.
    """
    ALL = "all"
    NONE = "none"


class SingleDefChannel(Enum):
    X = "x"
    Y = "y"
    X2 = "x2"
    Y2 = "y2"
    ROW = "row"
    COLUMN = "column"
    SIZE = "size"
    SHAPE = "shape"
    COLOR = "color"
    OPACITY = "opacity"
    TEXT = "text"
    TOOLTIP = "tooltip"
    HREF = "href"


@dataclass
class BrushConfig:
    """An interval selection also adds a rectangle mark to depict the
    extents of the interval. The `mark` property can be used to customize the
    appearance of the mark.
    """
    fill: str | None = None
    """The fill color of the interval mark.
    
    __Default value:__ `#333333`
    """
    fill_opacity: float | None = None
    """The fill opacity of the interval mark (a value between 0 and 1).
    
    __Default value:__ `0.125`
    """
    stroke: str | None = None
    """The stroke color of the interval mark.
    
    __Default value:__ `#ffffff`
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke and space lengths,
    for creating dashed or dotted lines.
    """
    stroke_dash_offset: float | None = None
    """The offset (in pixels) with which to begin drawing the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity of the interval mark (a value between 0 and 1)."""

    stroke_width: float | None = None
    """The stroke width of the interval mark."""

    @staticmethod
    def from_dict(obj: Any) -> 'BrushConfig':
        assert isinstance(obj, dict)
        fill = from_union([from_str, from_none], obj.get("fill"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        return BrushConfig(fill, fill_opacity, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        return result


class SelectionResolution(Enum):
    """With layered and multi-view displays, a strategy that determines how
    selections' data queries are resolved when applied in a filter transform,
    conditional encoding rule, or scale domain.
    """
    GLOBAL = "global"
    UNION = "union"
    INTERSECT = "intersect"


@dataclass
class IntervalSelectionConfig:
    """The default definition for an [`interval`](selection.html#type) selection. All properties
    and transformations
    for an interval selection definition (except `type`) may be specified here.
    
    For instance, setting `interval` to `{"translate": false}` disables the ability to move
    interval selections by default.
    """
    bind: BindEnum | None = None
    """Establishes a two-way binding between the interval selection and the scales
    used within the same view. This allows a user to interactively pan and
    zoom the view.
    """
    empty: Empty | None = None
    """By default, all data values are considered to lie within an empty selection.
    When set to `none`, empty selections contain no data values.
    """
    encodings: list[SingleDefChannel] | None = None
    """An array of encoding channels. The corresponding data field values
    must match for a data tuple to fall within the selection.
    """
    fields: list[str] | None = None
    """An array of field names whose values must match for a data tuple to
    fall within the selection.
    """
    mark: BrushConfig | None = None
    """An interval selection also adds a rectangle mark to depict the
    extents of the interval. The `mark` property can be used to customize the
    appearance of the mark.
    """
    on: Any = None
    """A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    selector) that triggers the selection.
    For interval selections, the event stream must specify a [start and
    end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    """
    resolve: SelectionResolution | None = None
    """With layered and multi-view displays, a strategy that determines how
    selections' data queries are resolved when applied in a filter transform,
    conditional encoding rule, or scale domain.
    """
    translate: bool | str | None = None
    """When truthy, allows a user to interactively move an interval selection
    back-and-forth. Can be `true`, `false` (to disable panning), or a
    [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    which must include a start and end event to trigger continuous panning.
    
    __Default value:__ `true`, which corresponds to
    `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    clicks and dragging within an interval selection to reposition it.
    """
    zoom: bool | str | None = None
    """When truthy, allows a user to interactively resize an interval selection.
    Can be `true`, `false` (to disable zooming), or a [Vega event stream
    definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    only `wheel` events are supported.
    
    
    __Default value:__ `true`, which corresponds to `wheel!`.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'IntervalSelectionConfig':
        assert isinstance(obj, dict)
        bind = from_union([BindEnum, from_none], obj.get("bind"))
        empty = from_union([Empty, from_none], obj.get("empty"))
        encodings = from_union([lambda x: from_list(SingleDefChannel, x), from_none], obj.get("encodings"))
        fields = from_union([lambda x: from_list(from_str, x), from_none], obj.get("fields"))
        mark = from_union([BrushConfig.from_dict, from_none], obj.get("mark"))
        on = obj.get("on")
        resolve = from_union([SelectionResolution, from_none], obj.get("resolve"))
        translate = from_union([from_bool, from_str, from_none], obj.get("translate"))
        zoom = from_union([from_bool, from_str, from_none], obj.get("zoom"))
        return IntervalSelectionConfig(bind, empty, encodings, fields, mark, on, resolve, translate, zoom)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bind is not None:
            result["bind"] = from_union([lambda x: to_enum(BindEnum, x), from_none], self.bind)
        if self.empty is not None:
            result["empty"] = from_union([lambda x: to_enum(Empty, x), from_none], self.empty)
        if self.encodings is not None:
            result["encodings"] = from_union([lambda x: from_list(lambda x: to_enum(SingleDefChannel, x), x), from_none], self.encodings)
        if self.fields is not None:
            result["fields"] = from_union([lambda x: from_list(from_str, x), from_none], self.fields)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(BrushConfig, x), from_none], self.mark)
        if self.on is not None:
            result["on"] = self.on
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_enum(SelectionResolution, x), from_none], self.resolve)
        if self.translate is not None:
            result["translate"] = from_union([from_bool, from_str, from_none], self.translate)
        if self.zoom is not None:
            result["zoom"] = from_union([from_bool, from_str, from_none], self.zoom)
        return result


@dataclass
class MultiSelectionConfig:
    """The default definition for a [`multi`](selection.html#type) selection. All properties and
    transformations
    for a multi selection definition (except `type`) may be specified here.
    
    For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
    multi selections when clicking with the alt-key pressed by default.
    """
    empty: Empty | None = None
    """By default, all data values are considered to lie within an empty selection.
    When set to `none`, empty selections contain no data values.
    """
    encodings: list[SingleDefChannel] | None = None
    """An array of encoding channels. The corresponding data field values
    must match for a data tuple to fall within the selection.
    """
    fields: list[str] | None = None
    """An array of field names whose values must match for a data tuple to
    fall within the selection.
    """
    nearest: bool | None = None
    """When true, an invisible voronoi diagram is computed to accelerate discrete
    selection. The data value _nearest_ the mouse cursor is added to the selection.
    
    See the [nearest transform](nearest.html) documentation for more information.
    """
    on: Any = None
    """A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    selector) that triggers the selection.
    For interval selections, the event stream must specify a [start and
    end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    """
    resolve: SelectionResolution | None = None
    """With layered and multi-view displays, a strategy that determines how
    selections' data queries are resolved when applied in a filter transform,
    conditional encoding rule, or scale domain.
    """
    toggle: bool | str | None = None
    """Controls whether data values should be toggled or only ever inserted into
    multi selections. Can be `true`, `false` (for insertion only), or a
    [Vega expression](https://vega.github.io/vega/docs/expressions/).
    
    __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    data values are toggled when a user interacts with the shift-key pressed).
    
    See the [toggle transform](toggle.html) documentation for more information.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'MultiSelectionConfig':
        assert isinstance(obj, dict)
        empty = from_union([Empty, from_none], obj.get("empty"))
        encodings = from_union([lambda x: from_list(SingleDefChannel, x), from_none], obj.get("encodings"))
        fields = from_union([lambda x: from_list(from_str, x), from_none], obj.get("fields"))
        nearest = from_union([from_bool, from_none], obj.get("nearest"))
        on = obj.get("on")
        resolve = from_union([SelectionResolution, from_none], obj.get("resolve"))
        toggle = from_union([from_bool, from_str, from_none], obj.get("toggle"))
        return MultiSelectionConfig(empty, encodings, fields, nearest, on, resolve, toggle)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.empty is not None:
            result["empty"] = from_union([lambda x: to_enum(Empty, x), from_none], self.empty)
        if self.encodings is not None:
            result["encodings"] = from_union([lambda x: from_list(lambda x: to_enum(SingleDefChannel, x), x), from_none], self.encodings)
        if self.fields is not None:
            result["fields"] = from_union([lambda x: from_list(from_str, x), from_none], self.fields)
        if self.nearest is not None:
            result["nearest"] = from_union([from_bool, from_none], self.nearest)
        if self.on is not None:
            result["on"] = self.on
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_enum(SelectionResolution, x), from_none], self.resolve)
        if self.toggle is not None:
            result["toggle"] = from_union([from_bool, from_str, from_none], self.toggle)
        return result


@dataclass
class VGBinding:
    input: str
    element: str | None = None
    options: list[str] | None = None
    max: float | None = None
    min: float | None = None
    step: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'VGBinding':
        assert isinstance(obj, dict)
        input = from_str(obj["input"])
        element = from_union([from_str, from_none], obj.get("element"))
        options = from_union([lambda x: from_list(from_str, x), from_none], obj.get("options"))
        max = from_union([from_float, from_none], obj.get("max"))
        min = from_union([from_float, from_none], obj.get("min"))
        step = from_union([from_float, from_none], obj.get("step"))
        return VGBinding(input, element, options, max, min, step)

    def to_dict(self) -> dict:
        result: dict = {}
        result["input"] = from_str(self.input)
        if self.element is not None:
            result["element"] = from_union([from_str, from_none], self.element)
        if self.options is not None:
            result["options"] = from_union([lambda x: from_list(from_str, x), from_none], self.options)
        if self.max is not None:
            result["max"] = from_union([to_float, from_none], self.max)
        if self.min is not None:
            result["min"] = from_union([to_float, from_none], self.min)
        if self.step is not None:
            result["step"] = from_union([to_float, from_none], self.step)
        return result


@dataclass
class SingleSelectionConfig:
    """The default definition for a [`single`](selection.html#type) selection. All properties
    and transformations
    for a single selection definition (except `type`) may be specified here.
    
    For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
    double-click by default.
    """
    bind: dict[str, VGBinding] | None = None
    """Establish a two-way binding between a single selection and input elements
    (also known as dynamic query widgets). A binding takes the form of
    Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    or can be a mapping between projected field/encodings and binding definitions.
    
    See the [bind transform](bind.html) documentation for more information.
    """
    empty: Empty | None = None
    """By default, all data values are considered to lie within an empty selection.
    When set to `none`, empty selections contain no data values.
    """
    encodings: list[SingleDefChannel] | None = None
    """An array of encoding channels. The corresponding data field values
    must match for a data tuple to fall within the selection.
    """
    fields: list[str] | None = None
    """An array of field names whose values must match for a data tuple to
    fall within the selection.
    """
    nearest: bool | None = None
    """When true, an invisible voronoi diagram is computed to accelerate discrete
    selection. The data value _nearest_ the mouse cursor is added to the selection.
    
    See the [nearest transform](nearest.html) documentation for more information.
    """
    on: Any = None
    """A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    selector) that triggers the selection.
    For interval selections, the event stream must specify a [start and
    end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    """
    resolve: SelectionResolution | None = None
    """With layered and multi-view displays, a strategy that determines how
    selections' data queries are resolved when applied in a filter transform,
    conditional encoding rule, or scale domain.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'SingleSelectionConfig':
        assert isinstance(obj, dict)
        bind = from_union([lambda x: from_dict(VGBinding.from_dict, x), from_none], obj.get("bind"))
        empty = from_union([Empty, from_none], obj.get("empty"))
        encodings = from_union([lambda x: from_list(SingleDefChannel, x), from_none], obj.get("encodings"))
        fields = from_union([lambda x: from_list(from_str, x), from_none], obj.get("fields"))
        nearest = from_union([from_bool, from_none], obj.get("nearest"))
        on = obj.get("on")
        resolve = from_union([SelectionResolution, from_none], obj.get("resolve"))
        return SingleSelectionConfig(bind, empty, encodings, fields, nearest, on, resolve)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.bind is not None:
            result["bind"] = from_union([lambda x: from_dict(lambda x: to_class(VGBinding, x), x), from_none], self.bind)
        if self.empty is not None:
            result["empty"] = from_union([lambda x: to_enum(Empty, x), from_none], self.empty)
        if self.encodings is not None:
            result["encodings"] = from_union([lambda x: from_list(lambda x: to_enum(SingleDefChannel, x), x), from_none], self.encodings)
        if self.fields is not None:
            result["fields"] = from_union([lambda x: from_list(from_str, x), from_none], self.fields)
        if self.nearest is not None:
            result["nearest"] = from_union([from_bool, from_none], self.nearest)
        if self.on is not None:
            result["on"] = self.on
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_enum(SelectionResolution, x), from_none], self.resolve)
        return result


@dataclass
class SelectionConfig:
    """An object hash for defining default properties for each type of selections."""

    interval: IntervalSelectionConfig | None = None
    """The default definition for an [`interval`](selection.html#type) selection. All properties
    and transformations
    for an interval selection definition (except `type`) may be specified here.
    
    For instance, setting `interval` to `{"translate": false}` disables the ability to move
    interval selections by default.
    """
    multi: MultiSelectionConfig | None = None
    """The default definition for a [`multi`](selection.html#type) selection. All properties and
    transformations
    for a multi selection definition (except `type`) may be specified here.
    
    For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
    multi selections when clicking with the alt-key pressed by default.
    """
    single: SingleSelectionConfig | None = None
    """The default definition for a [`single`](selection.html#type) selection. All properties
    and transformations
    for a single selection definition (except `type`) may be specified here.
    
    For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
    double-click by default.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'SelectionConfig':
        assert isinstance(obj, dict)
        interval = from_union([IntervalSelectionConfig.from_dict, from_none], obj.get("interval"))
        multi = from_union([MultiSelectionConfig.from_dict, from_none], obj.get("multi"))
        single = from_union([SingleSelectionConfig.from_dict, from_none], obj.get("single"))
        return SelectionConfig(interval, multi, single)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.interval is not None:
            result["interval"] = from_union([lambda x: to_class(IntervalSelectionConfig, x), from_none], self.interval)
        if self.multi is not None:
            result["multi"] = from_union([lambda x: to_class(MultiSelectionConfig, x), from_none], self.multi)
        if self.single is not None:
            result["single"] = from_union([lambda x: to_class(SingleSelectionConfig, x), from_none], self.single)
        return result


class StackOffset(Enum):
    """Default stack offset for stackable mark."""

    ZERO = "zero"
    CENTER = "center"
    NORMALIZE = "normalize"


@dataclass
class VGMarkConfig:
    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """

    @staticmethod
    def from_dict(obj: Any) -> 'VGMarkConfig':
        assert isinstance(obj, dict)
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        return VGMarkConfig(align, angle, baseline, cursor, dx, dy, fill, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, tension, text, theta)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        return result


@dataclass
class TextConfig:
    """Text-Specific Config"""

    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    color: str | None = None
    """Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    will override `color`.
    
    __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    filled: bool | None = None
    """Whether the mark's color should be used as fill color instead of stroke color.
    
    __Default value:__ `true` for all marks except `point` and `false` for `point`.
    
    __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    short_time_labels: bool | None = None
    """Whether month names and weekday names should be abbreviated."""

    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """

    @staticmethod
    def from_dict(obj: Any) -> 'TextConfig':
        assert isinstance(obj, dict)
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        color = from_union([from_str, from_none], obj.get("color"))
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        filled = from_union([from_bool, from_none], obj.get("filled"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        short_time_labels = from_union([from_bool, from_none], obj.get("shortTimeLabels"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        return TextConfig(align, angle, baseline, color, cursor, dx, dy, fill, filled, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, short_time_labels, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, tension, text, theta)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.filled is not None:
            result["filled"] = from_union([from_bool, from_none], self.filled)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.short_time_labels is not None:
            result["shortTimeLabels"] = from_union([from_bool, from_none], self.short_time_labels)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        return result


@dataclass
class TickConfig:
    """Tick-Specific Config"""

    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    band_size: float | None = None
    """The width of the ticks.
    
    __Default value:__  2/3 of rangeStep.
    """
    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    color: str | None = None
    """Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    will override `color`.
    
    __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    filled: bool | None = None
    """Whether the mark's color should be used as fill color instead of stroke color.
    
    __Default value:__ `true` for all marks except `point` and `false` for `point`.
    
    __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """
    thickness: float | None = None
    """Thickness of the tick mark.
    
    __Default value:__  `1`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'TickConfig':
        assert isinstance(obj, dict)
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        band_size = from_union([from_float, from_none], obj.get("bandSize"))
        assert band_size is None or 0 <= band_size
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        color = from_union([from_str, from_none], obj.get("color"))
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        filled = from_union([from_bool, from_none], obj.get("filled"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        thickness = from_union([from_float, from_none], obj.get("thickness"))
        assert thickness is None or 0 <= thickness
        return TickConfig(align, angle, band_size, baseline, color, cursor, dx, dy, fill, filled, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, tension, text, theta, thickness)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.band_size is not None:
            result["bandSize"] = from_union([to_float, from_none], self.band_size)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.filled is not None:
            result["filled"] = from_union([from_bool, from_none], self.filled)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        if self.thickness is not None:
            result["thickness"] = from_union([to_float, from_none], self.thickness)
        return result


class Anchor(Enum):
    """The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    example, with an orientation of top these anchor positions map to a left-, center-, or
    right-aligned title.
    
    __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    `"start"` for other composite views.
    
    __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    composite views, `anchor` is always `"start"`.
    """
    START = "start"
    MIDDLE = "middle"
    END = "end"


class TitleOrient(Enum):
    """Default title orientation ("top", "bottom", "left", or "right")
    
    The orientation of the title relative to the chart. One of `"top"` (the default),
    `"bottom"`, `"left"`, or `"right"`.
    
    The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
    orientation can be used to further specialize the axis type (e.g., a y axis oriented for
    the right edge of the chart).
    
    __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
    """
    TOP = "top"
    BOTTOM = "bottom"
    LEFT = "left"
    RIGHT = "right"


@dataclass
class VGTitleConfig:
    """Title configuration, which determines default properties for all [titles](title.html).
    For a full list of title configuration options, please see the [corresponding section of
    the title documentation](title.html#config).
    """
    anchor: Anchor | None = None
    """The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    example, with an orientation of top these anchor positions map to a left-, center-, or
    right-aligned title.
    
    __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    `"start"` for other composite views.
    
    __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    composite views, `anchor` is always `"start"`.
    """
    angle: float | None = None
    """Angle in degrees of title text."""

    baseline: VerticalAlign | None = None
    """Vertical text baseline for title text."""

    color: str | None = None
    """Text color for title text."""

    font: str | None = None
    """Font name for title text."""

    font_size: float | None = None
    """Font size in pixels for title text.
    
    __Default value:__ `10`.
    """
    font_weight: float | FontWeight | None = None
    """Font weight for title text."""

    limit: float | None = None
    """The maximum allowed length in pixels of legend labels."""

    offset: float | None = None
    """Offset in pixels of the title from the chart body and axes."""

    orient: TitleOrient | None = None
    """Default title orientation ("top", "bottom", "left", or "right")"""

    @staticmethod
    def from_dict(obj: Any) -> 'VGTitleConfig':
        assert isinstance(obj, dict)
        anchor = from_union([Anchor, from_none], obj.get("anchor"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        color = from_union([from_str, from_none], obj.get("color"))
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        assert limit is None or 0 <= limit
        offset = from_union([from_float, from_none], obj.get("offset"))
        orient = from_union([TitleOrient, from_none], obj.get("orient"))
        return VGTitleConfig(anchor, angle, baseline, color, font, font_size, font_weight, limit, offset, orient)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.anchor is not None:
            result["anchor"] = from_union([lambda x: to_enum(Anchor, x), from_none], self.anchor)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.offset is not None:
            result["offset"] = from_union([to_float, from_none], self.offset)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(TitleOrient, x), from_none], self.orient)
        return result


@dataclass
class ViewConfig:
    """Default properties for [single view plots](spec.html#single)."""

    clip: bool | None = None
    """Whether the view should be clipped."""

    fill: str | None = None
    """The fill color.
    
    __Default value:__ (none)
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ (none)
    """
    height: float | None = None
    """The default height of the single plot or each plot in a trellis plot when the
    visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
    
    __Default value:__ `200`
    """
    stroke: str | None = None
    """The stroke color.
    
    __Default value:__ (none)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines.
    
    __Default value:__ (none)
    """
    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array.
    
    __Default value:__ (none)
    """
    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ (none)
    """
    stroke_width: float | None = None
    """The stroke width, in pixels.
    
    __Default value:__ (none)
    """
    width: float | None = None
    """The default width of the single plot or each plot in a trellis plot when the
    visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
    = `null`.
    
    __Default value:__ `200`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ViewConfig':
        assert isinstance(obj, dict)
        clip = from_union([from_bool, from_none], obj.get("clip"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        height = from_union([from_float, from_none], obj.get("height"))
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        width = from_union([from_float, from_none], obj.get("width"))
        return ViewConfig(clip, fill, fill_opacity, height, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, width)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.clip is not None:
            result["clip"] = from_union([from_bool, from_none], self.clip)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.height is not None:
            result["height"] = from_union([to_float, from_none], self.height)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.width is not None:
            result["width"] = from_union([to_float, from_none], self.width)
        return result


@dataclass
class Config:
    """Vega-Lite configuration object.  This property can only be defined at the top-level of a
    specification.
    """
    area: MarkConfig | None = None
    """Area-Specific Config"""

    autosize: AutoSizeParams | AutosizeType | None = None
    """Sets how the visualization size should be determined. If a string, should be one of
    `"pad"`, `"fit"` or `"none"`.
    Object values can additionally specify parameters for content sizing and automatic
    resizing.
    `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    
    __Default value__: `pad`
    """
    axis: AxisConfig | None = None
    """Axis configuration, which determines default properties for all `x` and `y`
    [axes](axis.html). For a full list of axis configuration options, please see the
    [corresponding section of the axis documentation](axis.html#config).
    """
    axis_band: VGAxisConfig | None = None
    """Specific axis config for axes with "band" scales."""

    axis_bottom: VGAxisConfig | None = None
    """Specific axis config for x-axis along the bottom edge of the chart."""

    axis_left: VGAxisConfig | None = None
    """Specific axis config for y-axis along the left edge of the chart."""

    axis_right: VGAxisConfig | None = None
    """Specific axis config for y-axis along the right edge of the chart."""

    axis_top: VGAxisConfig | None = None
    """Specific axis config for x-axis along the top edge of the chart."""

    axis_x: VGAxisConfig | None = None
    """X-axis specific config."""

    axis_y: VGAxisConfig | None = None
    """Y-axis specific config."""

    background: str | None = None
    """CSS color property to use as the background of visualization.
    
    __Default value:__ none (transparent)
    """
    bar: BarConfig | None = None
    """Bar-Specific Config"""

    circle: MarkConfig | None = None
    """Circle-Specific Config"""

    count_title: str | None = None
    """Default axis and legend title for count fields.
    
    __Default value:__ `'Number of Records'`.
    """
    field_title: FieldTitle | None = None
    """Defines how Vega-Lite generates title for fields.  There are three possible styles:
    
    - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
    "Year-month of date", "field (binned)").
    - `"function"` - displays function using parentheses and capitalized texts (e.g.,
    "SUM(field)", "YEARMONTH(date)", "BIN(field)").
    - `"plain"` - displays only the field name without functions (e.g., "field", "date",
    "field").
    """
    geoshape: MarkConfig | None = None
    """Geoshape-Specific Config"""

    invalid_values: InvalidValues | None = None
    """Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
    - If set to `"filter"` (default), all data items with null values are filtered.
    - If `null`, all data items are included. In this case, invalid values will be
    interpreted as zeroes.
    """
    legend: LegendConfig | None = None
    """Legend configuration, which determines default properties for all [legends](legend.html).
    For a full list of legend configuration options, please see the [corresponding section of
    in the legend documentation](legend.html#config).
    """
    line: MarkConfig | None = None
    """Line-Specific Config"""

    mark: MarkConfig | None = None
    """Mark Config"""

    number_format: str | None = None
    """D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
    number format pattern](https://github.com/d3/d3-format#locale_format).
    """
    padding: float | PaddingClass | None = None
    """The default visualization padding, in pixels, from the edge of the visualization canvas
    to the data rectangle.  If a number, specifies padding for all sides.
    If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    "bottom": 5}` to specify padding for each side of the visualization.
    
    __Default value__: `5`
    """
    point: MarkConfig | None = None
    """Point-Specific Config"""

    projection: ProjectionConfig | None = None
    """Projection configuration, which determines default properties for all
    [projections](projection.html). For a full list of projection configuration options,
    please see the [corresponding section of the projection
    documentation](projection.html#config).
    """
    range: dict[str, list[float | str] | VGScheme] | None = None
    """An object hash that defines default range arrays or schemes for using with scales.
    For a full list of scale range configuration options, please see the [corresponding
    section of the scale documentation](scale.html#config).
    """
    rect: MarkConfig | None = None
    """Rect-Specific Config"""

    rule: MarkConfig | None = None
    """Rule-Specific Config"""

    scale: ScaleConfig | None = None
    """Scale configuration determines default properties for all [scales](scale.html). For a
    full list of scale configuration options, please see the [corresponding section of the
    scale documentation](scale.html#config).
    """
    selection: SelectionConfig | None = None
    """An object hash for defining default properties for each type of selections."""

    square: MarkConfig | None = None
    """Square-Specific Config"""

    stack: StackOffset | None = None
    """Default stack offset for stackable mark."""

    style: dict[str, VGMarkConfig] | None = None
    """An object hash that defines key-value mappings to determine default properties for marks
    with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
    valid [mark configuration objects](mark.html#config).
    """
    text: TextConfig | None = None
    """Text-Specific Config"""

    tick: TickConfig | None = None
    """Tick-Specific Config"""

    time_format: str | None = None
    """Default datetime format for axis and legend labels. The format can be set directly on
    each axis and legend. Use [D3's time format
    pattern](https://github.com/d3/d3-time-format#locale_format).
    
    __Default value:__ `'%b %d, %Y'`.
    """
    title: VGTitleConfig | None = None
    """Title configuration, which determines default properties for all [titles](title.html).
    For a full list of title configuration options, please see the [corresponding section of
    the title documentation](title.html#config).
    """
    view: ViewConfig | None = None
    """Default properties for [single view plots](spec.html#single)."""

    @staticmethod
    def from_dict(obj: Any) -> 'Config':
        assert isinstance(obj, dict)
        area = from_union([MarkConfig.from_dict, from_none], obj.get("area"))
        autosize = from_union([AutoSizeParams.from_dict, AutosizeType, from_none], obj.get("autosize"))
        axis = from_union([AxisConfig.from_dict, from_none], obj.get("axis"))
        axis_band = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisBand"))
        axis_bottom = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisBottom"))
        axis_left = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisLeft"))
        axis_right = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisRight"))
        axis_top = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisTop"))
        axis_x = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisX"))
        axis_y = from_union([VGAxisConfig.from_dict, from_none], obj.get("axisY"))
        background = from_union([from_str, from_none], obj.get("background"))
        bar = from_union([BarConfig.from_dict, from_none], obj.get("bar"))
        circle = from_union([MarkConfig.from_dict, from_none], obj.get("circle"))
        count_title = from_union([from_str, from_none], obj.get("countTitle"))
        field_title = from_union([FieldTitle, from_none], obj.get("fieldTitle"))
        geoshape = from_union([MarkConfig.from_dict, from_none], obj.get("geoshape"))
        invalid_values = from_union([InvalidValues, from_none], obj.get("invalidValues"))
        legend = from_union([LegendConfig.from_dict, from_none], obj.get("legend"))
        line = from_union([MarkConfig.from_dict, from_none], obj.get("line"))
        mark = from_union([MarkConfig.from_dict, from_none], obj.get("mark"))
        number_format = from_union([from_str, from_none], obj.get("numberFormat"))
        padding = from_union([from_float, PaddingClass.from_dict, from_none], obj.get("padding"))
        point = from_union([MarkConfig.from_dict, from_none], obj.get("point"))
        projection = from_union([ProjectionConfig.from_dict, from_none], obj.get("projection"))
        range = from_union([lambda x: from_dict(lambda x: from_union([lambda x: from_list(lambda x: from_union([from_float, from_str], x), x), VGScheme.from_dict], x), x), from_none], obj.get("range"))
        rect = from_union([MarkConfig.from_dict, from_none], obj.get("rect"))
        rule = from_union([MarkConfig.from_dict, from_none], obj.get("rule"))
        scale = from_union([ScaleConfig.from_dict, from_none], obj.get("scale"))
        selection = from_union([SelectionConfig.from_dict, from_none], obj.get("selection"))
        square = from_union([MarkConfig.from_dict, from_none], obj.get("square"))
        stack = from_union([StackOffset, from_none], obj.get("stack"))
        style = from_union([lambda x: from_dict(VGMarkConfig.from_dict, x), from_none], obj.get("style"))
        text = from_union([TextConfig.from_dict, from_none], obj.get("text"))
        tick = from_union([TickConfig.from_dict, from_none], obj.get("tick"))
        time_format = from_union([from_str, from_none], obj.get("timeFormat"))
        title = from_union([VGTitleConfig.from_dict, from_none], obj.get("title"))
        view = from_union([ViewConfig.from_dict, from_none], obj.get("view"))
        return Config(area, autosize, axis, axis_band, axis_bottom, axis_left, axis_right, axis_top, axis_x, axis_y, background, bar, circle, count_title, field_title, geoshape, invalid_values, legend, line, mark, number_format, padding, point, projection, range, rect, rule, scale, selection, square, stack, style, text, tick, time_format, title, view)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.area is not None:
            result["area"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.area)
        if self.autosize is not None:
            result["autosize"] = from_union([lambda x: to_class(AutoSizeParams, x), lambda x: to_enum(AutosizeType, x), from_none], self.autosize)
        if self.axis is not None:
            result["axis"] = from_union([lambda x: to_class(AxisConfig, x), from_none], self.axis)
        if self.axis_band is not None:
            result["axisBand"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_band)
        if self.axis_bottom is not None:
            result["axisBottom"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_bottom)
        if self.axis_left is not None:
            result["axisLeft"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_left)
        if self.axis_right is not None:
            result["axisRight"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_right)
        if self.axis_top is not None:
            result["axisTop"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_top)
        if self.axis_x is not None:
            result["axisX"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_x)
        if self.axis_y is not None:
            result["axisY"] = from_union([lambda x: to_class(VGAxisConfig, x), from_none], self.axis_y)
        if self.background is not None:
            result["background"] = from_union([from_str, from_none], self.background)
        if self.bar is not None:
            result["bar"] = from_union([lambda x: to_class(BarConfig, x), from_none], self.bar)
        if self.circle is not None:
            result["circle"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.circle)
        if self.count_title is not None:
            result["countTitle"] = from_union([from_str, from_none], self.count_title)
        if self.field_title is not None:
            result["fieldTitle"] = from_union([lambda x: to_enum(FieldTitle, x), from_none], self.field_title)
        if self.geoshape is not None:
            result["geoshape"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.geoshape)
        if self.invalid_values is not None:
            result["invalidValues"] = from_union([lambda x: to_enum(InvalidValues, x), from_none], self.invalid_values)
        if self.legend is not None:
            result["legend"] = from_union([lambda x: to_class(LegendConfig, x), from_none], self.legend)
        if self.line is not None:
            result["line"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.line)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.mark)
        if self.number_format is not None:
            result["numberFormat"] = from_union([from_str, from_none], self.number_format)
        if self.padding is not None:
            result["padding"] = from_union([to_float, lambda x: to_class(PaddingClass, x), from_none], self.padding)
        if self.point is not None:
            result["point"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.point)
        if self.projection is not None:
            result["projection"] = from_union([lambda x: to_class(ProjectionConfig, x), from_none], self.projection)
        if self.range is not None:
            result["range"] = from_union([lambda x: from_dict(lambda x: from_union([lambda x: from_list(lambda x: from_union([to_float, from_str], x), x), lambda x: to_class(VGScheme, x)], x), x), from_none], self.range)
        if self.rect is not None:
            result["rect"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.rect)
        if self.rule is not None:
            result["rule"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.rule)
        if self.scale is not None:
            result["scale"] = from_union([lambda x: to_class(ScaleConfig, x), from_none], self.scale)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(SelectionConfig, x), from_none], self.selection)
        if self.square is not None:
            result["square"] = from_union([lambda x: to_class(MarkConfig, x), from_none], self.square)
        if self.stack is not None:
            result["stack"] = from_union([lambda x: to_enum(StackOffset, x), from_none], self.stack)
        if self.style is not None:
            result["style"] = from_union([lambda x: from_dict(lambda x: to_class(VGMarkConfig, x), x), from_none], self.style)
        if self.text is not None:
            result["text"] = from_union([lambda x: to_class(TextConfig, x), from_none], self.text)
        if self.tick is not None:
            result["tick"] = from_union([lambda x: to_class(TickConfig, x), from_none], self.tick)
        if self.time_format is not None:
            result["timeFormat"] = from_union([from_str, from_none], self.time_format)
        if self.title is not None:
            result["title"] = from_union([lambda x: to_class(VGTitleConfig, x), from_none], self.title)
        if self.view is not None:
            result["view"] = from_union([lambda x: to_class(ViewConfig, x), from_none], self.view)
        return result


class ParseEnum(Enum):
    AUTO = "auto"


class DataFormatType(Enum):
    """Type of input data: `"json"`, `"csv"`, `"tsv"`.
    The default format type is determined by the extension of the file URL.
    If no extension is detected, `"json"` will be used by default.
    """
    CSV = "csv"
    TSV = "tsv"
    JSON = "json"
    TOPOJSON = "topojson"


@dataclass
class DataFormat:
    """An object that specifies the format for parsing the data file.
    
    An object that specifies the format for parsing the data values.
    
    An object that specifies the format for parsing the data.
    """
    parse: dict[str, Any] | ParseEnum | None = None
    """If set to auto (the default), perform automatic type inference to determine the desired
    data types.
    Alternatively, a parsing directive object can be provided for explicit data types. Each
    property of the object corresponds to a field name, and the value to the desired data
    type (one of `"number"`, `"boolean"` or `"date"`).
    For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
    input record a Date value.
    
    For `"date"`, we parse data based using Javascript's
    [`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
    For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
    [d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
    format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
    [UTC time](timeunit.html#utc)
    """
    type: DataFormatType | None = None
    """Type of input data: `"json"`, `"csv"`, `"tsv"`.
    The default format type is determined by the extension of the file URL.
    If no extension is detected, `"json"` will be used by default.
    """
    property: str | None = None
    """The JSON property containing the desired data.
    This parameter can be used when the loaded JSON file may have surrounding structure or
    meta-data.
    For example `"property": "values.features"` is equivalent to retrieving
    `json.values.features`
    from the loaded JSON object.
    """
    feature: str | None = None
    """The name of the TopoJSON object set to convert to a GeoJSON feature collection.
    For example, in a map of the world, there may be an object set named `"countries"`.
    Using the feature property, we can extract this set and generate a GeoJSON feature object
    for each country.
    """
    mesh: str | None = None
    """The name of the TopoJSON object set to convert to mesh.
    Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
    Unlike the `feature` option, the corresponding geo data is returned as a single, unified
    mesh instance, not as individual GeoJSON features.
    Extracting a mesh is useful for more efficiently drawing borders or other geographic
    elements that you do not need to associate with specific regions such as individual
    countries, states or counties.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'DataFormat':
        assert isinstance(obj, dict)
        parse = from_union([lambda x: from_dict(lambda x: x, x), ParseEnum, from_none], obj.get("parse"))
        type = from_union([DataFormatType, from_none], obj.get("type"))
        property = from_union([from_str, from_none], obj.get("property"))
        feature = from_union([from_str, from_none], obj.get("feature"))
        mesh = from_union([from_str, from_none], obj.get("mesh"))
        return DataFormat(parse, type, property, feature, mesh)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.parse is not None:
            result["parse"] = from_union([lambda x: from_dict(lambda x: x, x), lambda x: to_enum(ParseEnum, x), from_none], self.parse)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(DataFormatType, x), from_none], self.type)
        if self.property is not None:
            result["property"] = from_union([from_str, from_none], self.property)
        if self.feature is not None:
            result["feature"] = from_union([from_str, from_none], self.feature)
        if self.mesh is not None:
            result["mesh"] = from_union([from_str, from_none], self.mesh)
        return result


@dataclass
class Data:
    """An object describing the data source
    
    Secondary data source to lookup in.
    """
    format: DataFormat | None = None
    """An object that specifies the format for parsing the data file.
    
    An object that specifies the format for parsing the data values.
    
    An object that specifies the format for parsing the data.
    """
    url: str | None = None
    """An URL from which to load the data set. Use the `format.type` property
    to ensure the loaded data is correctly parsed.
    """
    values: list[float | bool | dict[str, Any] | str] | dict[str, Any] | str | None = None
    """The full data set, included inline. This can be an array of objects or primitive values
    or a string.
    Arrays of primitive values are ingested as objects with a `data` property. Strings are
    parsed according to the specified format type.
    """
    name: str | None = None
    """Provide a placeholder name and bind data at runtime."""

    @staticmethod
    def from_dict(obj: Any) -> 'Data':
        assert isinstance(obj, dict)
        format = from_union([DataFormat.from_dict, from_none], obj.get("format"))
        url = from_union([from_str, from_none], obj.get("url"))
        values = from_union([lambda x: from_list(lambda x: from_union([from_float, from_bool, lambda x: from_dict(lambda x: x, x), from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str, from_none], obj.get("values"))
        name = from_union([from_str, from_none], obj.get("name"))
        return Data(format, url, values, name)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.format is not None:
            result["format"] = from_union([lambda x: to_class(DataFormat, x), from_none], self.format)
        if self.url is not None:
            result["url"] = from_union([from_str, from_none], self.url)
        if self.values is not None:
            result["values"] = from_union([lambda x: from_list(lambda x: from_union([to_float, from_bool, lambda x: from_dict(lambda x: x, x), from_str], x), x), lambda x: from_dict(lambda x: x, x), from_str, from_none], self.values)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        return result


class AggregateOp(Enum):
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    
    An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
    (e.g., `"count"`, `"mean"` and `"median"`).
    This property is required in cases where the sort field and the data reference field do
    not match.
    The input data objects will be aggregated, grouped by the encoded data field.
    
    For a full list of operations, please see the documentation for
    [aggregate](aggregate.html#ops).
    
    The aggregation operations to apply to the fields, such as sum, average or count.
    See the [full list of supported aggregation
    operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
    for more information.
    """
    ARGMAX = "argmax"
    ARGMIN = "argmin"
    AVERAGE = "average"
    COUNT = "count"
    DISTINCT = "distinct"
    MAX = "max"
    MEAN = "mean"
    MEDIAN = "median"
    MIN = "min"
    MISSING = "missing"
    Q1 = "q1"
    Q3 = "q3"
    CI0 = "ci0"
    CI1 = "ci1"
    STDEV = "stdev"
    STDEVP = "stdevp"
    SUM = "sum"
    VALID = "valid"
    VALUES = "values"
    VARIANCE = "variance"
    VARIANCEP = "variancep"


@dataclass
class BinParams:
    """Binning properties or boolean flag for determining whether to bin data or not."""

    base: float | None = None
    """The number base to use for automatic bin determination (default is base 10).
    
    __Default value:__ `10`
    """
    divide: list[float] | None = None
    """Scale factors indicating allowable subdivisions. The default value is [5, 2], which
    indicates that for base 10 numbers (the default base), the method may consider dividing
    bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
    check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
    given constraints.
    
    __Default value:__ `[5, 2]`
    """
    extent: list[float] | None = None
    """A two-element (`[min, max]`) array indicating the range of desired bin values."""

    maxbins: float | None = None
    """Maximum number of bins.
    
    __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
    """
    minstep: float | None = None
    """A minimum allowable step size (particularly useful for integer values)."""

    nice: bool | None = None
    """If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
    such as multiples of ten.
    """
    step: float | None = None
    """An exact step size to use between bins.
    
    __Note:__ If provided, options such as maxbins will be ignored.
    """
    steps: list[float] | None = None
    """An array of allowable step sizes to choose from."""

    @staticmethod
    def from_dict(obj: Any) -> 'BinParams':
        assert isinstance(obj, dict)
        base = from_union([from_float, from_none], obj.get("base"))
        divide = from_union([lambda x: from_list(from_float, x), from_none], obj.get("divide"))
        assert divide is None or 1 <= len(divide)
        extent = from_union([lambda x: from_list(from_float, x), from_none], obj.get("extent"))
        assert extent is None or 2 <= len(extent)
        assert extent is None or len(extent) <= 2
        maxbins = from_union([from_float, from_none], obj.get("maxbins"))
        assert maxbins is None or 2 <= maxbins
        minstep = from_union([from_float, from_none], obj.get("minstep"))
        nice = from_union([from_bool, from_none], obj.get("nice"))
        step = from_union([from_float, from_none], obj.get("step"))
        steps = from_union([lambda x: from_list(from_float, x), from_none], obj.get("steps"))
        assert steps is None or 1 <= len(steps)
        return BinParams(base, divide, extent, maxbins, minstep, nice, step, steps)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.base is not None:
            result["base"] = from_union([to_float, from_none], self.base)
        if self.divide is not None:
            result["divide"] = from_union([lambda x: from_list(to_float, x), from_none], self.divide)
        if self.extent is not None:
            result["extent"] = from_union([lambda x: from_list(to_float, x), from_none], self.extent)
        if self.maxbins is not None:
            result["maxbins"] = from_union([to_float, from_none], self.maxbins)
        if self.minstep is not None:
            result["minstep"] = from_union([to_float, from_none], self.minstep)
        if self.nice is not None:
            result["nice"] = from_union([from_bool, from_none], self.nice)
        if self.step is not None:
            result["step"] = from_union([to_float, from_none], self.step)
        if self.steps is not None:
            result["steps"] = from_union([lambda x: from_list(to_float, x), from_none], self.steps)
        return result


@dataclass
class Selection:
    selection_not: 'Selection | str | None' = None
    selection_and: 'list[Selection | str] | None' = None
    selection_or: 'list[Selection | str] | None' = None

    @staticmethod
    def from_dict(obj: Any) -> 'Selection':
        assert isinstance(obj, dict)
        selection_not = from_union([Selection.from_dict, from_str, from_none], obj.get("not"))
        selection_and = from_union([lambda x: from_list(lambda x: from_union([Selection.from_dict, from_str], x), x), from_none], obj.get("and"))
        selection_or = from_union([lambda x: from_list(lambda x: from_union([Selection.from_dict, from_str], x), x), from_none], obj.get("or"))
        return Selection(selection_not, selection_and, selection_or)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.selection_not is not None:
            result["not"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection_not)
        if self.selection_and is not None:
            result["and"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(Selection, x), from_str], x), x), from_none], self.selection_and)
        if self.selection_or is not None:
            result["or"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(Selection, x), from_str], x), x), from_none], self.selection_or)
        return result


@dataclass
class DateTime:
    """Object for defining datetime in Vega-Lite Filter.
    If both month and quarter are provided, month has higher precedence.
    `day` cannot be combined with other date.
    We accept string for month and day names.
    """
    date: float | None = None
    """Integer value representing the date from 1-31."""

    day: float | str | None = None
    """Value representing the day of a week.  This can be one of: (1) integer value -- `1`
    represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
    case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
    DateTime definition object with `day`** should not be combined with `year`, `quarter`,
    `month`, or `date`.
    """
    hours: float | None = None
    """Integer value representing the hour of a day from 0-23."""

    milliseconds: float | None = None
    """Integer value representing the millisecond segment of time."""

    minutes: float | None = None
    """Integer value representing the minute segment of time from 0-59."""

    month: float | str | None = None
    """One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
    (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
    short month name (e.g., `"Jan"`).
    """
    quarter: float | None = None
    """Integer value representing the quarter of the year (from 1-4)."""

    seconds: float | None = None
    """Integer value representing the second segment (0-59) of a time value"""

    utc: bool | None = None
    """A boolean flag indicating if date time is in utc time. If false, the date time is in
    local time
    """
    year: float | None = None
    """Integer value representing the year."""

    @staticmethod
    def from_dict(obj: Any) -> 'DateTime':
        assert isinstance(obj, dict)
        date = from_union([from_float, from_none], obj.get("date"))
        assert date is None or 1 <= date
        assert date is None or date <= 31
        day = from_union([from_float, from_str, from_none], obj.get("day"))
        hours = from_union([from_float, from_none], obj.get("hours"))
        assert hours is None or 0 <= hours
        assert hours is None or hours <= 23
        milliseconds = from_union([from_float, from_none], obj.get("milliseconds"))
        assert milliseconds is None or 0 <= milliseconds
        assert milliseconds is None or milliseconds <= 999
        minutes = from_union([from_float, from_none], obj.get("minutes"))
        assert minutes is None or 0 <= minutes
        assert minutes is None or minutes <= 59
        month = from_union([from_float, from_str, from_none], obj.get("month"))
        quarter = from_union([from_float, from_none], obj.get("quarter"))
        assert quarter is None or 1 <= quarter
        assert quarter is None or quarter <= 4
        seconds = from_union([from_float, from_none], obj.get("seconds"))
        assert seconds is None or 0 <= seconds
        assert seconds is None or seconds <= 59
        utc = from_union([from_bool, from_none], obj.get("utc"))
        year = from_union([from_float, from_none], obj.get("year"))
        return DateTime(date, day, hours, milliseconds, minutes, month, quarter, seconds, utc, year)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.date is not None:
            result["date"] = from_union([to_float, from_none], self.date)
        if self.day is not None:
            result["day"] = from_union([to_float, from_str, from_none], self.day)
        if self.hours is not None:
            result["hours"] = from_union([to_float, from_none], self.hours)
        if self.milliseconds is not None:
            result["milliseconds"] = from_union([to_float, from_none], self.milliseconds)
        if self.minutes is not None:
            result["minutes"] = from_union([to_float, from_none], self.minutes)
        if self.month is not None:
            result["month"] = from_union([to_float, from_str, from_none], self.month)
        if self.quarter is not None:
            result["quarter"] = from_union([to_float, from_none], self.quarter)
        if self.seconds is not None:
            result["seconds"] = from_union([to_float, from_none], self.seconds)
        if self.utc is not None:
            result["utc"] = from_union([from_bool, from_none], self.utc)
        if self.year is not None:
            result["year"] = from_union([to_float, from_none], self.year)
        return result


class TimeUnit(Enum):
    """Time unit for the field to be filtered.
    
    time unit for the field to be filtered.
    
    Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    
    The timeUnit.
    """
    YEAR = "year"
    QUARTER = "quarter"
    MONTH = "month"
    DAY = "day"
    DATE = "date"
    HOURS = "hours"
    MINUTES = "minutes"
    SECONDS = "seconds"
    MILLISECONDS = "milliseconds"
    UTCYEAR = "utcyear"
    UTCQUARTER = "utcquarter"
    UTCMONTH = "utcmonth"
    UTCDAY = "utcday"
    UTCDATE = "utcdate"
    UTCHOURS = "utchours"
    UTCMINUTES = "utcminutes"
    UTCSECONDS = "utcseconds"
    UTCMILLISECONDS = "utcmilliseconds"
    YEARQUARTER = "yearquarter"
    YEARQUARTERMONTH = "yearquartermonth"
    YEARMONTH = "yearmonth"
    YEARMONTHDATE = "yearmonthdate"
    YEARMONTHDATEHOURS = "yearmonthdatehours"
    YEARMONTHDATEHOURSMINUTES = "yearmonthdatehoursminutes"
    YEARMONTHDATEHOURSMINUTESSECONDS = "yearmonthdatehoursminutesseconds"
    QUARTERMONTH = "quartermonth"
    MONTHDATE = "monthdate"
    HOURSMINUTES = "hoursminutes"
    HOURSMINUTESSECONDS = "hoursminutesseconds"
    MINUTESSECONDS = "minutesseconds"
    SECONDSMILLISECONDS = "secondsmilliseconds"
    UTCYEARQUARTER = "utcyearquarter"
    UTCYEARQUARTERMONTH = "utcyearquartermonth"
    UTCYEARMONTH = "utcyearmonth"
    UTCYEARMONTHDATE = "utcyearmonthdate"
    UTCYEARMONTHDATEHOURS = "utcyearmonthdatehours"
    UTCYEARMONTHDATEHOURSMINUTES = "utcyearmonthdatehoursminutes"
    UTCYEARMONTHDATEHOURSMINUTESSECONDS = "utcyearmonthdatehoursminutesseconds"
    UTCQUARTERMONTH = "utcquartermonth"
    UTCMONTHDATE = "utcmonthdate"
    UTCHOURSMINUTES = "utchoursminutes"
    UTCHOURSMINUTESSECONDS = "utchoursminutesseconds"
    UTCMINUTESSECONDS = "utcminutesseconds"
    UTCSECONDSMILLISECONDS = "utcsecondsmilliseconds"


@dataclass
class Predicate:
    predicate_not: 'Predicate | str | None' = None
    predicate_and: 'list[Predicate | str] | None' = None
    predicate_or: 'list[Predicate | str] | None' = None
    equal: float | bool | DateTime | str | None = None
    """The value that the field should be equal to."""

    field: str | None = None
    """Field to be filtered.
    
    Field to be filtered
    """
    time_unit: TimeUnit | None = None
    """Time unit for the field to be filtered.
    
    time unit for the field to be filtered.
    """
    range: list[float | DateTime | None] | None = None
    """An array of inclusive minimum and maximum values
    for a field value of a data item to be included in the filtered data.
    """
    one_of: list[float | bool | DateTime | str] | None = None
    """A set of values that the `field`'s value should be a member of,
    for a data item included in the filtered data.
    """
    selection: Selection | str | None = None
    """Filter using a selection name."""

    @staticmethod
    def from_dict(obj: Any) -> 'Predicate':
        assert isinstance(obj, dict)
        predicate_not = from_union([Predicate.from_dict, from_str, from_none], obj.get("not"))
        predicate_and = from_union([lambda x: from_list(lambda x: from_union([Predicate.from_dict, from_str], x), x), from_none], obj.get("and"))
        predicate_or = from_union([lambda x: from_list(lambda x: from_union([Predicate.from_dict, from_str], x), x), from_none], obj.get("or"))
        equal = from_union([from_float, from_bool, DateTime.from_dict, from_str, from_none], obj.get("equal"))
        field = from_union([from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        range = from_union([lambda x: from_list(lambda x: from_union([from_float, DateTime.from_dict, from_none], x), x), from_none], obj.get("range"))
        assert range is None or 2 <= len(range)
        assert range is None or len(range) <= 2
        one_of = from_union([lambda x: from_list(lambda x: from_union([from_float, from_bool, DateTime.from_dict, from_str], x), x), from_none], obj.get("oneOf"))
        selection = from_union([Selection.from_dict, from_str, from_none], obj.get("selection"))
        return Predicate(predicate_not, predicate_and, predicate_or, equal, field, time_unit, range, one_of, selection)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.predicate_not is not None:
            result["not"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.predicate_not)
        if self.predicate_and is not None:
            result["and"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(Predicate, x), from_str], x), x), from_none], self.predicate_and)
        if self.predicate_or is not None:
            result["or"] = from_union([lambda x: from_list(lambda x: from_union([lambda x: to_class(Predicate, x), from_str], x), x), from_none], self.predicate_or)
        if self.equal is not None:
            result["equal"] = from_union([to_float, from_bool, lambda x: to_class(DateTime, x), from_str, from_none], self.equal)
        if self.field is not None:
            result["field"] = from_union([from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.range is not None:
            result["range"] = from_union([lambda x: from_list(lambda x: from_union([to_float, lambda x: to_class(DateTime, x), from_none], x), x), from_none], self.range)
        if self.one_of is not None:
            result["oneOf"] = from_union([lambda x: from_list(lambda x: from_union([to_float, from_bool, lambda x: to_class(DateTime, x), from_str], x), x), from_none], self.one_of)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection)
        return result


@dataclass
class ConditionalValueDef:
    value: float | bool | str
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """
    test: Predicate | str | None = None
    selection: Selection | str | None = None
    """A [selection name](selection.html), or a series of [composed
    selections](selection.html#compose).
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ConditionalValueDef':
        assert isinstance(obj, dict)
        value = from_union([from_float, from_bool, from_str], obj["value"])
        test = from_union([Predicate.from_dict, from_str, from_none], obj.get("test"))
        selection = from_union([Selection.from_dict, from_str, from_none], obj.get("selection"))
        return ConditionalValueDef(value, test, selection)

    def to_dict(self) -> dict:
        result: dict = {}
        result["value"] = from_union([to_float, from_bool, from_str], self.value)
        if self.test is not None:
            result["test"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.test)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection)
        return result


class RepeatEnum(Enum):
    ROW = "row"
    COLUMN = "column"


@dataclass
class RepeatRef:
    """Reference to a repeated value."""

    repeat: RepeatEnum

    @staticmethod
    def from_dict(obj: Any) -> 'RepeatRef':
        assert isinstance(obj, dict)
        repeat = RepeatEnum(obj["repeat"])
        return RepeatRef(repeat)

    def to_dict(self) -> dict:
        result: dict = {}
        result["repeat"] = to_enum(RepeatEnum, self.repeat)
        return result


class LegendType(Enum):
    """The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
    continuous color gradient.
    
    __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
    `"symbol"` otherwise.
    """
    SYMBOL = "symbol"
    GRADIENT = "gradient"


@dataclass
class Legend:
    """Properties of a legend or boolean flag for determining whether to show it."""

    entry_padding: float | None = None
    """Padding (in pixels) between legend entries in a symbol legend."""

    format: str | None = None
    """The formatting pattern for labels. This is D3's [number format
    pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    field.
    
    See the [format documentation](format.html) for more information.
    
    __Default value:__  derived from [numberFormat](config.html#format) config for
    quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    """
    offset: float | None = None
    """The offset, in pixels, by which to displace the legend from the edge of the enclosing
    group or data rectangle.
    
    __Default value:__  `0`
    """
    orient: LegendOrient | None = None
    """The orientation of the legend, which determines how the legend is positioned within the
    scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
    "none".
    
    __Default value:__ `"right"`
    """
    padding: float | None = None
    """The padding, in pixels, between the legend and axis."""

    tick_count: float | None = None
    """The desired number of tick values for quantitative legends."""

    title: str | None = None
    """A title for the field. If `null`, the title will be removed.
    
    __Default value:__  derived from the field's name and transformation function
    (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    binned or has a time unit applied, the applied function will be denoted in parentheses
    (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    simply the field name.
    
    __Note__: You can customize the default field title format by providing the [`fieldTitle`
    property in the [config](config.html) or [`fieldTitle` function via the `compile`
    function's options](compile.html#field-title).
    """
    type: LegendType | None = None
    """The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
    continuous color gradient.
    
    __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
    `"symbol"` otherwise.
    """
    values: list[float | DateTime | str] | None = None
    """Explicitly set the visible legend values."""

    zindex: float | None = None
    """A non-positive integer indicating z-index of the legend.
    If zindex is 0, legend should be drawn behind all chart elements.
    To put them in front, use zindex = 1.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Legend':
        assert isinstance(obj, dict)
        entry_padding = from_union([from_float, from_none], obj.get("entryPadding"))
        format = from_union([from_str, from_none], obj.get("format"))
        offset = from_union([from_float, from_none], obj.get("offset"))
        orient = from_union([LegendOrient, from_none], obj.get("orient"))
        padding = from_union([from_float, from_none], obj.get("padding"))
        tick_count = from_union([from_float, from_none], obj.get("tickCount"))
        title = from_union([from_none, from_str], obj.get("title"))
        type = from_union([LegendType, from_none], obj.get("type"))
        values = from_union([lambda x: from_list(lambda x: from_union([from_float, DateTime.from_dict, from_str], x), x), from_none], obj.get("values"))
        zindex = from_union([from_float, from_none], obj.get("zindex"))
        assert zindex is None or 0 <= zindex
        return Legend(entry_padding, format, offset, orient, padding, tick_count, title, type, values, zindex)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.entry_padding is not None:
            result["entryPadding"] = from_union([to_float, from_none], self.entry_padding)
        if self.format is not None:
            result["format"] = from_union([from_str, from_none], self.format)
        if self.offset is not None:
            result["offset"] = from_union([to_float, from_none], self.offset)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(LegendOrient, x), from_none], self.orient)
        if self.padding is not None:
            result["padding"] = from_union([to_float, from_none], self.padding)
        if self.tick_count is not None:
            result["tickCount"] = from_union([to_float, from_none], self.tick_count)
        if self.title is not None:
            result["title"] = from_union([from_none, from_str], self.title)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(LegendType, x), from_none], self.type)
        if self.values is not None:
            result["values"] = from_union([lambda x: from_list(lambda x: from_union([to_float, lambda x: to_class(DateTime, x), from_str], x), x), from_none], self.values)
        if self.zindex is not None:
            result["zindex"] = from_union([to_float, from_none], self.zindex)
        return result


@dataclass
class DomainClass:
    selection: str
    """The name of a selection."""

    field: str | None = None
    """The field name to extract selected values for, when a selection is
    [projected](project.html)
    over multiple fields or encodings.
    """
    encoding: str | None = None
    """The encoding channel to extract selected values for, when a selection is
    [projected](project.html)
    over multiple fields or encodings.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'DomainClass':
        assert isinstance(obj, dict)
        selection = from_str(obj["selection"])
        field = from_union([from_str, from_none], obj.get("field"))
        encoding = from_union([from_str, from_none], obj.get("encoding"))
        return DomainClass(selection, field, encoding)

    def to_dict(self) -> dict:
        result: dict = {}
        result["selection"] = from_str(self.selection)
        if self.field is not None:
            result["field"] = from_union([from_str, from_none], self.field)
        if self.encoding is not None:
            result["encoding"] = from_union([from_str, from_none], self.encoding)
        return result


class Domain(Enum):
    UNAGGREGATED = "unaggregated"


class InterpolateParamsType(Enum):
    RGB = "rgb"
    CUBEHELIX = "cubehelix"
    CUBEHELIX_LONG = "cubehelix-long"


@dataclass
class InterpolateParams:
    type: InterpolateParamsType
    gamma: float | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'InterpolateParams':
        assert isinstance(obj, dict)
        type = InterpolateParamsType(obj["type"])
        gamma = from_union([from_float, from_none], obj.get("gamma"))
        return InterpolateParams(type, gamma)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(InterpolateParamsType, self.type)
        if self.gamma is not None:
            result["gamma"] = from_union([to_float, from_none], self.gamma)
        return result


@dataclass
class NiceClass:
    interval: str
    step: float

    @staticmethod
    def from_dict(obj: Any) -> 'NiceClass':
        assert isinstance(obj, dict)
        interval = from_str(obj["interval"])
        step = from_float(obj["step"])
        return NiceClass(interval, step)

    def to_dict(self) -> dict:
        result: dict = {}
        result["interval"] = from_str(self.interval)
        result["step"] = to_float(self.step)
        return result


class NiceTime(Enum):
    SECOND = "second"
    MINUTE = "minute"
    HOUR = "hour"
    DAY = "day"
    WEEK = "week"
    MONTH = "month"
    YEAR = "year"


@dataclass
class SchemeParams:
    name: str
    """A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
    
    For the full list of supported scheme, please refer to the [Vega
    Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    """
    extent: list[float] | None = None
    """For sequential and diverging schemes only, determines the extent of the color range to
    use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
    range _[0, 0.2)_ are excluded from the scheme.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'SchemeParams':
        assert isinstance(obj, dict)
        name = from_str(obj["name"])
        extent = from_union([lambda x: from_list(from_float, x), from_none], obj.get("extent"))
        return SchemeParams(name, extent)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        if self.extent is not None:
            result["extent"] = from_union([lambda x: from_list(to_float, x), from_none], self.extent)
        return result


class ScaleType(Enum):
    """The type of scale.  Vega-Lite supports the following categories of scale types:
    
    1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
    continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
    [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
    [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
    
    2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
    ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
    [`"point"`](scale.html#point)) output ranges.
    
    3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
    discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
    [`"bin-ordinal"`](scale.html#bin-ordinal)).
    
    __Default value:__ please see the [scale type table](scale.html#type).
    """
    LINEAR = "linear"
    BIN_LINEAR = "bin-linear"
    LOG = "log"
    POW = "pow"
    SQRT = "sqrt"
    TIME = "time"
    UTC = "utc"
    SEQUENTIAL = "sequential"
    ORDINAL = "ordinal"
    BIN_ORDINAL = "bin-ordinal"
    POINT = "point"
    BAND = "band"


@dataclass
class Scale:
    """An object defining properties of the channel's scale, which is the function that
    transforms values in the data domain (numbers, dates, strings, etc) to visual values
    (pixels, colors, sizes) of the encoding channels.
    
    __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    """
    base: float | None = None
    """The logarithm base of the `log` scale (default `10`)."""

    clamp: bool | None = None
    """If `true`, values that exceed the data domain are clamped to either the minimum or
    maximum range value
    
    __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
    (`true` by default).
    """
    domain: list[float | bool | DateTime | str] | DomainClass | Domain | None = None
    """Customized domain values.
    
    For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
    and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
    a `domain` with more than two entries.
    If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
    indicating that the domain should include the raw data values prior to the aggregation.
    
    For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
    the form of either timestamps or the [DateTime definition objects](types.html#datetime).
    
    For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
    values.
    
    The `selection` property can be used to [interactively
    determine](selection.html#scale-domains) the scale domain.
    """
    exponent: float | None = None
    """The exponent of the `pow` scale."""

    interpolate: InterpolateParams | Interpolate | None = None
    """The interpolation method for range values. By default, a general interpolator for
    numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
    property allows interpolation in alternative color spaces. Legal values include `rgb`,
    `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
    variants use longer paths in polar coordinate spaces). If object-valued, this property
    accepts an object with a string-valued _type_ property and an optional numeric _gamma_
    property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
    documentation](https://github.com/d3/d3-interpolate).
    
    __Note:__ Sequential scales do not support `interpolate` as they have a fixed
    interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
    you have to set the scale `type` to other quantitative scale type such as `"linear"` to
    customize `interpolate`.
    """
    nice: bool | float | NiceClass | NiceTime | None = None
    """Extending the domain so that it starts and ends on nice round values. This method
    typically modifies the scale’s domain, and may only extend the bounds to the nearest
    round value. Nicing is useful if the domain is computed from data and may be irregular.
    For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
    1.0]_.
    
    For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
    If `nice` is a number, it will represent a desired tick count. This allows greater
    control over the step size used to extend the bounds, guaranteeing that the returned
    ticks will exactly cover the domain.
    
    For temporal fields with time and utc scales, the `nice` value can be a string indicating
    the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
    `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
    scales can accept an object-valued interval specifier of the form `{"interval": "month",
    "step": 3}`, which includes a desired number of interval steps. Here, the domain would
    snap to quarter (Jan, Apr, Jul, Oct) boundaries.
    
    __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
    """
    padding: float | None = None
    """For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
    the specified number of pixels on each of the scale range. The scale range must represent
    pixels for this parameter to function as intended. Padding adjustment is performed prior
    to all other adjustments, including the effects of the zero, nice, domainMin, and
    domainMax properties.
    
    For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
    `paddingOuter` to the same value.
    
    For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
    
    __Default value:__ For _continuous_ scales, derived from the [scale
    config](scale.html#config)'s `continuousPadding`.
    For _band and point_ scales, see `paddingInner` and `paddingOuter`.
    """
    padding_inner: float | None = None
    """The inner padding (spacing) within each band step of band scales, as a fraction of the
    step size. This value must lie in the range [0,1].
    
    For point scale, this property is invalid as point scales do not have internal band
    widths (only step sizes between bands).
    
    __Default value:__ derived from the [scale config](scale.html#config)'s
    `bandPaddingInner`.
    """
    padding_outer: float | None = None
    """The outer padding (spacing) at the ends of the range of band and point scales,
    as a fraction of the step size. This value must lie in the range [0,1].
    
    __Default value:__ derived from the [scale config](scale.html#config)'s
    `bandPaddingOuter` for band scales and `pointPadding` for point scales.
    """
    range: list[float | str] | str | None = None
    """The range of the scale. One of:
    
    - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
    example, `"symbol"`, or `"diverging"`).
    
    - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
    and maximum values, or an array with more than two entries for specifying a [piecewise
    scale](scale.html#piecewise).
    
    - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
    an array of desired output values.
    
    __Notes:__
    
    1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
    discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
    instead of `range`.
    
    2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
    customized via the view's corresponding [size](size.html) (`width` and `height`) or via
    [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
    scales.
    """
    range_step: float | None = None
    """The distance between the starts of adjacent bands or points in [band](scale.html#band)
    and [point](scale.html#point) scales.
    
    If `rangeStep` is `null` or if the view contains the scale's corresponding
    [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
    be automatically determined to fit the size of the view.
    
    __Default value:__  derived the [scale config](config.html#scale-config)'s
    `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
    default) for x-scales of other marks and y-scales.
    
    __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
    than `width` or `height`, the rangeStep might become less than one pixel and the mark
    might not appear correctly.
    """
    round: bool | None = None
    """If `true`, rounds numeric output values to integers. This can be helpful for snapping to
    the pixel grid.
    
    __Default value:__ `false`.
    """
    scheme: SchemeParams | str | None = None
    """A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
    `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
    
    Discrete color schemes may be used with [discrete](scale.html#discrete) or
    [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
    use with [sequential](scales.html#sequential) scales.
    
    For the full list of supported scheme, please refer to the [Vega
    Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
    """
    type: ScaleType | None = None
    """The type of scale.  Vega-Lite supports the following categories of scale types:
    
    1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
    continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
    [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
    [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
    
    2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
    ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
    [`"point"`](scale.html#point)) output ranges.
    
    3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
    discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
    [`"bin-ordinal"`](scale.html#bin-ordinal)).
    
    __Default value:__ please see the [scale type table](scale.html#type).
    """
    zero: bool | None = None
    """If `true`, ensures that a zero baseline value is included in the scale domain.
    
    __Default value:__ `true` for x and y channels if the quantitative field is not binned
    and no custom `domain` is provided; `false` otherwise.
    
    __Note:__ Log, time, and utc scales do not support `zero`.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Scale':
        assert isinstance(obj, dict)
        base = from_union([from_float, from_none], obj.get("base"))
        clamp = from_union([from_bool, from_none], obj.get("clamp"))
        domain = from_union([lambda x: from_list(lambda x: from_union([from_float, from_bool, DateTime.from_dict, from_str], x), x), DomainClass.from_dict, Domain, from_none], obj.get("domain"))
        exponent = from_union([from_float, from_none], obj.get("exponent"))
        interpolate = from_union([InterpolateParams.from_dict, Interpolate, from_none], obj.get("interpolate"))
        nice = from_union([from_bool, from_float, NiceClass.from_dict, NiceTime, from_none], obj.get("nice"))
        padding = from_union([from_float, from_none], obj.get("padding"))
        assert padding is None or 0 <= padding
        padding_inner = from_union([from_float, from_none], obj.get("paddingInner"))
        assert padding_inner is None or 0 <= padding_inner
        assert padding_inner is None or padding_inner <= 1
        padding_outer = from_union([from_float, from_none], obj.get("paddingOuter"))
        assert padding_outer is None or 0 <= padding_outer
        assert padding_outer is None or padding_outer <= 1
        range = from_union([lambda x: from_list(lambda x: from_union([from_float, from_str], x), x), from_str, from_none], obj.get("range"))
        range_step = from_union([from_none, from_float], obj.get("rangeStep"))
        round = from_union([from_bool, from_none], obj.get("round"))
        scheme = from_union([SchemeParams.from_dict, from_str, from_none], obj.get("scheme"))
        type = from_union([ScaleType, from_none], obj.get("type"))
        zero = from_union([from_bool, from_none], obj.get("zero"))
        return Scale(base, clamp, domain, exponent, interpolate, nice, padding, padding_inner, padding_outer, range, range_step, round, scheme, type, zero)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.base is not None:
            result["base"] = from_union([to_float, from_none], self.base)
        if self.clamp is not None:
            result["clamp"] = from_union([from_bool, from_none], self.clamp)
        if self.domain is not None:
            result["domain"] = from_union([lambda x: from_list(lambda x: from_union([to_float, from_bool, lambda x: to_class(DateTime, x), from_str], x), x), lambda x: to_class(DomainClass, x), lambda x: to_enum(Domain, x), from_none], self.domain)
        if self.exponent is not None:
            result["exponent"] = from_union([to_float, from_none], self.exponent)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_class(InterpolateParams, x), lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.nice is not None:
            result["nice"] = from_union([from_bool, to_float, lambda x: to_class(NiceClass, x), lambda x: to_enum(NiceTime, x), from_none], self.nice)
        if self.padding is not None:
            result["padding"] = from_union([to_float, from_none], self.padding)
        if self.padding_inner is not None:
            result["paddingInner"] = from_union([to_float, from_none], self.padding_inner)
        if self.padding_outer is not None:
            result["paddingOuter"] = from_union([to_float, from_none], self.padding_outer)
        if self.range is not None:
            result["range"] = from_union([lambda x: from_list(lambda x: from_union([to_float, from_str], x), x), from_str, from_none], self.range)
        if self.range_step is not None:
            result["rangeStep"] = from_union([from_none, to_float], self.range_step)
        if self.round is not None:
            result["round"] = from_union([from_bool, from_none], self.round)
        if self.scheme is not None:
            result["scheme"] = from_union([lambda x: to_class(SchemeParams, x), from_str, from_none], self.scheme)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ScaleType, x), from_none], self.type)
        if self.zero is not None:
            result["zero"] = from_union([from_bool, from_none], self.zero)
        return result


class SortEnum(Enum):
    ASCENDING = "ascending"
    DESCENDING = "descending"


@dataclass
class SortField:
    op: AggregateOp
    """An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
    (e.g., `"count"`, `"mean"` and `"median"`).
    This property is required in cases where the sort field and the data reference field do
    not match.
    The input data objects will be aggregated, grouped by the encoded data field.
    
    For a full list of operations, please see the documentation for
    [aggregate](aggregate.html#ops).
    """
    field: RepeatRef | str | None = None
    """The data [field](field.html) to sort by.
    
    __Default value:__ If unspecified, defaults to the field specified in the outer data
    reference.
    """
    order: SortEnum | None = None
    """The sort order. One of `"ascending"` (default) or `"descending"`."""

    @staticmethod
    def from_dict(obj: Any) -> 'SortField':
        assert isinstance(obj, dict)
        op = AggregateOp(obj["op"])
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        order = from_union([from_none, SortEnum], obj.get("order"))
        return SortField(op, field, order)

    def to_dict(self) -> dict:
        result: dict = {}
        result["op"] = to_enum(AggregateOp, self.op)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.order is not None:
            result["order"] = from_union([from_none, lambda x: to_enum(SortEnum, x)], self.order)
        return result


class ConditionalPredicateValueDefType(Enum):
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    
    Constants and utilities for data type
    Data type based on level of measurement
    """
    QUANTITATIVE = "quantitative"
    ORDINAL = "ordinal"
    TEMPORAL = "temporal"
    NOMINAL = "nominal"
    LATITUDE = "latitude"
    LONGITUDE = "longitude"
    GEOJSON = "geojson"


@dataclass
class ConditionalPredicateMarkPropFieldDefClass:
    test: Predicate | str | None = None
    value: float | bool | str | None = None
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """
    selection: Selection | str | None = None
    """A [selection name](selection.html), or a series of [composed
    selections](selection.html#compose).
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    legend: Legend | None = None
    """An object defining properties of the legend.
    If `null`, the legend for the encoding channel will be removed.
    
    __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    """
    scale: Scale | None = None
    """An object defining properties of the channel's scale, which is the function that
    transforms values in the data domain (numbers, dates, strings, etc) to visual values
    (pixels, colors, sizes) of the encoding channels.
    
    __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    """
    sort: SortField | SortEnum | None = None
    """Sort order for the encoded field.
    Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    For fields with discrete domains, `sort` can also be a [sort field definition
    object](sort.html#sort-field).
    
    __Default value:__ `"ascending"`
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ConditionalPredicateMarkPropFieldDefClass':
        assert isinstance(obj, dict)
        test = from_union([Predicate.from_dict, from_str, from_none], obj.get("test"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        selection = from_union([Selection.from_dict, from_str, from_none], obj.get("selection"))
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        legend = from_union([Legend.from_dict, from_none], obj.get("legend"))
        scale = from_union([Scale.from_dict, from_none], obj.get("scale"))
        sort = from_union([from_none, SortField.from_dict, SortEnum], obj.get("sort"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        return ConditionalPredicateMarkPropFieldDefClass(test, value, selection, aggregate, bin, field, legend, scale, sort, time_unit, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.test is not None:
            result["test"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.test)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.legend is not None:
            result["legend"] = from_union([lambda x: to_class(Legend, x), from_none], self.legend)
        if self.scale is not None:
            result["scale"] = from_union([lambda x: to_class(Scale, x), from_none], self.scale)
        if self.sort is not None:
            result["sort"] = from_union([from_none, lambda x: to_class(SortField, x), lambda x: to_enum(SortEnum, x)], self.sort)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        return result


@dataclass
class MarkPropDefWithCondition:
    """Color of the marks – either fill or stroke color based on mark type.
    By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    
    __Default value:__ If undefined, the default color depends on [mark
    config](config.html#mark)'s `color` property.
    
    _Note:_ See the scale documentation for more information about customizing [color
    scheme](scale.html#scheme).
    
    Opacity of the marks – either can be a value or a range.
    
    __Default value:__ If undefined, the default opacity depends on [mark
    config](config.html#mark)'s `opacity` property.
    
    For `point` marks the supported values are
    `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    or `"triangle-down"`, or else a custom SVG path string.
    For `geoshape` marks it should be a field definition of the geojson data
    
    __Default value:__ If undefined, the default shape depends on [mark
    config](config.html#point-config)'s `shape` property.
    
    Size of the mark.
    - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    - For `"bar"` and `"tick"` – the bar and tick's size.
    - For `"text"` – the text's font size.
    - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    
    A FieldDef with Condition<ValueDef>
    {
    condition: {value: ...},
    field: ...,
    ...
    }
    
    A ValueDef with Condition<ValueDef | FieldDef>
    {
    condition: {field: ...} | {value: ...},
    value: ...,
    }
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    condition: ConditionalPredicateMarkPropFieldDefClass | list[ConditionalValueDef] | None = None
    """One or more value definition(s) with a selection predicate.
    
    __Note:__ A field definition's `condition` property can only contain [value
    definitions](encoding.html#value-def)
    since Vega-Lite only allows at most one encoded field per encoding channel.
    
    A field definition or one or more value definition(s) with a selection predicate.
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    legend: Legend | None = None
    """An object defining properties of the legend.
    If `null`, the legend for the encoding channel will be removed.
    
    __Default value:__ If undefined, default [legend properties](legend.html) are applied.
    """
    scale: Scale | None = None
    """An object defining properties of the channel's scale, which is the function that
    transforms values in the data domain (numbers, dates, strings, etc) to visual values
    (pixels, colors, sizes) of the encoding channels.
    
    __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    """
    sort: SortField | SortEnum | None = None
    """Sort order for the encoded field.
    Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    For fields with discrete domains, `sort` can also be a [sort field definition
    object](sort.html#sort-field).
    
    __Default value:__ `"ascending"`
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    value: float | bool | str | None = None
    """A constant value in visual domain."""

    @staticmethod
    def from_dict(obj: Any) -> 'MarkPropDefWithCondition':
        assert isinstance(obj, dict)
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        condition = from_union([ConditionalPredicateMarkPropFieldDefClass.from_dict, lambda x: from_list(ConditionalValueDef.from_dict, x), from_none], obj.get("condition"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        legend = from_union([Legend.from_dict, from_none], obj.get("legend"))
        scale = from_union([Scale.from_dict, from_none], obj.get("scale"))
        sort = from_union([from_none, SortField.from_dict, SortEnum], obj.get("sort"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        return MarkPropDefWithCondition(aggregate, bin, condition, field, legend, scale, sort, time_unit, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.condition is not None:
            result["condition"] = from_union([lambda x: to_class(ConditionalPredicateMarkPropFieldDefClass, x), lambda x: from_list(lambda x: to_class(ConditionalValueDef, x), x), from_none], self.condition)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.legend is not None:
            result["legend"] = from_union([lambda x: to_class(Legend, x), from_none], self.legend)
        if self.scale is not None:
            result["scale"] = from_union([lambda x: to_class(Scale, x), from_none], self.scale)
        if self.sort is not None:
            result["sort"] = from_union([from_none, lambda x: to_class(SortField, x), lambda x: to_enum(SortEnum, x)], self.sort)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        return result


@dataclass
class Header:
    """An object defining properties of a facet's header.
    
    Headers of row / column channels for faceted plots.
    """
    format: str | None = None
    """The formatting pattern for labels. This is D3's [number format
    pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    field.
    
    See the [format documentation](format.html) for more information.
    
    __Default value:__  derived from [numberFormat](config.html#format) config for
    quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    """
    label_angle: float | None = None
    """The rotation angle of the header labels.
    
    __Default value:__ `0`.
    """
    title: str | None = None
    """A title for the field. If `null`, the title will be removed.
    
    __Default value:__  derived from the field's name and transformation function
    (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    binned or has a time unit applied, the applied function will be denoted in parentheses
    (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    simply the field name.
    
    __Note__: You can customize the default field title format by providing the [`fieldTitle`
    property in the [config](config.html) or [`fieldTitle` function via the `compile`
    function's options](compile.html#field-title).
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Header':
        assert isinstance(obj, dict)
        format = from_union([from_str, from_none], obj.get("format"))
        label_angle = from_union([from_float, from_none], obj.get("labelAngle"))
        assert label_angle is None or -360 <= label_angle
        assert label_angle is None or label_angle <= 360
        title = from_union([from_none, from_str], obj.get("title"))
        return Header(format, label_angle, title)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.format is not None:
            result["format"] = from_union([from_str, from_none], self.format)
        if self.label_angle is not None:
            result["labelAngle"] = from_union([to_float, from_none], self.label_angle)
        if self.title is not None:
            result["title"] = from_union([from_none, from_str], self.title)
        return result


@dataclass
class FacetFieldDef:
    """Horizontal facets for trellis plots.
    
    Vertical facets for trellis plots.
    """
    type: ConditionalPredicateValueDefType
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    header: Header | None = None
    """An object defining properties of a facet's header."""

    sort: SortEnum | None = None
    """Sort order for a facet field.
    This can be `"ascending"`, `"descending"`.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """

    @staticmethod
    def from_dict(obj: Any) -> 'FacetFieldDef':
        assert isinstance(obj, dict)
        type = ConditionalPredicateValueDefType(obj["type"])
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        header = from_union([Header.from_dict, from_none], obj.get("header"))
        sort = from_union([from_none, SortEnum], obj.get("sort"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        return FacetFieldDef(type, aggregate, bin, field, header, sort, time_unit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(ConditionalPredicateValueDefType, self.type)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.header is not None:
            result["header"] = from_union([lambda x: to_class(Header, x), from_none], self.header)
        if self.sort is not None:
            result["sort"] = from_union([from_none, lambda x: to_enum(SortEnum, x)], self.sort)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        return result


@dataclass
class FieldDef:
    """Definition object for a data field, its type and transformation of an encoding channel."""

    type: ConditionalPredicateValueDefType
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """

    @staticmethod
    def from_dict(obj: Any) -> 'FieldDef':
        assert isinstance(obj, dict)
        type = ConditionalPredicateValueDefType(obj["type"])
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        return FieldDef(type, aggregate, bin, field, time_unit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(ConditionalPredicateValueDefType, self.type)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        return result


@dataclass
class ConditionalPredicateFieldDefClass:
    test: Predicate | str | None = None
    value: float | bool | str | None = None
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """
    selection: Selection | str | None = None
    """A [selection name](selection.html), or a series of [composed
    selections](selection.html#compose).
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ConditionalPredicateFieldDefClass':
        assert isinstance(obj, dict)
        test = from_union([Predicate.from_dict, from_str, from_none], obj.get("test"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        selection = from_union([Selection.from_dict, from_str, from_none], obj.get("selection"))
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        return ConditionalPredicateFieldDefClass(test, value, selection, aggregate, bin, field, time_unit, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.test is not None:
            result["test"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.test)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        return result


@dataclass
class DefWithCondition:
    """A URL to load upon mouse click.
    
    A FieldDef with Condition<ValueDef>
    {
    condition: {value: ...},
    field: ...,
    ...
    }
    
    A ValueDef with Condition<ValueDef | FieldDef>
    {
    condition: {field: ...} | {value: ...},
    value: ...,
    }
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    condition: ConditionalPredicateFieldDefClass | list[ConditionalValueDef] | None = None
    """One or more value definition(s) with a selection predicate.
    
    __Note:__ A field definition's `condition` property can only contain [value
    definitions](encoding.html#value-def)
    since Vega-Lite only allows at most one encoded field per encoding channel.
    
    A field definition or one or more value definition(s) with a selection predicate.
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    value: float | bool | str | None = None
    """A constant value in visual domain."""

    @staticmethod
    def from_dict(obj: Any) -> 'DefWithCondition':
        assert isinstance(obj, dict)
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        condition = from_union([ConditionalPredicateFieldDefClass.from_dict, lambda x: from_list(ConditionalValueDef.from_dict, x), from_none], obj.get("condition"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        return DefWithCondition(aggregate, bin, condition, field, time_unit, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.condition is not None:
            result["condition"] = from_union([lambda x: to_class(ConditionalPredicateFieldDefClass, x), lambda x: from_list(lambda x: to_class(ConditionalValueDef, x), x), from_none], self.condition)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        return result


@dataclass
class OrderFieldDef:
    type: ConditionalPredicateValueDefType
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    sort: SortEnum | None = None
    """The sort order. One of `"ascending"` (default) or `"descending"`."""

    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """

    @staticmethod
    def from_dict(obj: Any) -> 'OrderFieldDef':
        assert isinstance(obj, dict)
        type = ConditionalPredicateValueDefType(obj["type"])
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        sort = from_union([from_none, SortEnum], obj.get("sort"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        return OrderFieldDef(type, aggregate, bin, field, sort, time_unit)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(ConditionalPredicateValueDefType, self.type)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.sort is not None:
            result["sort"] = from_union([from_none, lambda x: to_enum(SortEnum, x)], self.sort)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        return result


@dataclass
class ConditionalPredicateTextFieldDefClass:
    test: Predicate | str | None = None
    value: float | bool | str | None = None
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """
    selection: Selection | str | None = None
    """A [selection name](selection.html), or a series of [composed
    selections](selection.html#compose).
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    format: str | None = None
    """The [formatting pattern](format.html) for a text field. If not defined, this will be
    determined automatically.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'ConditionalPredicateTextFieldDefClass':
        assert isinstance(obj, dict)
        test = from_union([Predicate.from_dict, from_str, from_none], obj.get("test"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        selection = from_union([Selection.from_dict, from_str, from_none], obj.get("selection"))
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        format = from_union([from_str, from_none], obj.get("format"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        return ConditionalPredicateTextFieldDefClass(test, value, selection, aggregate, bin, field, format, time_unit, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.test is not None:
            result["test"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.test)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: to_class(Selection, x), from_str, from_none], self.selection)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.format is not None:
            result["format"] = from_union([from_str, from_none], self.format)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        return result


@dataclass
class TextDefWithCondition:
    """Text of the `text` mark.
    
    The tooltip text to show upon mouse hover.
    
    A FieldDef with Condition<ValueDef>
    {
    condition: {value: ...},
    field: ...,
    ...
    }
    
    A ValueDef with Condition<ValueDef | FieldDef>
    {
    condition: {field: ...} | {value: ...},
    value: ...,
    }
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    condition: ConditionalPredicateTextFieldDefClass | list[ConditionalValueDef] | None = None
    """One or more value definition(s) with a selection predicate.
    
    __Note:__ A field definition's `condition` property can only contain [value
    definitions](encoding.html#value-def)
    since Vega-Lite only allows at most one encoded field per encoding channel.
    
    A field definition or one or more value definition(s) with a selection predicate.
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    format: str | None = None
    """The [formatting pattern](format.html) for a text field. If not defined, this will be
    determined automatically.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    value: float | bool | str | None = None
    """A constant value in visual domain."""

    @staticmethod
    def from_dict(obj: Any) -> 'TextDefWithCondition':
        assert isinstance(obj, dict)
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        condition = from_union([ConditionalPredicateTextFieldDefClass.from_dict, lambda x: from_list(ConditionalValueDef.from_dict, x), from_none], obj.get("condition"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        format = from_union([from_str, from_none], obj.get("format"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        return TextDefWithCondition(aggregate, bin, condition, field, format, time_unit, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.condition is not None:
            result["condition"] = from_union([lambda x: to_class(ConditionalPredicateTextFieldDefClass, x), lambda x: from_list(lambda x: to_class(ConditionalValueDef, x), x), from_none], self.condition)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.format is not None:
            result["format"] = from_union([from_str, from_none], self.format)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        return result


@dataclass
class Axis:
    domain: bool | None = None
    """A boolean flag indicating if the domain (the axis baseline) should be included as part of
    the axis.
    
    __Default value:__ `true`
    """
    format: str | None = None
    """The formatting pattern for labels. This is D3's [number format
    pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
    [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
    field.
    
    See the [format documentation](format.html) for more information.
    
    __Default value:__  derived from [numberFormat](config.html#format) config for
    quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
    """
    grid: bool | None = None
    """A boolean flag indicating if grid lines should be included as part of the axis
    
    __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
    binned; otherwise, `false`.
    """
    label_angle: float | None = None
    """The rotation angle of the axis labels.
    
    __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
    """
    label_bound: float | bool | None = None
    """Indicates if labels should be hidden if they exceed the axis range. If `false `(the
    default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
    they exceed the axis range by more than 1 pixel. If this property is a number, it
    specifies the pixel tolerance: the maximum amount by which a label bounding box may
    exceed the axis range.
    
    __Default value:__ `false`.
    """
    label_flush: float | bool | None = None
    """Indicates if the first and last axis labels should be aligned flush with the scale range.
    Flush alignment for a horizontal axis will left-align the first label and right-align the
    last label. For vertical axes, bottom and top text baselines are applied instead. If this
    property is a number, it also indicates the number of pixels by which to offset the first
    and last labels; for example, a value of 2 will flush-align the first and last labels and
    also push them 2 pixels outward from the center of the axis. The additional adjustment
    can sometimes help the labels better visually group with corresponding axis ticks.
    
    __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
    """
    label_overlap: bool | LabelOverlapEnum | None = None
    """The strategy to use for resolving overlap of axis labels. If `false` (the default), no
    overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
    every other label is used (this works well for standard linear axes). If set to
    `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
    with the last visible label (this often works better for log-scaled axes).
    
    __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
    scales; otherwise `false`.
    """
    label_padding: float | None = None
    """The padding, in pixels, between axis and text labels."""

    labels: bool | None = None
    """A boolean flag indicating if labels should be included as part of the axis.
    
    __Default value:__  `true`.
    """
    max_extent: float | None = None
    """The maximum extent in pixels that axis ticks and labels should use. This determines a
    maximum offset value for axis titles.
    
    __Default value:__ `undefined`.
    """
    min_extent: float | None = None
    """The minimum extent in pixels that axis ticks and labels should use. This determines a
    minimum offset value for axis titles.
    
    __Default value:__ `30` for y-axis; `undefined` for x-axis.
    """
    offset: float | None = None
    """The offset, in pixels, by which to displace the axis from the edge of the enclosing group
    or data rectangle.
    
    __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
    `offset` (`0` by default)
    """
    orient: TitleOrient | None = None
    """The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
    orientation can be used to further specialize the axis type (e.g., a y axis oriented for
    the right edge of the chart).
    
    __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
    """
    position: float | None = None
    """The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
    this sets the axis group x coordinate. For y-axis with left or right orientation, this
    sets the axis group y coordinate.
    
    __Default value__: `0`
    """
    tick_count: float | None = None
    """A desired number of ticks, for axes visualizing quantitative scales. The resulting number
    may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
    underlying scale's range.
    """
    ticks: bool | None = None
    """Boolean value that determines whether the axis should include ticks."""

    tick_size: float | None = None
    """The size in pixels of axis ticks."""

    title: str | None = None
    """A title for the field. If `null`, the title will be removed.
    
    __Default value:__  derived from the field's name and transformation function
    (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
    function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
    binned or has a time unit applied, the applied function will be denoted in parentheses
    (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
    simply the field name.
    
    __Note__: You can customize the default field title format by providing the [`fieldTitle`
    property in the [config](config.html) or [`fieldTitle` function via the `compile`
    function's options](compile.html#field-title).
    """
    title_max_length: float | None = None
    """Max length for axis title if the title is automatically generated from the field's
    description.
    """
    title_padding: float | None = None
    """The padding, in pixels, between title and axis."""

    values: list[float | DateTime] | None = None
    """Explicitly set the visible axis tick values."""

    zindex: float | None = None
    """A non-positive integer indicating z-index of the axis.
    If zindex is 0, axes should be drawn behind all chart elements.
    To put them in front, use `"zindex = 1"`.
    
    __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
    for grids.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Axis':
        assert isinstance(obj, dict)
        domain = from_union([from_bool, from_none], obj.get("domain"))
        format = from_union([from_str, from_none], obj.get("format"))
        grid = from_union([from_bool, from_none], obj.get("grid"))
        label_angle = from_union([from_float, from_none], obj.get("labelAngle"))
        assert label_angle is None or -360 <= label_angle
        assert label_angle is None or label_angle <= 360
        label_bound = from_union([from_float, from_bool, from_none], obj.get("labelBound"))
        label_flush = from_union([from_float, from_bool, from_none], obj.get("labelFlush"))
        label_overlap = from_union([from_bool, LabelOverlapEnum, from_none], obj.get("labelOverlap"))
        label_padding = from_union([from_float, from_none], obj.get("labelPadding"))
        labels = from_union([from_bool, from_none], obj.get("labels"))
        max_extent = from_union([from_float, from_none], obj.get("maxExtent"))
        min_extent = from_union([from_float, from_none], obj.get("minExtent"))
        offset = from_union([from_float, from_none], obj.get("offset"))
        orient = from_union([TitleOrient, from_none], obj.get("orient"))
        position = from_union([from_float, from_none], obj.get("position"))
        tick_count = from_union([from_float, from_none], obj.get("tickCount"))
        ticks = from_union([from_bool, from_none], obj.get("ticks"))
        tick_size = from_union([from_float, from_none], obj.get("tickSize"))
        assert tick_size is None or 0 <= tick_size
        title = from_union([from_none, from_str], obj.get("title"))
        title_max_length = from_union([from_float, from_none], obj.get("titleMaxLength"))
        title_padding = from_union([from_float, from_none], obj.get("titlePadding"))
        values = from_union([lambda x: from_list(lambda x: from_union([from_float, DateTime.from_dict], x), x), from_none], obj.get("values"))
        zindex = from_union([from_float, from_none], obj.get("zindex"))
        assert zindex is None or 0 <= zindex
        return Axis(domain, format, grid, label_angle, label_bound, label_flush, label_overlap, label_padding, labels, max_extent, min_extent, offset, orient, position, tick_count, ticks, tick_size, title, title_max_length, title_padding, values, zindex)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.domain is not None:
            result["domain"] = from_union([from_bool, from_none], self.domain)
        if self.format is not None:
            result["format"] = from_union([from_str, from_none], self.format)
        if self.grid is not None:
            result["grid"] = from_union([from_bool, from_none], self.grid)
        if self.label_angle is not None:
            result["labelAngle"] = from_union([to_float, from_none], self.label_angle)
        if self.label_bound is not None:
            result["labelBound"] = from_union([to_float, from_bool, from_none], self.label_bound)
        if self.label_flush is not None:
            result["labelFlush"] = from_union([to_float, from_bool, from_none], self.label_flush)
        if self.label_overlap is not None:
            result["labelOverlap"] = from_union([from_bool, lambda x: to_enum(LabelOverlapEnum, x), from_none], self.label_overlap)
        if self.label_padding is not None:
            result["labelPadding"] = from_union([to_float, from_none], self.label_padding)
        if self.labels is not None:
            result["labels"] = from_union([from_bool, from_none], self.labels)
        if self.max_extent is not None:
            result["maxExtent"] = from_union([to_float, from_none], self.max_extent)
        if self.min_extent is not None:
            result["minExtent"] = from_union([to_float, from_none], self.min_extent)
        if self.offset is not None:
            result["offset"] = from_union([to_float, from_none], self.offset)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(TitleOrient, x), from_none], self.orient)
        if self.position is not None:
            result["position"] = from_union([to_float, from_none], self.position)
        if self.tick_count is not None:
            result["tickCount"] = from_union([to_float, from_none], self.tick_count)
        if self.ticks is not None:
            result["ticks"] = from_union([from_bool, from_none], self.ticks)
        if self.tick_size is not None:
            result["tickSize"] = from_union([to_float, from_none], self.tick_size)
        if self.title is not None:
            result["title"] = from_union([from_none, from_str], self.title)
        if self.title_max_length is not None:
            result["titleMaxLength"] = from_union([to_float, from_none], self.title_max_length)
        if self.title_padding is not None:
            result["titlePadding"] = from_union([to_float, from_none], self.title_padding)
        if self.values is not None:
            result["values"] = from_union([lambda x: from_list(lambda x: from_union([to_float, lambda x: to_class(DateTime, x)], x), x), from_none], self.values)
        if self.zindex is not None:
            result["zindex"] = from_union([to_float, from_none], self.zindex)
        return result


@dataclass
class XClass:
    """X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
    
    Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
    
    Definition object for a constant value of an encoding channel.
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    axis: Axis | None = None
    """An object defining properties of axis's gridlines, ticks and labels.
    If `null`, the axis for the encoding channel will be removed.
    
    __Default value:__ If undefined, default [axis properties](axis.html) are applied.
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    scale: Scale | None = None
    """An object defining properties of the channel's scale, which is the function that
    transforms values in the data domain (numbers, dates, strings, etc) to visual values
    (pixels, colors, sizes) of the encoding channels.
    
    __Default value:__ If undefined, default [scale properties](scale.html) are applied.
    """
    sort: SortField | SortEnum | None = None
    """Sort order for the encoded field.
    Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
    For fields with discrete domains, `sort` can also be a [sort field definition
    object](sort.html#sort-field).
    
    __Default value:__ `"ascending"`
    """
    stack: StackOffset | None = None
    """Type of stacking offset if the field should be stacked.
    `stack` is only applicable for `x` and `y` channels with continuous domains.
    For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
    
    `stack` can be one of the following values:
    
    - `"zero"`: stacking with baseline offset at zero value of the scale (for creating
    typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
    - `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
    and area charts](stack.html#normalized). <br/>
    - `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
    - `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
    area chart.
    
    __Default value:__ `zero` for plots with all of the following conditions are true:
    
    1. The mark is `bar` or `area`;
    2. The stacked measure channel (x or y) has a linear scale;
    3. At least one of non-position channels mapped to an unaggregated field that is
    different from x and y.  Otherwise, `null` by default.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    value: float | bool | str | None = None
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """

    @staticmethod
    def from_dict(obj: Any) -> 'XClass':
        assert isinstance(obj, dict)
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        axis = from_union([Axis.from_dict, from_none], obj.get("axis"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        scale = from_union([Scale.from_dict, from_none], obj.get("scale"))
        sort = from_union([from_none, SortField.from_dict, SortEnum], obj.get("sort"))
        stack = from_union([StackOffset, from_none], obj.get("stack"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        return XClass(aggregate, axis, bin, field, scale, sort, stack, time_unit, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.axis is not None:
            result["axis"] = from_union([lambda x: to_class(Axis, x), from_none], self.axis)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.scale is not None:
            result["scale"] = from_union([lambda x: to_class(Scale, x), from_none], self.scale)
        if self.sort is not None:
            result["sort"] = from_union([from_none, lambda x: to_class(SortField, x), lambda x: to_enum(SortEnum, x)], self.sort)
        if self.stack is not None:
            result["stack"] = from_union([lambda x: to_enum(StackOffset, x), from_none], self.stack)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        return result


@dataclass
class X2Class:
    """X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    
    Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
    
    Definition object for a data field, its type and transformation of an encoding channel.
    
    Definition object for a constant value of an encoding channel.
    """
    aggregate: AggregateOp | None = None
    """Aggregation function for the field
    (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
    
    __Default value:__ `undefined` (None)
    """
    bin: bool | BinParams | None = None
    """A flag for binning a `quantitative` field, or [an object defining binning
    parameters](bin.html#params).
    If `true`, default [binning parameters](bin.html) will be applied.
    
    __Default value:__ `false`
    """
    field: RepeatRef | str | None = None
    """__Required.__ A string defining the name of the field from which to pull a data value
    or an object defining iterated values from the [`repeat`](repeat.html) operator.
    
    __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
    (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
    If field names contain dots or brackets but are not nested, you can use `\\\\` to escape
    dots and brackets (e.g., `"a\\\\.b"` and `"a\\\\[0\\\\]"`).
    See more details about escaping in the [field documentation](field.html).
    
    __Note:__ `field` is not required if `aggregate` is `count`.
    """
    time_unit: TimeUnit | None = None
    """Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
    or [a temporal field that gets casted as ordinal](type.html#cast).
    
    __Default value:__ `undefined` (None)
    """
    type: ConditionalPredicateValueDefType | None = None
    """The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
    `"nominal"`).
    It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
    [geographic projection](projection.html) is applied.
    """
    value: float | bool | str | None = None
    """A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
    `0` to `1` for opacity).
    """

    @staticmethod
    def from_dict(obj: Any) -> 'X2Class':
        assert isinstance(obj, dict)
        aggregate = from_union([AggregateOp, from_none], obj.get("aggregate"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([RepeatRef.from_dict, from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        type = from_union([ConditionalPredicateValueDefType, from_none], obj.get("type"))
        value = from_union([from_float, from_bool, from_str, from_none], obj.get("value"))
        return X2Class(aggregate, bin, field, time_unit, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: to_enum(AggregateOp, x), from_none], self.aggregate)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([lambda x: to_class(RepeatRef, x), from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(ConditionalPredicateValueDefType, x), from_none], self.type)
        if self.value is not None:
            result["value"] = from_union([to_float, from_bool, from_str, from_none], self.value)
        return result


@dataclass
class EncodingWithFacet:
    """A key-value mapping between encoding channels and definition of fields."""

    color: MarkPropDefWithCondition | None = None
    """Color of the marks – either fill or stroke color based on mark type.
    By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    
    __Default value:__ If undefined, the default color depends on [mark
    config](config.html#mark)'s `color` property.
    
    _Note:_ See the scale documentation for more information about customizing [color
    scheme](scale.html#scheme).
    """
    column: FacetFieldDef | None = None
    """Horizontal facets for trellis plots."""

    detail: FieldDef | list[FieldDef] | None = None
    """Additional levels of detail for grouping data in aggregate views and
    in line and area marks without mapping data to a specific visual channel.
    """
    href: DefWithCondition | None = None
    """A URL to load upon mouse click."""

    opacity: MarkPropDefWithCondition | None = None
    """Opacity of the marks – either can be a value or a range.
    
    __Default value:__ If undefined, the default opacity depends on [mark
    config](config.html#mark)'s `opacity` property.
    """
    order: OrderFieldDef | list[OrderFieldDef] | None = None
    """Stack order for stacked marks or order of data points in line marks for connected scatter
    plots.
    
    __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    additional aggregation grouping.
    """
    row: FacetFieldDef | None = None
    """Vertical facets for trellis plots."""

    shape: MarkPropDefWithCondition | None = None
    """For `point` marks the supported values are
    `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    or `"triangle-down"`, or else a custom SVG path string.
    For `geoshape` marks it should be a field definition of the geojson data
    
    __Default value:__ If undefined, the default shape depends on [mark
    config](config.html#point-config)'s `shape` property.
    """
    size: MarkPropDefWithCondition | None = None
    """Size of the mark.
    - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    - For `"bar"` and `"tick"` – the bar and tick's size.
    - For `"text"` – the text's font size.
    - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    """
    text: TextDefWithCondition | None = None
    """Text of the `text` mark."""

    tooltip: TextDefWithCondition | None = None
    """The tooltip text to show upon mouse hover."""

    x: XClass | None = None
    """X coordinates of the marks, or width of horizontal `"bar"` and `"area"`."""

    x2: X2Class | None = None
    """X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`."""

    y: XClass | None = None
    """Y coordinates of the marks, or height of vertical `"bar"` and `"area"`."""

    y2: X2Class | None = None
    """Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`."""

    @staticmethod
    def from_dict(obj: Any) -> 'EncodingWithFacet':
        assert isinstance(obj, dict)
        color = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("color"))
        column = from_union([FacetFieldDef.from_dict, from_none], obj.get("column"))
        detail = from_union([FieldDef.from_dict, lambda x: from_list(FieldDef.from_dict, x), from_none], obj.get("detail"))
        href = from_union([DefWithCondition.from_dict, from_none], obj.get("href"))
        opacity = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("opacity"))
        order = from_union([OrderFieldDef.from_dict, lambda x: from_list(OrderFieldDef.from_dict, x), from_none], obj.get("order"))
        row = from_union([FacetFieldDef.from_dict, from_none], obj.get("row"))
        shape = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("shape"))
        size = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("size"))
        text = from_union([TextDefWithCondition.from_dict, from_none], obj.get("text"))
        tooltip = from_union([TextDefWithCondition.from_dict, from_none], obj.get("tooltip"))
        x = from_union([XClass.from_dict, from_none], obj.get("x"))
        x2 = from_union([X2Class.from_dict, from_none], obj.get("x2"))
        y = from_union([XClass.from_dict, from_none], obj.get("y"))
        y2 = from_union([X2Class.from_dict, from_none], obj.get("y2"))
        return EncodingWithFacet(color, column, detail, href, opacity, order, row, shape, size, text, tooltip, x, x2, y, y2)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.color is not None:
            result["color"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.color)
        if self.column is not None:
            result["column"] = from_union([lambda x: to_class(FacetFieldDef, x), from_none], self.column)
        if self.detail is not None:
            result["detail"] = from_union([lambda x: to_class(FieldDef, x), lambda x: from_list(lambda x: to_class(FieldDef, x), x), from_none], self.detail)
        if self.href is not None:
            result["href"] = from_union([lambda x: to_class(DefWithCondition, x), from_none], self.href)
        if self.opacity is not None:
            result["opacity"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.opacity)
        if self.order is not None:
            result["order"] = from_union([lambda x: to_class(OrderFieldDef, x), lambda x: from_list(lambda x: to_class(OrderFieldDef, x), x), from_none], self.order)
        if self.row is not None:
            result["row"] = from_union([lambda x: to_class(FacetFieldDef, x), from_none], self.row)
        if self.shape is not None:
            result["shape"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.size)
        if self.text is not None:
            result["text"] = from_union([lambda x: to_class(TextDefWithCondition, x), from_none], self.text)
        if self.tooltip is not None:
            result["tooltip"] = from_union([lambda x: to_class(TextDefWithCondition, x), from_none], self.tooltip)
        if self.x is not None:
            result["x"] = from_union([lambda x: to_class(XClass, x), from_none], self.x)
        if self.x2 is not None:
            result["x2"] = from_union([lambda x: to_class(X2Class, x), from_none], self.x2)
        if self.y is not None:
            result["y"] = from_union([lambda x: to_class(XClass, x), from_none], self.y)
        if self.y2 is not None:
            result["y2"] = from_union([lambda x: to_class(X2Class, x), from_none], self.y2)
        return result


@dataclass
class FacetMapping:
    """An object that describes mappings between `row` and `column` channels and their field
    definitions.
    """
    column: FacetFieldDef | None = None
    """Horizontal facets for trellis plots."""

    row: FacetFieldDef | None = None
    """Vertical facets for trellis plots."""

    @staticmethod
    def from_dict(obj: Any) -> 'FacetMapping':
        assert isinstance(obj, dict)
        column = from_union([FacetFieldDef.from_dict, from_none], obj.get("column"))
        row = from_union([FacetFieldDef.from_dict, from_none], obj.get("row"))
        return FacetMapping(column, row)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.column is not None:
            result["column"] = from_union([lambda x: to_class(FacetFieldDef, x), from_none], self.column)
        if self.row is not None:
            result["row"] = from_union([lambda x: to_class(FacetFieldDef, x), from_none], self.row)
        return result


@dataclass
class Encoding:
    """A key-value mapping between encoding channels and definition of fields."""

    color: MarkPropDefWithCondition | None = None
    """Color of the marks – either fill or stroke color based on mark type.
    By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
    `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
    
    __Default value:__ If undefined, the default color depends on [mark
    config](config.html#mark)'s `color` property.
    
    _Note:_ See the scale documentation for more information about customizing [color
    scheme](scale.html#scheme).
    """
    detail: FieldDef | list[FieldDef] | None = None
    """Additional levels of detail for grouping data in aggregate views and
    in line and area marks without mapping data to a specific visual channel.
    """
    href: DefWithCondition | None = None
    """A URL to load upon mouse click."""

    opacity: MarkPropDefWithCondition | None = None
    """Opacity of the marks – either can be a value or a range.
    
    __Default value:__ If undefined, the default opacity depends on [mark
    config](config.html#mark)'s `opacity` property.
    """
    order: OrderFieldDef | list[OrderFieldDef] | None = None
    """Stack order for stacked marks or order of data points in line marks for connected scatter
    plots.
    
    __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
    additional aggregation grouping.
    """
    shape: MarkPropDefWithCondition | None = None
    """For `point` marks the supported values are
    `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
    or `"triangle-down"`, or else a custom SVG path string.
    For `geoshape` marks it should be a field definition of the geojson data
    
    __Default value:__ If undefined, the default shape depends on [mark
    config](config.html#point-config)'s `shape` property.
    """
    size: MarkPropDefWithCondition | None = None
    """Size of the mark.
    - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
    - For `"bar"` and `"tick"` – the bar and tick's size.
    - For `"text"` – the text's font size.
    - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
    """
    text: TextDefWithCondition | None = None
    """Text of the `text` mark."""

    tooltip: TextDefWithCondition | None = None
    """The tooltip text to show upon mouse hover."""

    x: XClass | None = None
    """X coordinates of the marks, or width of horizontal `"bar"` and `"area"`."""

    x2: X2Class | None = None
    """X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`."""

    y: XClass | None = None
    """Y coordinates of the marks, or height of vertical `"bar"` and `"area"`."""

    y2: X2Class | None = None
    """Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`."""

    @staticmethod
    def from_dict(obj: Any) -> 'Encoding':
        assert isinstance(obj, dict)
        color = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("color"))
        detail = from_union([FieldDef.from_dict, lambda x: from_list(FieldDef.from_dict, x), from_none], obj.get("detail"))
        href = from_union([DefWithCondition.from_dict, from_none], obj.get("href"))
        opacity = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("opacity"))
        order = from_union([OrderFieldDef.from_dict, lambda x: from_list(OrderFieldDef.from_dict, x), from_none], obj.get("order"))
        shape = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("shape"))
        size = from_union([MarkPropDefWithCondition.from_dict, from_none], obj.get("size"))
        text = from_union([TextDefWithCondition.from_dict, from_none], obj.get("text"))
        tooltip = from_union([TextDefWithCondition.from_dict, from_none], obj.get("tooltip"))
        x = from_union([XClass.from_dict, from_none], obj.get("x"))
        x2 = from_union([X2Class.from_dict, from_none], obj.get("x2"))
        y = from_union([XClass.from_dict, from_none], obj.get("y"))
        y2 = from_union([X2Class.from_dict, from_none], obj.get("y2"))
        return Encoding(color, detail, href, opacity, order, shape, size, text, tooltip, x, x2, y, y2)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.color is not None:
            result["color"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.color)
        if self.detail is not None:
            result["detail"] = from_union([lambda x: to_class(FieldDef, x), lambda x: from_list(lambda x: to_class(FieldDef, x), x), from_none], self.detail)
        if self.href is not None:
            result["href"] = from_union([lambda x: to_class(DefWithCondition, x), from_none], self.href)
        if self.opacity is not None:
            result["opacity"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.opacity)
        if self.order is not None:
            result["order"] = from_union([lambda x: to_class(OrderFieldDef, x), lambda x: from_list(lambda x: to_class(OrderFieldDef, x), x), from_none], self.order)
        if self.shape is not None:
            result["shape"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([lambda x: to_class(MarkPropDefWithCondition, x), from_none], self.size)
        if self.text is not None:
            result["text"] = from_union([lambda x: to_class(TextDefWithCondition, x), from_none], self.text)
        if self.tooltip is not None:
            result["tooltip"] = from_union([lambda x: to_class(TextDefWithCondition, x), from_none], self.tooltip)
        if self.x is not None:
            result["x"] = from_union([lambda x: to_class(XClass, x), from_none], self.x)
        if self.x2 is not None:
            result["x2"] = from_union([lambda x: to_class(X2Class, x), from_none], self.x2)
        if self.y is not None:
            result["y"] = from_union([lambda x: to_class(XClass, x), from_none], self.y)
        if self.y2 is not None:
            result["y2"] = from_union([lambda x: to_class(X2Class, x), from_none], self.y2)
        return result


class Mark(Enum):
    """All types of primitive marks.
    
    The mark type.
    One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
    `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
    """
    AREA = "area"
    BAR = "bar"
    LINE = "line"
    POINT = "point"
    TEXT = "text"
    TICK = "tick"
    RECT = "rect"
    RULE = "rule"
    CIRCLE = "circle"
    SQUARE = "square"
    GEOSHAPE = "geoshape"


@dataclass
class MarkDef:
    type: Mark
    """The mark type.
    One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
    `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
    """
    align: HorizontalAlign | None = None
    """The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`."""

    angle: float | None = None
    """The rotation angle of the text, in degrees."""

    baseline: VerticalAlign | None = None
    """The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
    
    __Default value:__ `"middle"`
    """
    clip: bool | None = None
    """Whether a mark be clipped to the enclosing group’s width and height."""

    color: str | None = None
    """Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
    will override `color`.
    
    __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    cursor: Cursor | None = None
    """The mouse cursor used over the mark. Any valid [CSS cursor
    type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
    """
    dx: float | None = None
    """The horizontal offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    dy: float | None = None
    """The vertical offset, in pixels, between the text label and its anchor point. The offset
    is applied after rotation by the _angle_ property.
    """
    fill: str | None = None
    """Default Fill Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    filled: bool | None = None
    """Whether the mark's color should be used as fill color instead of stroke color.
    
    __Default value:__ `true` for all marks except `point` and `false` for `point`.
    
    __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
    
    __Note:__ This property cannot be used in a [style config](mark.html#style-config).
    """
    fill_opacity: float | None = None
    """The fill opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    font: str | None = None
    """The typeface to set the text in (e.g., `"Helvetica Neue"`)."""

    font_size: float | None = None
    """The font size, in pixels."""

    font_style: FontStyle | None = None
    """The font style (e.g., `"italic"`)."""

    font_weight: float | FontWeight | None = None
    """The font weight (e.g., `"bold"`)."""

    href: str | None = None
    """A URL to load upon mouse click. If defined, the mark acts as a hyperlink."""

    interpolate: Interpolate | None = None
    """The line interpolation method to use for line and area marks. One of the following:
    - `"linear"`: piecewise linear segments, as in a polyline.
    - `"linear-closed"`: close the linear segments to form a polygon.
    - `"step"`: alternate between horizontal and vertical segments, as in a step function.
    - `"step-before"`: alternate between vertical and horizontal segments, as in a step
    function.
    - `"step-after"`: alternate between horizontal and vertical segments, as in a step
    function.
    - `"basis"`: a B-spline, with control point duplication on the ends.
    - `"basis-open"`: an open B-spline; may not intersect the start or end.
    - `"basis-closed"`: a closed B-spline, as in a loop.
    - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
    - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
    will intersect other control points.
    - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
    - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
    spline.
    - `"monotone"`: cubic interpolation that preserves monotonicity in y.
    """
    limit: float | None = None
    """The maximum length of the text mark in pixels (default 0, indicating no limit). The text
    value will be automatically truncated if the rendered size exceeds the limit.
    """
    opacity: float | None = None
    """The overall opacity (value between [0,1]).
    
    __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
    `square` marks or layered `bar` charts and `1` otherwise.
    """
    orient: Orient | None = None
    """The orientation of a non-stacked bar, tick, area, and line charts.
    The value is either horizontal (default) or vertical.
    - For bar, rule and tick, this determines whether the size of the bar and tick
    should be applied to x or y dimension.
    - For area, this property determines the orient property of the Vega output.
    - For line, this property determines the sort order of the points in the line
    if `config.sortLineBy` is not specified.
    For stacked charts, this is always determined by the orientation of the stack;
    therefore explicitly specified value will be ignored.
    """
    radius: float | None = None
    """Polar coordinate radial offset, in pixels, of the text label from the origin determined
    by the `x` and `y` properties.
    """
    shape: str | None = None
    """The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
    `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
    
    __Default value:__ `"circle"`
    """
    size: float | None = None
    """The pixel area each the point/circle/square.
    For example: in the case of circles, the radius is determined in part by the square root
    of the size value.
    
    __Default value:__ `30`
    """
    stroke: str | None = None
    """Default Stroke Color.  This has higher precedence than config.color
    
    __Default value:__ (None)
    """
    stroke_dash: list[float] | None = None
    """An array of alternating stroke, space lengths for creating dashed or dotted lines."""

    stroke_dash_offset: float | None = None
    """The offset (in pixels) into which to begin drawing with the stroke dash array."""

    stroke_opacity: float | None = None
    """The stroke opacity (value between [0,1]).
    
    __Default value:__ `1`
    """
    stroke_width: float | None = None
    """The stroke width, in pixels."""

    style: list[str] | str | None = None
    """A string or array of strings indicating the name of custom styles to apply to the mark. A
    style is a named collection of mark property defaults defined within the [style
    configuration](mark.html#style-config). If style is an array, later styles will override
    earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
    the `encoding` will override a style default.
    
    __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
    default.
    __Note:__ Any specified style will augment the default style. For example, a bar mark
    with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
    specified style `"foo"` has higher precedence).
    """
    tension: float | None = None
    """Depending on the interpolation type, sets the tension parameter (for line and area marks)."""

    text: str | None = None
    """Placeholder text if the `text` channel is not specified"""

    theta: float | None = None
    """Polar coordinate angle, in radians, of the text label from the origin determined by the
    `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
    `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
    indicating "north".
    """

    @staticmethod
    def from_dict(obj: Any) -> 'MarkDef':
        assert isinstance(obj, dict)
        type = Mark(obj["type"])
        align = from_union([HorizontalAlign, from_none], obj.get("align"))
        angle = from_union([from_float, from_none], obj.get("angle"))
        assert angle is None or 0 <= angle
        assert angle is None or angle <= 360
        baseline = from_union([VerticalAlign, from_none], obj.get("baseline"))
        clip = from_union([from_bool, from_none], obj.get("clip"))
        color = from_union([from_str, from_none], obj.get("color"))
        cursor = from_union([Cursor, from_none], obj.get("cursor"))
        dx = from_union([from_float, from_none], obj.get("dx"))
        dy = from_union([from_float, from_none], obj.get("dy"))
        fill = from_union([from_str, from_none], obj.get("fill"))
        filled = from_union([from_bool, from_none], obj.get("filled"))
        fill_opacity = from_union([from_float, from_none], obj.get("fillOpacity"))
        assert fill_opacity is None or 0 <= fill_opacity
        assert fill_opacity is None or fill_opacity <= 1
        font = from_union([from_str, from_none], obj.get("font"))
        font_size = from_union([from_float, from_none], obj.get("fontSize"))
        assert font_size is None or 0 <= font_size
        font_style = from_union([FontStyle, from_none], obj.get("fontStyle"))
        font_weight = from_union([from_float, FontWeight, from_none], obj.get("fontWeight"))
        href = from_union([from_str, from_none], obj.get("href"))
        interpolate = from_union([Interpolate, from_none], obj.get("interpolate"))
        limit = from_union([from_float, from_none], obj.get("limit"))
        opacity = from_union([from_float, from_none], obj.get("opacity"))
        assert opacity is None or 0 <= opacity
        assert opacity is None or opacity <= 1
        orient = from_union([Orient, from_none], obj.get("orient"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        assert radius is None or 0 <= radius
        shape = from_union([from_str, from_none], obj.get("shape"))
        size = from_union([from_float, from_none], obj.get("size"))
        assert size is None or 0 <= size
        stroke = from_union([from_str, from_none], obj.get("stroke"))
        stroke_dash = from_union([lambda x: from_list(from_float, x), from_none], obj.get("strokeDash"))
        stroke_dash_offset = from_union([from_float, from_none], obj.get("strokeDashOffset"))
        stroke_opacity = from_union([from_float, from_none], obj.get("strokeOpacity"))
        assert stroke_opacity is None or 0 <= stroke_opacity
        assert stroke_opacity is None or stroke_opacity <= 1
        stroke_width = from_union([from_float, from_none], obj.get("strokeWidth"))
        assert stroke_width is None or 0 <= stroke_width
        style = from_union([lambda x: from_list(from_str, x), from_str, from_none], obj.get("style"))
        tension = from_union([from_float, from_none], obj.get("tension"))
        assert tension is None or 0 <= tension
        assert tension is None or tension <= 1
        text = from_union([from_str, from_none], obj.get("text"))
        theta = from_union([from_float, from_none], obj.get("theta"))
        return MarkDef(type, align, angle, baseline, clip, color, cursor, dx, dy, fill, filled, fill_opacity, font, font_size, font_style, font_weight, href, interpolate, limit, opacity, orient, radius, shape, size, stroke, stroke_dash, stroke_dash_offset, stroke_opacity, stroke_width, style, tension, text, theta)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(Mark, self.type)
        if self.align is not None:
            result["align"] = from_union([lambda x: to_enum(HorizontalAlign, x), from_none], self.align)
        if self.angle is not None:
            result["angle"] = from_union([to_float, from_none], self.angle)
        if self.baseline is not None:
            result["baseline"] = from_union([lambda x: to_enum(VerticalAlign, x), from_none], self.baseline)
        if self.clip is not None:
            result["clip"] = from_union([from_bool, from_none], self.clip)
        if self.color is not None:
            result["color"] = from_union([from_str, from_none], self.color)
        if self.cursor is not None:
            result["cursor"] = from_union([lambda x: to_enum(Cursor, x), from_none], self.cursor)
        if self.dx is not None:
            result["dx"] = from_union([to_float, from_none], self.dx)
        if self.dy is not None:
            result["dy"] = from_union([to_float, from_none], self.dy)
        if self.fill is not None:
            result["fill"] = from_union([from_str, from_none], self.fill)
        if self.filled is not None:
            result["filled"] = from_union([from_bool, from_none], self.filled)
        if self.fill_opacity is not None:
            result["fillOpacity"] = from_union([to_float, from_none], self.fill_opacity)
        if self.font is not None:
            result["font"] = from_union([from_str, from_none], self.font)
        if self.font_size is not None:
            result["fontSize"] = from_union([to_float, from_none], self.font_size)
        if self.font_style is not None:
            result["fontStyle"] = from_union([lambda x: to_enum(FontStyle, x), from_none], self.font_style)
        if self.font_weight is not None:
            result["fontWeight"] = from_union([to_float, lambda x: to_enum(FontWeight, x), from_none], self.font_weight)
        if self.href is not None:
            result["href"] = from_union([from_str, from_none], self.href)
        if self.interpolate is not None:
            result["interpolate"] = from_union([lambda x: to_enum(Interpolate, x), from_none], self.interpolate)
        if self.limit is not None:
            result["limit"] = from_union([to_float, from_none], self.limit)
        if self.opacity is not None:
            result["opacity"] = from_union([to_float, from_none], self.opacity)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(Orient, x), from_none], self.orient)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.shape is not None:
            result["shape"] = from_union([from_str, from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([to_float, from_none], self.size)
        if self.stroke is not None:
            result["stroke"] = from_union([from_str, from_none], self.stroke)
        if self.stroke_dash is not None:
            result["strokeDash"] = from_union([lambda x: from_list(to_float, x), from_none], self.stroke_dash)
        if self.stroke_dash_offset is not None:
            result["strokeDashOffset"] = from_union([to_float, from_none], self.stroke_dash_offset)
        if self.stroke_opacity is not None:
            result["strokeOpacity"] = from_union([to_float, from_none], self.stroke_opacity)
        if self.stroke_width is not None:
            result["strokeWidth"] = from_union([to_float, from_none], self.stroke_width)
        if self.style is not None:
            result["style"] = from_union([lambda x: from_list(from_str, x), from_str, from_none], self.style)
        if self.tension is not None:
            result["tension"] = from_union([to_float, from_none], self.tension)
        if self.text is not None:
            result["text"] = from_union([from_str, from_none], self.text)
        if self.theta is not None:
            result["theta"] = from_union([to_float, from_none], self.theta)
        return result


@dataclass
class Projection:
    """An object defining properties of geographic projection.
    
    Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    """
    center: list[float] | None = None
    """Sets the projection’s center to the specified center, a two-element array of longitude
    and latitude in degrees.
    
    __Default value:__ `[0, 0]`
    """
    clip_angle: float | None = None
    """Sets the projection’s clipping circle radius to the specified angle in degrees. If
    `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
    than small-circle clipping.
    """
    clip_extent: list[list[float]] | None = None
    """Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
    bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
    the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
    viewport clipping is performed.
    """
    coefficient: float | None = None
    distance: float | None = None
    fraction: float | None = None
    lobes: float | None = None
    parallel: float | None = None
    precision: dict[str, float | str] | None = None
    """Sets the threshold for the projection’s [adaptive
    resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
    value corresponds to the [Douglas–Peucker
    distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
    If precision is not specified, returns the projection’s current resampling precision
    which defaults to `√0.5 ≅ 0.70710…`.
    """
    radius: float | None = None
    ratio: float | None = None
    rotate: list[float] | None = None
    """Sets the projection’s three-axis rotation to the specified angles, which must be a two-
    or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
    angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
    
    __Default value:__ `[0, 0, 0]`
    """
    spacing: float | None = None
    tilt: float | None = None
    type: VGProjectionType | None = None
    """The cartographic projection to use. This value is case-insensitive, for example
    `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
    projection types [in the
    documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
    
    __Default value:__ `mercator`
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Projection':
        assert isinstance(obj, dict)
        center = from_union([lambda x: from_list(from_float, x), from_none], obj.get("center"))
        clip_angle = from_union([from_float, from_none], obj.get("clipAngle"))
        clip_extent = from_union([lambda x: from_list(lambda x: from_list(from_float, x), x), from_none], obj.get("clipExtent"))
        coefficient = from_union([from_float, from_none], obj.get("coefficient"))
        distance = from_union([from_float, from_none], obj.get("distance"))
        fraction = from_union([from_float, from_none], obj.get("fraction"))
        lobes = from_union([from_float, from_none], obj.get("lobes"))
        parallel = from_union([from_float, from_none], obj.get("parallel"))
        precision = from_union([lambda x: from_dict(lambda x: from_union([from_float, from_str], x), x), from_none], obj.get("precision"))
        radius = from_union([from_float, from_none], obj.get("radius"))
        ratio = from_union([from_float, from_none], obj.get("ratio"))
        rotate = from_union([lambda x: from_list(from_float, x), from_none], obj.get("rotate"))
        spacing = from_union([from_float, from_none], obj.get("spacing"))
        tilt = from_union([from_float, from_none], obj.get("tilt"))
        type = from_union([VGProjectionType, from_none], obj.get("type"))
        return Projection(center, clip_angle, clip_extent, coefficient, distance, fraction, lobes, parallel, precision, radius, ratio, rotate, spacing, tilt, type)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.center is not None:
            result["center"] = from_union([lambda x: from_list(to_float, x), from_none], self.center)
        if self.clip_angle is not None:
            result["clipAngle"] = from_union([to_float, from_none], self.clip_angle)
        if self.clip_extent is not None:
            result["clipExtent"] = from_union([lambda x: from_list(lambda x: from_list(to_float, x), x), from_none], self.clip_extent)
        if self.coefficient is not None:
            result["coefficient"] = from_union([to_float, from_none], self.coefficient)
        if self.distance is not None:
            result["distance"] = from_union([to_float, from_none], self.distance)
        if self.fraction is not None:
            result["fraction"] = from_union([to_float, from_none], self.fraction)
        if self.lobes is not None:
            result["lobes"] = from_union([to_float, from_none], self.lobes)
        if self.parallel is not None:
            result["parallel"] = from_union([to_float, from_none], self.parallel)
        if self.precision is not None:
            result["precision"] = from_union([lambda x: from_dict(lambda x: from_union([to_float, from_str], x), x), from_none], self.precision)
        if self.radius is not None:
            result["radius"] = from_union([to_float, from_none], self.radius)
        if self.ratio is not None:
            result["ratio"] = from_union([to_float, from_none], self.ratio)
        if self.rotate is not None:
            result["rotate"] = from_union([lambda x: from_list(to_float, x), from_none], self.rotate)
        if self.spacing is not None:
            result["spacing"] = from_union([to_float, from_none], self.spacing)
        if self.tilt is not None:
            result["tilt"] = from_union([to_float, from_none], self.tilt)
        if self.type is not None:
            result["type"] = from_union([lambda x: to_enum(VGProjectionType, x), from_none], self.type)
        return result


class ResolveMode(Enum):
    INDEPENDENT = "independent"
    SHARED = "shared"


@dataclass
class AxisResolveMap:
    x: ResolveMode | None = None
    y: ResolveMode | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'AxisResolveMap':
        assert isinstance(obj, dict)
        x = from_union([ResolveMode, from_none], obj.get("x"))
        y = from_union([ResolveMode, from_none], obj.get("y"))
        return AxisResolveMap(x, y)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.x is not None:
            result["x"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.x)
        if self.y is not None:
            result["y"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.y)
        return result


@dataclass
class LegendResolveMap:
    color: ResolveMode | None = None
    opacity: ResolveMode | None = None
    shape: ResolveMode | None = None
    size: ResolveMode | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'LegendResolveMap':
        assert isinstance(obj, dict)
        color = from_union([ResolveMode, from_none], obj.get("color"))
        opacity = from_union([ResolveMode, from_none], obj.get("opacity"))
        shape = from_union([ResolveMode, from_none], obj.get("shape"))
        size = from_union([ResolveMode, from_none], obj.get("size"))
        return LegendResolveMap(color, opacity, shape, size)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.color is not None:
            result["color"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.color)
        if self.opacity is not None:
            result["opacity"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.opacity)
        if self.shape is not None:
            result["shape"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.size)
        return result


@dataclass
class ScaleResolveMap:
    color: ResolveMode | None = None
    opacity: ResolveMode | None = None
    shape: ResolveMode | None = None
    size: ResolveMode | None = None
    x: ResolveMode | None = None
    y: ResolveMode | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'ScaleResolveMap':
        assert isinstance(obj, dict)
        color = from_union([ResolveMode, from_none], obj.get("color"))
        opacity = from_union([ResolveMode, from_none], obj.get("opacity"))
        shape = from_union([ResolveMode, from_none], obj.get("shape"))
        size = from_union([ResolveMode, from_none], obj.get("size"))
        x = from_union([ResolveMode, from_none], obj.get("x"))
        y = from_union([ResolveMode, from_none], obj.get("y"))
        return ScaleResolveMap(color, opacity, shape, size, x, y)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.color is not None:
            result["color"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.color)
        if self.opacity is not None:
            result["opacity"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.opacity)
        if self.shape is not None:
            result["shape"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.shape)
        if self.size is not None:
            result["size"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.size)
        if self.x is not None:
            result["x"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.x)
        if self.y is not None:
            result["y"] = from_union([lambda x: to_enum(ResolveMode, x), from_none], self.y)
        return result


@dataclass
class Resolve:
    """Scale, axis, and legend resolutions for layers.
    
    Defines how scales, axes, and legends from different specs should be combined. Resolve is
    a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
    
    Scale, axis, and legend resolutions for facets.
    
    Scale and legend resolutions for repeated charts.
    
    Scale, axis, and legend resolutions for vertically concatenated charts.
    
    Scale, axis, and legend resolutions for horizontally concatenated charts.
    """
    axis: AxisResolveMap | None = None
    legend: LegendResolveMap | None = None
    scale: ScaleResolveMap | None = None

    @staticmethod
    def from_dict(obj: Any) -> 'Resolve':
        assert isinstance(obj, dict)
        axis = from_union([AxisResolveMap.from_dict, from_none], obj.get("axis"))
        legend = from_union([LegendResolveMap.from_dict, from_none], obj.get("legend"))
        scale = from_union([ScaleResolveMap.from_dict, from_none], obj.get("scale"))
        return Resolve(axis, legend, scale)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.axis is not None:
            result["axis"] = from_union([lambda x: to_class(AxisResolveMap, x), from_none], self.axis)
        if self.legend is not None:
            result["legend"] = from_union([lambda x: to_class(LegendResolveMap, x), from_none], self.legend)
        if self.scale is not None:
            result["scale"] = from_union([lambda x: to_class(ScaleResolveMap, x), from_none], self.scale)
        return result


class SelectionDefType(Enum):
    SINGLE = "single"
    MULTI = "multi"
    INTERVAL = "interval"


@dataclass
class SelectionDef:
    type: SelectionDefType
    bind: dict[str, VGBinding] | BindEnum | None = None
    """Establish a two-way binding between a single selection and input elements
    (also known as dynamic query widgets). A binding takes the form of
    Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
    or can be a mapping between projected field/encodings and binding definitions.
    
    See the [bind transform](bind.html) documentation for more information.
    
    Establishes a two-way binding between the interval selection and the scales
    used within the same view. This allows a user to interactively pan and
    zoom the view.
    """
    empty: Empty | None = None
    """By default, all data values are considered to lie within an empty selection.
    When set to `none`, empty selections contain no data values.
    """
    encodings: list[SingleDefChannel] | None = None
    """An array of encoding channels. The corresponding data field values
    must match for a data tuple to fall within the selection.
    """
    fields: list[str] | None = None
    """An array of field names whose values must match for a data tuple to
    fall within the selection.
    """
    nearest: bool | None = None
    """When true, an invisible voronoi diagram is computed to accelerate discrete
    selection. The data value _nearest_ the mouse cursor is added to the selection.
    
    See the [nearest transform](nearest.html) documentation for more information.
    """
    on: Any = None
    """A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
    selector) that triggers the selection.
    For interval selections, the event stream must specify a [start and
    end](https://vega.github.io/vega/docs/event-streams/#between-filters).
    """
    resolve: SelectionResolution | None = None
    """With layered and multi-view displays, a strategy that determines how
    selections' data queries are resolved when applied in a filter transform,
    conditional encoding rule, or scale domain.
    """
    toggle: bool | str | None = None
    """Controls whether data values should be toggled or only ever inserted into
    multi selections. Can be `true`, `false` (for insertion only), or a
    [Vega expression](https://vega.github.io/vega/docs/expressions/).
    
    __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
    data values are toggled when a user interacts with the shift-key pressed).
    
    See the [toggle transform](toggle.html) documentation for more information.
    """
    mark: BrushConfig | None = None
    """An interval selection also adds a rectangle mark to depict the
    extents of the interval. The `mark` property can be used to customize the
    appearance of the mark.
    """
    translate: bool | str | None = None
    """When truthy, allows a user to interactively move an interval selection
    back-and-forth. Can be `true`, `false` (to disable panning), or a
    [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
    which must include a start and end event to trigger continuous panning.
    
    __Default value:__ `true`, which corresponds to
    `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
    clicks and dragging within an interval selection to reposition it.
    """
    zoom: bool | str | None = None
    """When truthy, allows a user to interactively resize an interval selection.
    Can be `true`, `false` (to disable zooming), or a [Vega event stream
    definition](https://vega.github.io/vega/docs/event-streams/). Currently,
    only `wheel` events are supported.
    
    
    __Default value:__ `true`, which corresponds to `wheel!`.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'SelectionDef':
        assert isinstance(obj, dict)
        type = SelectionDefType(obj["type"])
        bind = from_union([lambda x: from_dict(VGBinding.from_dict, x), BindEnum, from_none], obj.get("bind"))
        empty = from_union([Empty, from_none], obj.get("empty"))
        encodings = from_union([lambda x: from_list(SingleDefChannel, x), from_none], obj.get("encodings"))
        fields = from_union([lambda x: from_list(from_str, x), from_none], obj.get("fields"))
        nearest = from_union([from_bool, from_none], obj.get("nearest"))
        on = obj.get("on")
        resolve = from_union([SelectionResolution, from_none], obj.get("resolve"))
        toggle = from_union([from_bool, from_str, from_none], obj.get("toggle"))
        mark = from_union([BrushConfig.from_dict, from_none], obj.get("mark"))
        translate = from_union([from_bool, from_str, from_none], obj.get("translate"))
        zoom = from_union([from_bool, from_str, from_none], obj.get("zoom"))
        return SelectionDef(type, bind, empty, encodings, fields, nearest, on, resolve, toggle, mark, translate, zoom)

    def to_dict(self) -> dict:
        result: dict = {}
        result["type"] = to_enum(SelectionDefType, self.type)
        if self.bind is not None:
            result["bind"] = from_union([lambda x: from_dict(lambda x: to_class(VGBinding, x), x), lambda x: to_enum(BindEnum, x), from_none], self.bind)
        if self.empty is not None:
            result["empty"] = from_union([lambda x: to_enum(Empty, x), from_none], self.empty)
        if self.encodings is not None:
            result["encodings"] = from_union([lambda x: from_list(lambda x: to_enum(SingleDefChannel, x), x), from_none], self.encodings)
        if self.fields is not None:
            result["fields"] = from_union([lambda x: from_list(from_str, x), from_none], self.fields)
        if self.nearest is not None:
            result["nearest"] = from_union([from_bool, from_none], self.nearest)
        if self.on is not None:
            result["on"] = self.on
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_enum(SelectionResolution, x), from_none], self.resolve)
        if self.toggle is not None:
            result["toggle"] = from_union([from_bool, from_str, from_none], self.toggle)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(BrushConfig, x), from_none], self.mark)
        if self.translate is not None:
            result["translate"] = from_union([from_bool, from_str, from_none], self.translate)
        if self.zoom is not None:
            result["zoom"] = from_union([from_bool, from_str, from_none], self.zoom)
        return result


@dataclass
class TitleParams:
    text: str
    """The title text."""

    anchor: Anchor | None = None
    """The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
    example, with an orientation of top these anchor positions map to a left-, center-, or
    right-aligned title.
    
    __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
    `"start"` for other composite views.
    
    __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
    customizable only for [single](spec.html) and [layered](layer.html) views.  For other
    composite views, `anchor` is always `"start"`.
    """
    offset: float | None = None
    """The orthogonal offset in pixels by which to displace the title from its position along
    the edge of the chart.
    """
    orient: TitleOrient | None = None
    """The orientation of the title relative to the chart. One of `"top"` (the default),
    `"bottom"`, `"left"`, or `"right"`.
    """
    style: list[str] | str | None = None
    """A [mark style property](config.html#style) to apply to the title text mark.
    
    __Default value:__ `"group-title"`.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'TitleParams':
        assert isinstance(obj, dict)
        text = from_str(obj["text"])
        anchor = from_union([Anchor, from_none], obj.get("anchor"))
        offset = from_union([from_float, from_none], obj.get("offset"))
        orient = from_union([TitleOrient, from_none], obj.get("orient"))
        style = from_union([lambda x: from_list(from_str, x), from_str, from_none], obj.get("style"))
        return TitleParams(text, anchor, offset, orient, style)

    def to_dict(self) -> dict:
        result: dict = {}
        result["text"] = from_str(self.text)
        if self.anchor is not None:
            result["anchor"] = from_union([lambda x: to_enum(Anchor, x), from_none], self.anchor)
        if self.offset is not None:
            result["offset"] = from_union([to_float, from_none], self.offset)
        if self.orient is not None:
            result["orient"] = from_union([lambda x: to_enum(TitleOrient, x), from_none], self.orient)
        if self.style is not None:
            result["style"] = from_union([lambda x: from_list(from_str, x), from_str, from_none], self.style)
        return result


@dataclass
class AggregatedFieldDef:
    aggregated_field_def_as: str
    """The output field names to use for each aggregated field."""

    field: str
    """The data field for which to compute aggregate function."""

    op: AggregateOp
    """The aggregation operations to apply to the fields, such as sum, average or count.
    See the [full list of supported aggregation
    operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
    for more information.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'AggregatedFieldDef':
        assert isinstance(obj, dict)
        aggregated_field_def_as = from_str(obj["as"])
        field = from_str(obj["field"])
        op = AggregateOp(obj["op"])
        return AggregatedFieldDef(aggregated_field_def_as, field, op)

    def to_dict(self) -> dict:
        result: dict = {}
        result["as"] = from_str(self.aggregated_field_def_as)
        result["field"] = from_str(self.field)
        result["op"] = to_enum(AggregateOp, self.op)
        return result


@dataclass
class LookupData:
    """Secondary data reference."""

    data: Data
    """Secondary data source to lookup in."""

    key: str
    """Key in data to lookup."""

    fields: list[str] | None = None
    """Fields in foreign data to lookup.
    If not specified, the entire object is queried.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'LookupData':
        assert isinstance(obj, dict)
        data = Data.from_dict(obj["data"])
        key = from_str(obj["key"])
        fields = from_union([lambda x: from_list(from_str, x), from_none], obj.get("fields"))
        return LookupData(data, key, fields)

    def to_dict(self) -> dict:
        result: dict = {}
        result["data"] = to_class(Data, self.data)
        result["key"] = from_str(self.key)
        if self.fields is not None:
            result["fields"] = from_union([lambda x: from_list(from_str, x), from_none], self.fields)
        return result


@dataclass
class Transform:
    filter: Predicate | str | None = None
    """The `filter` property must be one of the predicate definitions:
    (1) an [expression](types.html#expression) string,
    where `datum` can be used to refer to the current data object;
    (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
    [range predicate](filter.html#range-predicate), [one-of
    predicate](filter.html#one-of-predicate);
    (3) a [selection predicate](filter.html#selection-predicate);
    or (4) a logical operand that combines (1), (2), or (3).
    """
    transform_as: list[str] | str | None = None
    """The field for storing the computed formula value.
    
    The field or fields for storing the computed formula value.
    If `from.fields` is specified, the transform will use the same names for `as`.
    If `from.fields` is not specified, `as` has to be a string and we put the whole object
    into the data under the specified name.
    
    The output fields at which to write the start and end bin values.
    
    The output field to write the timeUnit value.
    """
    calculate: str | None = None
    """A [expression](types.html#expression) string. Use the variable `datum` to refer to the
    current data object.
    """
    default: str | None = None
    """The default value to use if lookup fails.
    
    __Default value:__ `null`
    """
    transform_from: LookupData | None = None
    """Secondary data reference."""

    lookup: str | None = None
    """Key in primary data source."""

    bin: bool | BinParams | None = None
    """An object indicating bin properties, or simply `true` for using default bin parameters."""

    field: str | None = None
    """The data field to bin.
    
    The data field to apply time unit.
    """
    time_unit: TimeUnit | None = None
    """The timeUnit."""

    aggregate: list[AggregatedFieldDef] | None = None
    """Array of objects that define fields to aggregate."""

    groupby: list[str] | None = None
    """The data fields to group by. If not specified, a single group containing all data objects
    will be used.
    """

    @staticmethod
    def from_dict(obj: Any) -> 'Transform':
        assert isinstance(obj, dict)
        filter = from_union([Predicate.from_dict, from_str, from_none], obj.get("filter"))
        transform_as = from_union([lambda x: from_list(from_str, x), from_str, from_none], obj.get("as"))
        calculate = from_union([from_str, from_none], obj.get("calculate"))
        default = from_union([from_str, from_none], obj.get("default"))
        transform_from = from_union([LookupData.from_dict, from_none], obj.get("from"))
        lookup = from_union([from_str, from_none], obj.get("lookup"))
        bin = from_union([from_bool, BinParams.from_dict, from_none], obj.get("bin"))
        field = from_union([from_str, from_none], obj.get("field"))
        time_unit = from_union([TimeUnit, from_none], obj.get("timeUnit"))
        aggregate = from_union([lambda x: from_list(AggregatedFieldDef.from_dict, x), from_none], obj.get("aggregate"))
        groupby = from_union([lambda x: from_list(from_str, x), from_none], obj.get("groupby"))
        return Transform(filter, transform_as, calculate, default, transform_from, lookup, bin, field, time_unit, aggregate, groupby)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.filter is not None:
            result["filter"] = from_union([lambda x: to_class(Predicate, x), from_str, from_none], self.filter)
        if self.transform_as is not None:
            result["as"] = from_union([lambda x: from_list(from_str, x), from_str, from_none], self.transform_as)
        if self.calculate is not None:
            result["calculate"] = from_union([from_str, from_none], self.calculate)
        if self.default is not None:
            result["default"] = from_union([from_str, from_none], self.default)
        if self.transform_from is not None:
            result["from"] = from_union([lambda x: to_class(LookupData, x), from_none], self.transform_from)
        if self.lookup is not None:
            result["lookup"] = from_union([from_str, from_none], self.lookup)
        if self.bin is not None:
            result["bin"] = from_union([from_bool, lambda x: to_class(BinParams, x), from_none], self.bin)
        if self.field is not None:
            result["field"] = from_union([from_str, from_none], self.field)
        if self.time_unit is not None:
            result["timeUnit"] = from_union([lambda x: to_enum(TimeUnit, x), from_none], self.time_unit)
        if self.aggregate is not None:
            result["aggregate"] = from_union([lambda x: from_list(lambda x: to_class(AggregatedFieldDef, x), x), from_none], self.aggregate)
        if self.groupby is not None:
            result["groupby"] = from_union([lambda x: from_list(from_str, x), from_none], self.groupby)
        return result


@dataclass
class LayerSpec:
    """Unit spec that can have a composite mark."""

    data: Data | None = None
    """An object describing the data source"""

    description: str | None = None
    """Description of this mark for commenting purpose."""

    height: float | None = None
    """The height of a visualization.
    
    __Default value:__
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    [continuous scale](scale.html#continuous), the height will be the value of
    [`config.view.height`](spec.html#config).
    - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the height is [determined by the range step, paddings, and the
    cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    `rangeStep` is `null`, the height will be the value of
    [`config.view.height`](spec.html#config).
    - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    
    __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the height of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    layer: 'list[LayerSpec] | None' = None
    """Layer or single view specifications to be layered.
    
    __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    layering facet specifications is not allowed.
    """
    name: str | None = None
    """Name of the visualization for later reference."""

    resolve: Resolve | None = None
    """Scale, axis, and legend resolutions for layers."""

    title: TitleParams | str | None = None
    """Title for the plot."""

    transform: list[Transform] | None = None
    """An array of data transformations such as filter and new field calculation."""

    width: float | None = None
    """The width of a visualization.
    
    __Default value:__ This will be determined by the following rules:
    
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    [continuous scale](scale.html#continuous), the width will be the value of
    [`config.view.width`](spec.html#config).
    - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the width is [determined by the range step, paddings, and the
    cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    `rangeStep` is `null`, the width will be the value of
    [`config.view.width`](spec.html#config).
    - If no field is mapped to `x` channel, the `width` will be the value of
    [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    the value of `rangeStep` for other marks.
    
    __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the width of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    encoding: Encoding | None = None
    """A key-value mapping between encoding channels and definition of fields."""

    mark: MarkDef | Mark | None = None
    """A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    `"line"`,
    * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    object](mark.html#mark-def).
    """
    projection: Projection | None = None
    """An object defining properties of geographic projection.
    
    Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    """
    selection: dict[str, SelectionDef] | None = None
    """A key-value mapping between selection names and definitions."""

    @staticmethod
    def from_dict(obj: Any) -> 'LayerSpec':
        assert isinstance(obj, dict)
        data = from_union([Data.from_dict, from_none], obj.get("data"))
        description = from_union([from_str, from_none], obj.get("description"))
        height = from_union([from_float, from_none], obj.get("height"))
        layer = from_union([lambda x: from_list(LayerSpec.from_dict, x), from_none], obj.get("layer"))
        name = from_union([from_str, from_none], obj.get("name"))
        resolve = from_union([Resolve.from_dict, from_none], obj.get("resolve"))
        title = from_union([TitleParams.from_dict, from_str, from_none], obj.get("title"))
        transform = from_union([lambda x: from_list(Transform.from_dict, x), from_none], obj.get("transform"))
        width = from_union([from_float, from_none], obj.get("width"))
        encoding = from_union([Encoding.from_dict, from_none], obj.get("encoding"))
        mark = from_union([MarkDef.from_dict, Mark, from_none], obj.get("mark"))
        projection = from_union([Projection.from_dict, from_none], obj.get("projection"))
        selection = from_union([lambda x: from_dict(SelectionDef.from_dict, x), from_none], obj.get("selection"))
        return LayerSpec(data, description, height, layer, name, resolve, title, transform, width, encoding, mark, projection, selection)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.data is not None:
            result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        if self.description is not None:
            result["description"] = from_union([from_str, from_none], self.description)
        if self.height is not None:
            result["height"] = from_union([to_float, from_none], self.height)
        if self.layer is not None:
            result["layer"] = from_union([lambda x: from_list(lambda x: to_class(LayerSpec, x), x), from_none], self.layer)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_class(Resolve, x), from_none], self.resolve)
        if self.title is not None:
            result["title"] = from_union([lambda x: to_class(TitleParams, x), from_str, from_none], self.title)
        if self.transform is not None:
            result["transform"] = from_union([lambda x: from_list(lambda x: to_class(Transform, x), x), from_none], self.transform)
        if self.width is not None:
            result["width"] = from_union([to_float, from_none], self.width)
        if self.encoding is not None:
            result["encoding"] = from_union([lambda x: to_class(Encoding, x), from_none], self.encoding)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(MarkDef, x), lambda x: to_enum(Mark, x), from_none], self.mark)
        if self.projection is not None:
            result["projection"] = from_union([lambda x: to_class(Projection, x), from_none], self.projection)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: from_dict(lambda x: to_class(SelectionDef, x), x), from_none], self.selection)
        return result


@dataclass
class Repeat:
    """An object that describes what fields should be repeated into views that are laid out as a
    `row` or `column`.
    """
    column: list[str] | None = None
    """Horizontal repeated views."""

    row: list[str] | None = None
    """Vertical repeated views."""

    @staticmethod
    def from_dict(obj: Any) -> 'Repeat':
        assert isinstance(obj, dict)
        column = from_union([lambda x: from_list(from_str, x), from_none], obj.get("column"))
        row = from_union([lambda x: from_list(from_str, x), from_none], obj.get("row"))
        return Repeat(column, row)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.column is not None:
            result["column"] = from_union([lambda x: from_list(from_str, x), from_none], self.column)
        if self.row is not None:
            result["row"] = from_union([lambda x: from_list(from_str, x), from_none], self.row)
        return result


@dataclass
class Spec:
    """Unit spec that can have a composite mark."""

    data: Data | None = None
    """An object describing the data source"""

    description: str | None = None
    """Description of this mark for commenting purpose."""

    height: float | None = None
    """The height of a visualization.
    
    __Default value:__
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    [continuous scale](scale.html#continuous), the height will be the value of
    [`config.view.height`](spec.html#config).
    - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the height is [determined by the range step, paddings, and the
    cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    `rangeStep` is `null`, the height will be the value of
    [`config.view.height`](spec.html#config).
    - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    
    __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the height of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    layer: list[LayerSpec] | None = None
    """Layer or single view specifications to be layered.
    
    __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    layering facet specifications is not allowed.
    """
    name: str | None = None
    """Name of the visualization for later reference."""

    resolve: Resolve | None = None
    """Scale, axis, and legend resolutions for layers.
    
    Scale, axis, and legend resolutions for facets.
    
    Scale and legend resolutions for repeated charts.
    
    Scale, axis, and legend resolutions for vertically concatenated charts.
    
    Scale, axis, and legend resolutions for horizontally concatenated charts.
    """
    title: TitleParams | str | None = None
    """Title for the plot."""

    transform: list[Transform] | None = None
    """An array of data transformations such as filter and new field calculation."""

    width: float | None = None
    """The width of a visualization.
    
    __Default value:__ This will be determined by the following rules:
    
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    [continuous scale](scale.html#continuous), the width will be the value of
    [`config.view.width`](spec.html#config).
    - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the width is [determined by the range step, paddings, and the
    cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    `rangeStep` is `null`, the width will be the value of
    [`config.view.width`](spec.html#config).
    - If no field is mapped to `x` channel, the `width` will be the value of
    [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    the value of `rangeStep` for other marks.
    
    __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the width of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    encoding: Encoding | None = None
    """A key-value mapping between encoding channels and definition of fields."""

    mark: MarkDef | Mark | None = None
    """A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    `"line"`,
    * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    object](mark.html#mark-def).
    """
    projection: Projection | None = None
    """An object defining properties of geographic projection.
    
    Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    """
    selection: dict[str, SelectionDef] | None = None
    """A key-value mapping between selection names and definitions."""

    facet: FacetMapping | None = None
    """An object that describes mappings between `row` and `column` channels and their field
    definitions.
    """
    spec: 'Spec | None' = None
    """A specification of the view that gets faceted."""

    repeat: Repeat | None = None
    """An object that describes what fields should be repeated into views that are laid out as a
    `row` or `column`.
    """
    vconcat: 'list[Spec] | None' = None
    """A list of views that should be concatenated and put into a column."""

    hconcat: 'list[Spec] | None' = None
    """A list of views that should be concatenated and put into a row."""

    @staticmethod
    def from_dict(obj: Any) -> 'Spec':
        assert isinstance(obj, dict)
        data = from_union([Data.from_dict, from_none], obj.get("data"))
        description = from_union([from_str, from_none], obj.get("description"))
        height = from_union([from_float, from_none], obj.get("height"))
        layer = from_union([lambda x: from_list(LayerSpec.from_dict, x), from_none], obj.get("layer"))
        name = from_union([from_str, from_none], obj.get("name"))
        resolve = from_union([Resolve.from_dict, from_none], obj.get("resolve"))
        title = from_union([TitleParams.from_dict, from_str, from_none], obj.get("title"))
        transform = from_union([lambda x: from_list(Transform.from_dict, x), from_none], obj.get("transform"))
        width = from_union([from_float, from_none], obj.get("width"))
        encoding = from_union([Encoding.from_dict, from_none], obj.get("encoding"))
        mark = from_union([MarkDef.from_dict, Mark, from_none], obj.get("mark"))
        projection = from_union([Projection.from_dict, from_none], obj.get("projection"))
        selection = from_union([lambda x: from_dict(SelectionDef.from_dict, x), from_none], obj.get("selection"))
        facet = from_union([FacetMapping.from_dict, from_none], obj.get("facet"))
        spec = from_union([Spec.from_dict, from_none], obj.get("spec"))
        repeat = from_union([Repeat.from_dict, from_none], obj.get("repeat"))
        vconcat = from_union([lambda x: from_list(Spec.from_dict, x), from_none], obj.get("vconcat"))
        hconcat = from_union([lambda x: from_list(Spec.from_dict, x), from_none], obj.get("hconcat"))
        return Spec(data, description, height, layer, name, resolve, title, transform, width, encoding, mark, projection, selection, facet, spec, repeat, vconcat, hconcat)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.data is not None:
            result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        if self.description is not None:
            result["description"] = from_union([from_str, from_none], self.description)
        if self.height is not None:
            result["height"] = from_union([to_float, from_none], self.height)
        if self.layer is not None:
            result["layer"] = from_union([lambda x: from_list(lambda x: to_class(LayerSpec, x), x), from_none], self.layer)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_class(Resolve, x), from_none], self.resolve)
        if self.title is not None:
            result["title"] = from_union([lambda x: to_class(TitleParams, x), from_str, from_none], self.title)
        if self.transform is not None:
            result["transform"] = from_union([lambda x: from_list(lambda x: to_class(Transform, x), x), from_none], self.transform)
        if self.width is not None:
            result["width"] = from_union([to_float, from_none], self.width)
        if self.encoding is not None:
            result["encoding"] = from_union([lambda x: to_class(Encoding, x), from_none], self.encoding)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(MarkDef, x), lambda x: to_enum(Mark, x), from_none], self.mark)
        if self.projection is not None:
            result["projection"] = from_union([lambda x: to_class(Projection, x), from_none], self.projection)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: from_dict(lambda x: to_class(SelectionDef, x), x), from_none], self.selection)
        if self.facet is not None:
            result["facet"] = from_union([lambda x: to_class(FacetMapping, x), from_none], self.facet)
        if self.spec is not None:
            result["spec"] = from_union([lambda x: to_class(Spec, x), from_none], self.spec)
        if self.repeat is not None:
            result["repeat"] = from_union([lambda x: to_class(Repeat, x), from_none], self.repeat)
        if self.vconcat is not None:
            result["vconcat"] = from_union([lambda x: from_list(lambda x: to_class(Spec, x), x), from_none], self.vconcat)
        if self.hconcat is not None:
            result["hconcat"] = from_union([lambda x: from_list(lambda x: to_class(Spec, x), x), from_none], self.hconcat)
        return result


@dataclass
class TopLevel:
    schema: str | None = None
    """URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
    have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
    Setting the `$schema` property allows automatic validation and autocomplete in editors
    that support JSON schema.
    """
    autosize: AutoSizeParams | AutosizeType | None = None
    """Sets how the visualization size should be determined. If a string, should be one of
    `"pad"`, `"fit"` or `"none"`.
    Object values can additionally specify parameters for content sizing and automatic
    resizing.
    `"fit"` is only supported for single and layered views that don't use `rangeStep`.
    
    __Default value__: `pad`
    """
    background: str | None = None
    """CSS color property to use as the background of visualization.
    
    __Default value:__ none (transparent)
    """
    config: Config | None = None
    """Vega-Lite configuration object.  This property can only be defined at the top-level of a
    specification.
    """
    data: Data | None = None
    """An object describing the data source"""

    description: str | None = None
    """Description of this mark for commenting purpose."""

    encoding: EncodingWithFacet | None = None
    """A key-value mapping between encoding channels and definition of fields."""

    height: float | None = None
    """The height of a visualization.
    
    __Default value:__
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
    [continuous scale](scale.html#continuous), the height will be the value of
    [`config.view.height`](spec.html#config).
    - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the height is [determined by the range step, paddings, and the
    cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
    `rangeStep` is `null`, the height will be the value of
    [`config.view.height`](spec.html#config).
    - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
    
    __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the height of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    mark: MarkDef | Mark | None = None
    """A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
    `"line"`,
    * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
    object](mark.html#mark-def).
    """
    name: str | None = None
    """Name of the visualization for later reference."""

    padding: float | PaddingClass | None = None
    """The default visualization padding, in pixels, from the edge of the visualization canvas
    to the data rectangle.  If a number, specifies padding for all sides.
    If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
    "bottom": 5}` to specify padding for each side of the visualization.
    
    __Default value__: `5`
    """
    projection: Projection | None = None
    """An object defining properties of geographic projection.
    
    Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
    more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
    """
    selection: dict[str, SelectionDef] | None = None
    """A key-value mapping between selection names and definitions."""

    title: TitleParams | str | None = None
    """Title for the plot."""

    transform: list[Transform] | None = None
    """An array of data transformations such as filter and new field calculation."""

    width: float | None = None
    """The width of a visualization.
    
    __Default value:__ This will be determined by the following rules:
    
    - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
    [continuous scale](scale.html#continuous), the width will be the value of
    [`config.view.width`](spec.html#config).
    - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
    value or unspecified, the width is [determined by the range step, paddings, and the
    cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
    `rangeStep` is `null`, the width will be the value of
    [`config.view.width`](spec.html#config).
    - If no field is mapped to `x` channel, the `width` will be the value of
    [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
    the value of `rangeStep` for other marks.
    
    __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
    represents the width of a single view.
    
    __See also:__ The documentation for [width and height](size.html) contains more examples.
    """
    layer: list[LayerSpec] | None = None
    """Layer or single view specifications to be layered.
    
    __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
    layering facet specifications is not allowed.
    """
    resolve: Resolve | None = None
    """Scale, axis, and legend resolutions for layers.
    
    Scale, axis, and legend resolutions for facets.
    
    Scale and legend resolutions for repeated charts.
    
    Scale, axis, and legend resolutions for vertically concatenated charts.
    
    Scale, axis, and legend resolutions for horizontally concatenated charts.
    """
    facet: FacetMapping | None = None
    """An object that describes mappings between `row` and `column` channels and their field
    definitions.
    """
    spec: Spec | None = None
    """A specification of the view that gets faceted."""

    repeat: Repeat | None = None
    """An object that describes what fields should be repeated into views that are laid out as a
    `row` or `column`.
    """
    vconcat: list[Spec] | None = None
    """A list of views that should be concatenated and put into a column."""

    hconcat: list[Spec] | None = None
    """A list of views that should be concatenated and put into a row."""

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        schema = from_union([from_str, from_none], obj.get("$schema"))
        autosize = from_union([AutoSizeParams.from_dict, AutosizeType, from_none], obj.get("autosize"))
        background = from_union([from_str, from_none], obj.get("background"))
        config = from_union([Config.from_dict, from_none], obj.get("config"))
        data = from_union([Data.from_dict, from_none], obj.get("data"))
        description = from_union([from_str, from_none], obj.get("description"))
        encoding = from_union([EncodingWithFacet.from_dict, from_none], obj.get("encoding"))
        height = from_union([from_float, from_none], obj.get("height"))
        mark = from_union([MarkDef.from_dict, Mark, from_none], obj.get("mark"))
        name = from_union([from_str, from_none], obj.get("name"))
        padding = from_union([from_float, PaddingClass.from_dict, from_none], obj.get("padding"))
        projection = from_union([Projection.from_dict, from_none], obj.get("projection"))
        selection = from_union([lambda x: from_dict(SelectionDef.from_dict, x), from_none], obj.get("selection"))
        title = from_union([TitleParams.from_dict, from_str, from_none], obj.get("title"))
        transform = from_union([lambda x: from_list(Transform.from_dict, x), from_none], obj.get("transform"))
        width = from_union([from_float, from_none], obj.get("width"))
        layer = from_union([lambda x: from_list(LayerSpec.from_dict, x), from_none], obj.get("layer"))
        resolve = from_union([Resolve.from_dict, from_none], obj.get("resolve"))
        facet = from_union([FacetMapping.from_dict, from_none], obj.get("facet"))
        spec = from_union([Spec.from_dict, from_none], obj.get("spec"))
        repeat = from_union([Repeat.from_dict, from_none], obj.get("repeat"))
        vconcat = from_union([lambda x: from_list(Spec.from_dict, x), from_none], obj.get("vconcat"))
        hconcat = from_union([lambda x: from_list(Spec.from_dict, x), from_none], obj.get("hconcat"))
        return TopLevel(schema, autosize, background, config, data, description, encoding, height, mark, name, padding, projection, selection, title, transform, width, layer, resolve, facet, spec, repeat, vconcat, hconcat)

    def to_dict(self) -> dict:
        result: dict = {}
        if self.schema is not None:
            result["$schema"] = from_union([from_str, from_none], self.schema)
        if self.autosize is not None:
            result["autosize"] = from_union([lambda x: to_class(AutoSizeParams, x), lambda x: to_enum(AutosizeType, x), from_none], self.autosize)
        if self.background is not None:
            result["background"] = from_union([from_str, from_none], self.background)
        if self.config is not None:
            result["config"] = from_union([lambda x: to_class(Config, x), from_none], self.config)
        if self.data is not None:
            result["data"] = from_union([lambda x: to_class(Data, x), from_none], self.data)
        if self.description is not None:
            result["description"] = from_union([from_str, from_none], self.description)
        if self.encoding is not None:
            result["encoding"] = from_union([lambda x: to_class(EncodingWithFacet, x), from_none], self.encoding)
        if self.height is not None:
            result["height"] = from_union([to_float, from_none], self.height)
        if self.mark is not None:
            result["mark"] = from_union([lambda x: to_class(MarkDef, x), lambda x: to_enum(Mark, x), from_none], self.mark)
        if self.name is not None:
            result["name"] = from_union([from_str, from_none], self.name)
        if self.padding is not None:
            result["padding"] = from_union([to_float, lambda x: to_class(PaddingClass, x), from_none], self.padding)
        if self.projection is not None:
            result["projection"] = from_union([lambda x: to_class(Projection, x), from_none], self.projection)
        if self.selection is not None:
            result["selection"] = from_union([lambda x: from_dict(lambda x: to_class(SelectionDef, x), x), from_none], self.selection)
        if self.title is not None:
            result["title"] = from_union([lambda x: to_class(TitleParams, x), from_str, from_none], self.title)
        if self.transform is not None:
            result["transform"] = from_union([lambda x: from_list(lambda x: to_class(Transform, x), x), from_none], self.transform)
        if self.width is not None:
            result["width"] = from_union([to_float, from_none], self.width)
        if self.layer is not None:
            result["layer"] = from_union([lambda x: from_list(lambda x: to_class(LayerSpec, x), x), from_none], self.layer)
        if self.resolve is not None:
            result["resolve"] = from_union([lambda x: to_class(Resolve, x), from_none], self.resolve)
        if self.facet is not None:
            result["facet"] = from_union([lambda x: to_class(FacetMapping, x), from_none], self.facet)
        if self.spec is not None:
            result["spec"] = from_union([lambda x: to_class(Spec, x), from_none], self.spec)
        if self.repeat is not None:
            result["repeat"] = from_union([lambda x: to_class(Repeat, x), from_none], self.repeat)
        if self.vconcat is not None:
            result["vconcat"] = from_union([lambda x: from_list(lambda x: to_class(Spec, x), x), from_none], self.vconcat)
        if self.hconcat is not None:
            result["hconcat"] = from_union([lambda x: from_list(lambda x: to_class(Spec, x), x), from_none], self.hconcat)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
