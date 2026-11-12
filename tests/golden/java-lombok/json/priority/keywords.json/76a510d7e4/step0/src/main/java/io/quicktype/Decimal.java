package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Decimal {
    private long decimal;

    @JsonProperty("decimal")
    public long getDecimal() { return decimal; }
    @JsonProperty("decimal")
    public void setDecimal(long value) { this.decimal = value; }
}
