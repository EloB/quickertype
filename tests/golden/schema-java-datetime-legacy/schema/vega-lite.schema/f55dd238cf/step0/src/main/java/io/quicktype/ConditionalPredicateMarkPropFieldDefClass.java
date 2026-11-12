package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConditionalPredicateMarkPropFieldDefClass {
    private ConditionalValueDefLogicalOperandPredicate test;
    private ConditionalPredicateValueDefValue value;
    private ConditionalValueDefSelectionOperand selection;
    private AggregateOp aggregate;
    private Bin bin;
    private Field field;
    private Legend legend;
    private Scale scale;
    private SortUnion sort;
    private TimeUnit timeUnit;
    private Type type;

    @JsonProperty("test")
    public ConditionalValueDefLogicalOperandPredicate getTest() { return test; }
    @JsonProperty("test")
    public void setTest(ConditionalValueDefLogicalOperandPredicate value) { this.test = value; }

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    @JsonProperty("value")
    public ConditionalPredicateValueDefValue getValue() { return value; }
    @JsonProperty("value")
    public void setValue(ConditionalPredicateValueDefValue value) { this.value = value; }

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    @JsonProperty("selection")
    public ConditionalValueDefSelectionOperand getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(ConditionalValueDefSelectionOperand value) { this.selection = value; }

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
     * An object defining properties of the legend.
     * If `null`, the legend for the encoding channel will be removed.
     *
     * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
     */
    @JsonProperty("legend")
    public Legend getLegend() { return legend; }
    @JsonProperty("legend")
    public void setLegend(Legend value) { this.legend = value; }

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    @JsonProperty("scale")
    public Scale getScale() { return scale; }
    @JsonProperty("scale")
    public void setScale(Scale value) { this.scale = value; }

    /**
     * Sort order for the encoded field.
     * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
     * For fields with discrete domains, `sort` can also be a [sort field definition
     * object](sort.html#sort-field).
     *
     * __Default value:__ `"ascending"`
     */
    @JsonProperty("sort")
    public SortUnion getSort() { return sort; }
    @JsonProperty("sort")
    public void setSort(SortUnion value) { this.sort = value; }

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
