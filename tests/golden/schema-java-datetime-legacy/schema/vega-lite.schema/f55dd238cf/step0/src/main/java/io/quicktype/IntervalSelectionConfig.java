package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * The default definition for an [`interval`](selection.html#type) selection. All properties
 * and transformations
 * for an interval selection definition (except `type`) may be specified here.
 *
 * For instance, setting `interval` to `{"translate": false}` disables the ability to move
 * interval selections by default.
 */
public class IntervalSelectionConfig {
    private BindEnum bind;
    private Empty empty;
    private List<SingleDefChannel> encodings;
    private List<String> fields;
    private BrushConfig mark;
    private Object on;
    private SelectionResolution resolve;
    private Translate translate;
    private Translate zoom;

    /**
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    @JsonProperty("bind")
    public BindEnum getBind() { return bind; }
    @JsonProperty("bind")
    public void setBind(BindEnum value) { this.bind = value; }

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    @JsonProperty("empty")
    public Empty getEmpty() { return empty; }
    @JsonProperty("empty")
    public void setEmpty(Empty value) { this.empty = value; }

    /**
     * An array of encoding channels. The corresponding data field values
     * must match for a data tuple to fall within the selection.
     */
    @JsonProperty("encodings")
    public List<SingleDefChannel> getEncodings() { return encodings; }
    @JsonProperty("encodings")
    public void setEncodings(List<SingleDefChannel> value) { this.encodings = value; }

    /**
     * An array of field names whose values must match for a data tuple to
     * fall within the selection.
     */
    @JsonProperty("fields")
    public List<String> getFields() { return fields; }
    @JsonProperty("fields")
    public void setFields(List<String> value) { this.fields = value; }

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    @JsonProperty("mark")
    public BrushConfig getMark() { return mark; }
    @JsonProperty("mark")
    public void setMark(BrushConfig value) { this.mark = value; }

    /**
     * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
     * selector) that triggers the selection.
     * For interval selections, the event stream must specify a [start and
     * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
     */
    @JsonProperty("on")
    public Object getOn() { return on; }
    @JsonProperty("on")
    public void setOn(Object value) { this.on = value; }

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    @JsonProperty("resolve")
    public SelectionResolution getResolve() { return resolve; }
    @JsonProperty("resolve")
    public void setResolve(SelectionResolution value) { this.resolve = value; }

    /**
     * When truthy, allows a user to interactively move an interval selection
     * back-and-forth. Can be `true`, `false` (to disable panning), or a
     * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
     * which must include a start and end event to trigger continuous panning.
     *
     * __Default value:__ `true`, which corresponds to
     * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
     * clicks and dragging within an interval selection to reposition it.
     */
    @JsonProperty("translate")
    public Translate getTranslate() { return translate; }
    @JsonProperty("translate")
    public void setTranslate(Translate value) { this.translate = value; }

    /**
     * When truthy, allows a user to interactively resize an interval selection.
     * Can be `true`, `false` (to disable zooming), or a [Vega event stream
     * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
     * only `wheel` events are supported.
     *
     *
     * __Default value:__ `true`, which corresponds to `wheel!`.
     */
    @JsonProperty("zoom")
    public Translate getZoom() { return zoom; }
    @JsonProperty("zoom")
    public void setZoom(Translate value) { this.zoom = value; }
}
