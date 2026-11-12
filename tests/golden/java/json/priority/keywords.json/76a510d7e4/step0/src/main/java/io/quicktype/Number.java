package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Number {
    private long number;

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }
}
