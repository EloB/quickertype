package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConditionalValueDef {
    private ConditionalValueDefLogicalOperandPredicate test;
    private ConditionalValueDefValue value;
    private ConditionalValueDefSelectionOperand selection;

    @JsonProperty("test")
    public ConditionalValueDefLogicalOperandPredicate getTest() { return test; }
    @JsonProperty("test")
    public void setTest(ConditionalValueDefLogicalOperandPredicate value) { this.test = value; }

    /**
     * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
     * `0` to `1` for opacity).
     */
    @JsonProperty("value")
    public ConditionalValueDefValue getValue() { return value; }
    @JsonProperty("value")
    public void setValue(ConditionalValueDefValue value) { this.value = value; }

    /**
     * A [selection name](selection.html), or a series of [composed
     * selections](selection.html#compose).
     */
    @JsonProperty("selection")
    public ConditionalValueDefSelectionOperand getSelection() { return selection; }
    @JsonProperty("selection")
    public void setSelection(ConditionalValueDefSelectionOperand value) { this.selection = value; }
}
