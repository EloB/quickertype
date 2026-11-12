package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Horizontal facets for trellis plots.
 *
 * Vertical facets for trellis plots.
 */
public class FacetFieldDef {
    private AggregateOp aggregate;
    private Bin bin;
    private Field field;
    private Header header;
    private SortEnum sort;
    private TimeUnit timeUnit;
    private Type type;

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     */
    @JsonProperty("aggregate")
    public AggregateOp getAggregate() { return aggregate; }
    @JsonProperty("aggregate")
    public void setAggregate(AggregateOp value) { this.aggregate = value; }

    /**
     * A flag for binning a `quantitative` field, or [an object defining binning
     * parameters](bin.html#params).
     * If `true`, default [binning parameters](bin.html) will be applied.
     *
     * __Default value:__ `false`
     */
    @JsonProperty("bin")
    public Bin getBin() { return bin; }
    @JsonProperty("bin")
    public void setBin(Bin value) { this.bin = value; }

    /**
     * __Required.__ A string defining the name of the field from which to pull a data value
     * or an object defining iterated values from the [`repeat`](repeat.html) operator.
     *
     * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
     * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
     * If field names contain dots or brackets but are not nested, you can use `\\` to escape
     * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
     * See more details about escaping in the [field documentation](field.html).
     *
     * __Note:__ `field` is not required if `aggregate` is `count`.
     */
    @JsonProperty("field")
    public Field getField() { return field; }
    @JsonProperty("field")
    public void setField(Field value) { this.field = value; }

    /**
     * An object defining properties of a facet's header.
     */
    @JsonProperty("header")
    public Header getHeader() { return header; }
    @JsonProperty("header")
    public void setHeader(Header value) { this.header = value; }

    /**
     * Sort order for a facet field.
     * This can be `"ascending"`, `"descending"`.
     */
    @JsonProperty("sort")
    public SortEnum getSort() { return sort; }
    @JsonProperty("sort")
    public void setSort(SortEnum value) { this.sort = value; }

    /**
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     */
    @JsonProperty("timeUnit")
    public TimeUnit getTimeUnit() { return timeUnit; }
    @JsonProperty("timeUnit")
    public void setTimeUnit(TimeUnit value) { this.timeUnit = value; }

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     */
    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }
}
