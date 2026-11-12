package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Console {
    private long console;

    @JsonProperty("console")
    public long getConsole() { return console; }
    @JsonProperty("console")
    public void setConsole(long value) { this.console = value; }
}
