package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Print {
    private long print;

    @JsonProperty("print")
    public long getPrint() { return print; }
    @JsonProperty("print")
    public void setPrint(long value) { this.print = value; }
}
