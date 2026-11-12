package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Selection {
    private ConditionalValueDefSelectionOperand not;
    private List<SelectionOperandElement> and;
    private List<SelectionOperandElement> or;

    @JsonProperty("not")
    public ConditionalValueDefSelectionOperand getNot() { return not; }
    @JsonProperty("not")
    public void setNot(ConditionalValueDefSelectionOperand value) { this.not = value; }

    @JsonProperty("and")
    public List<SelectionOperandElement> getAnd() { return and; }
    @JsonProperty("and")
    public void setAnd(List<SelectionOperandElement> value) { this.and = value; }

    @JsonProperty("or")
    public List<SelectionOperandElement> getOr() { return or; }
    @JsonProperty("or")
    public void setOr(List<SelectionOperandElement> value) { this.or = value; }
}
