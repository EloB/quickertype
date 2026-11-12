package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SortField {
    private Field field;
    private AggregateOp op;
    private SortEnum order;

    /**
     * The data [field](field.html) to sort by.
     *
     * __Default value:__ If unspecified, defaults to the field specified in the outer data
     * reference.
     */
    @JsonProperty("field")
    public Field getField() { return field; }
    @JsonProperty("field")
    public void setField(Field value) { this.field = value; }

    /**
     * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
     * (e.g., `"count"`, `"mean"` and `"median"`).
     * This property is required in cases where the sort field and the data reference field do
     * not match.
     * The input data objects will be aggregated, grouped by the encoded data field.
     *
     * For a full list of operations, please see the documentation for
     * [aggregate](aggregate.html#ops).
     */
    @JsonProperty("op")
    public AggregateOp getOp() { return op; }
    @JsonProperty("op")
    public void setOp(AggregateOp value) { this.op = value; }

    /**
     * The sort order. One of `"ascending"` (default) or `"descending"`.
     */
    @JsonProperty("order")
    public SortEnum getOrder() { return order; }
    @JsonProperty("order")
    public void setOrder(SortEnum value) { this.order = value; }
}
