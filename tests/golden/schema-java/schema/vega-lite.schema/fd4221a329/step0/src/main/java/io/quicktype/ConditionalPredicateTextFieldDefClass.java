package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConditionalPredicateTextFieldDefClass {
    private ConditionalValueDefLogicalOperandPredicate test;
    private ConditionalPredicateValueDefValue value;
    private ConditionalValueDefSelectionOperand selection;
    private AggregateOp aggregate;
    private Bin bin;
    private Field field;
    private String format;
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
     * The [formatting pattern](format.html) for a text field. If not defined, this will be
     * determined automatically.
     */
    @JsonProperty("format")
    public String getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(String value) { this.format = value; }

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
