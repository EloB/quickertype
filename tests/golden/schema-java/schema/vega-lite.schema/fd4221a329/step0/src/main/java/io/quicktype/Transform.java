package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Transform {
    private ConditionalValueDefLogicalOperandPredicate filter;
    private Style as;
    private String calculate;
    private String transformDefault;
    private LookupData from;
    private String lookup;
    private Bin bin;
    private String field;
    private TimeUnit timeUnit;
    private List<AggregatedFieldDef> aggregate;
    private List<String> groupby;

    /**
     * The `filter` property must be one of the predicate definitions:
     * (1) an [expression](types.html#expression) string,
     * where `datum` can be used to refer to the current data object;
     * (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
     * [range predicate](filter.html#range-predicate), [one-of
     * predicate](filter.html#one-of-predicate);
     * (3) a [selection predicate](filter.html#selection-predicate);
     * or (4) a logical operand that combines (1), (2), or (3).
     */
    @JsonProperty("filter")
    public ConditionalValueDefLogicalOperandPredicate getFilter() { return filter; }
    @JsonProperty("filter")
    public void setFilter(ConditionalValueDefLogicalOperandPredicate value) { this.filter = value; }

    /**
     * The field for storing the computed formula value.
     *
     * The field or fields for storing the computed formula value.
     * If `from.fields` is specified, the transform will use the same names for `as`.
     * If `from.fields` is not specified, `as` has to be a string and we put the whole object
     * into the data under the specified name.
     *
     * The output fields at which to write the start and end bin values.
     *
     * The output field to write the timeUnit value.
     */
    @JsonProperty("as")
    public Style getAs() { return as; }
    @JsonProperty("as")
    public void setAs(Style value) { this.as = value; }

    /**
     * A [expression](types.html#expression) string. Use the variable `datum` to refer to the
     * current data object.
     */
    @JsonProperty("calculate")
    public String getCalculate() { return calculate; }
    @JsonProperty("calculate")
    public void setCalculate(String value) { this.calculate = value; }

    /**
     * The default value to use if lookup fails.
     *
     * __Default value:__ `null`
     */
    @JsonProperty("default")
    public String getTransformDefault() { return transformDefault; }
    @JsonProperty("default")
    public void setTransformDefault(String value) { this.transformDefault = value; }

    /**
     * Secondary data reference.
     */
    @JsonProperty("from")
    public LookupData getFrom() { return from; }
    @JsonProperty("from")
    public void setFrom(LookupData value) { this.from = value; }

    /**
     * Key in primary data source.
     */
    @JsonProperty("lookup")
    public String getLookup() { return lookup; }
    @JsonProperty("lookup")
    public void setLookup(String value) { this.lookup = value; }

    /**
     * An object indicating bin properties, or simply `true` for using default bin parameters.
     */
    @JsonProperty("bin")
    public Bin getBin() { return bin; }
    @JsonProperty("bin")
    public void setBin(Bin value) { this.bin = value; }

    /**
     * The data field to bin.
     *
     * The data field to apply time unit.
     */
    @JsonProperty("field")
    public String getField() { return field; }
    @JsonProperty("field")
    public void setField(String value) { this.field = value; }

    /**
     * The timeUnit.
     */
    @JsonProperty("timeUnit")
    public TimeUnit getTimeUnit() { return timeUnit; }
    @JsonProperty("timeUnit")
    public void setTimeUnit(TimeUnit value) { this.timeUnit = value; }

    /**
     * Array of objects that define fields to aggregate.
     */
    @JsonProperty("aggregate")
    public List<AggregatedFieldDef> getAggregate() { return aggregate; }
    @JsonProperty("aggregate")
    public void setAggregate(List<AggregatedFieldDef> value) { this.aggregate = value; }

    /**
     * The data fields to group by. If not specified, a single group containing all data objects
     * will be used.
     */
    @JsonProperty("groupby")
    public List<String> getGroupby() { return groupby; }
    @JsonProperty("groupby")
    public void setGroupby(List<String> value) { this.groupby = value; }
}
