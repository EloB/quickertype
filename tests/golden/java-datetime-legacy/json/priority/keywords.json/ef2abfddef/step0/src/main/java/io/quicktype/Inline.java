package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Inline {
    private long inline;

    @JsonProperty("inline")
    public long getInline() { return inline; }
    @JsonProperty("inline")
    public void setInline(long value) { this.inline = value; }
}
