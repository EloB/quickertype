package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Prefix {
    private long prefix;

    @JsonProperty("prefix")
    public long getPrefix() { return prefix; }
    @JsonProperty("prefix")
    public void setPrefix(long value) { this.prefix = value; }
}
