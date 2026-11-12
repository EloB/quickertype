package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Predicate {
    private ConditionalValueDefLogicalOperandPredicate not;
    private List<LogicalOperandPredicateElement> and;
    private List<LogicalOperandPredicateElement> or;
    private EqualUnion equal;
    private String field;
    private TimeUnit timeUnit;
    private List<RangeElement> range;
    private List<OneOfElement> oneOf;
    private ConditionalValueDefSelectionOperand selection;

    @JsonProperty("not")
    public ConditionalValueDefLogicalOperandPredicate getNot() { return not; }
    @JsonProperty("not")
    public void setNot(ConditionalValueDefLogicalOperandPredicate value) { this.not = value; }

    @JsonProperty("and")
    public List<LogicalOperandPredicateElement> getAnd() { return and; }
    @JsonProperty("and")
    public void setAnd(List<LogicalOperandPredicateElement> value) { this.and = value; }

    @JsonProperty("or")
    public List<LogicalOperandPredicateElement> getOr() { return or; }
    @JsonProperty("or")
    public void setOr(List<LogicalOperandPredicateElement> value) { this.or = value; }

    /**
     * The value that the field should be equal to.
     */
    @JsonProperty("equal")
    public EqualUnion getEqual() { return equal; }
    @JsonProperty("equal")
    public void setEqual(EqualUnion value) { this.equal = value; }

    /**
     * Field to be filtered.
     *
     * Field to be filtered
     */
    @JsonProperty("field")
    public String getField() { return field; }
    @JsonProperty("field")
    public void setField(String value) { this.field = value; }

    /**
     * Time unit for the field to be filtered.
     *
     * time unit for the field to be filtered.
     */
    @JsonProperty("timeUnit")
    public TimeUnit getTimeUnit() { return timeUnit; }
    @JsonProperty("timeUnit")
    public void setTimeUnit(TimeUnit value) { this.timeUnit = value; }

    /**
     * An array of inclusive minimum and maximum values
     * for a field value of a data item to be included in the filtered data.
     */
    @JsonProperty("range")
    public List<RangeElement> getRange() { return range; }
    @JsonProperty("range")
    public void setRange(List<RangeElement> value) { this.range = value; }

    /**
     * A set of values that the `field`'s value should be a member of,
     * for a data item included in the filtered data.
     */
    @JsonProperty("oneOf")
    public List<OneOfElement> getOneOf() { return oneOf; }
    @JsonProperty("oneOf")
    public void setOneOf(List<OneOfElement> value) { this.oneOf = value; }

    /**
     * Filter using a selection name.
     */
    @JsonProperty("selection")
    public ConditionalValueDefSelectionOperand getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(ConditionalValueDefSelectionOperand value) { this.selection = value; }
}
