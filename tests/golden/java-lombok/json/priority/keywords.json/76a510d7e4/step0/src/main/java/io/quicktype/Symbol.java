package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Symbol {
    private long symbol;

    @JsonProperty("symbol")
    public long getSymbol() { return symbol; }
    @JsonProperty("symbol")
    public void setSymbol(long value) { this.symbol = value; }
}
