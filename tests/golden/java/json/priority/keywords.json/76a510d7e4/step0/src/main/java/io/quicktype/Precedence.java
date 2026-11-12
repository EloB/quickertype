package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Precedence {
    private long precedence;

    @JsonProperty("precedence")
    public long getPrecedence() { return precedence; }
    @JsonProperty("precedence")
    public void setPrecedence(long value) { this.precedence = value; }
}
