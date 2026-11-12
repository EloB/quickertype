package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StringClass {
    private long string;

    @JsonProperty("string")
    public long getString() { return string; }
    @JsonProperty("string")
    public void setString(long value) { this.string = value; }
}
