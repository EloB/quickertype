package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Get {
    private long get;

    @JsonProperty("get")
    public long getGet() { return get; }
    @JsonProperty("get")
    public void setGet(long value) { this.get = value; }
}
