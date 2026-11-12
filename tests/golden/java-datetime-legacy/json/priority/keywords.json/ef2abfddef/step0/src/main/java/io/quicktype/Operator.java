package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Operator {
    private long operator;

    @JsonProperty("operator")
    public long getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(long value) { this.operator = value; }
}
