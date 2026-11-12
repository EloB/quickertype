package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Number number;

    @JsonProperty("number")
    public Number getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(Number value) { this.number = value; }
}
