package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Printf {
    private long printf;

    @JsonProperty("printf")
    public long getPrintf() { return printf; }
    @JsonProperty("printf")
    public void setPrintf(long value) { this.printf = value; }
}
