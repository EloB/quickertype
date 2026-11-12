package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Char {
    private long charChar;

    @JsonProperty("char")
    public long getCharChar() { return charChar; }
    @JsonProperty("char")
    public void setCharChar(long value) { this.charChar = value; }
}
