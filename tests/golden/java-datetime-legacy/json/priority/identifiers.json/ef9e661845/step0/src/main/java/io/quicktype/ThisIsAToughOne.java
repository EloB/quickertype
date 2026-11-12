package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ThisIsAToughOne {
    private long empty;
    private long thisIsAToughOne;

    @JsonProperty("\n\n\n")
    public long getEmpty() { return empty; }
    @JsonProperty("\n\n\n")
    public void setEmpty(long value) { this.empty = value; }

    @JsonProperty("\"")
    public long getThisIsAToughOne() { return thisIsAToughOne; }
    @JsonProperty("\"")
    public void setThisIsAToughOne(long value) { this.thisIsAToughOne = value; }
}
