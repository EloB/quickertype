package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * The default definition for a [`multi`](selection.html#type) selection. All properties and
 * transformations
 * for a multi selection definition (except `type`) may be specified here.
 *
 * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
 * multi selections when clicking with the alt-key pressed by default.
 */
public class MultiSelectionConfig {
    private Empty empty;
    private List<SingleDefChannel> encodings;
    private List<String> fields;
    private Boolean nearest;
    private Object on;
    private SelectionResolution resolve;
    private Translate toggle;

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
     * When true, an invisible voronoi diagram is computed to accelerate discrete
     * selection. The data value _nearest_ the mouse cursor is added to the selection.
     *
     * See the [nearest transform](nearest.html) documentation for more information.
     */
    @JsonProperty("nearest")
    public Boolean getNearest() { return nearest; }
    @JsonProperty("nearest")
    public void setNearest(Boolean value) { this.nearest = value; }

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
     * Controls whether data values should be toggled or only ever inserted into
     * multi selections. Can be `true`, `false` (for insertion only), or a
     * [Vega expression](https://vega.github.io/vega/docs/expressions/).
     *
     * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
     * data values are toggled when a user interacts with the shift-key pressed).
     *
     * See the [toggle transform](toggle.html) documentation for more information.
     */
    @JsonProperty("toggle")
    public Translate getToggle() { return toggle; }
    @JsonProperty("toggle")
    public void setToggle(Translate value) { this.toggle = value; }
}
