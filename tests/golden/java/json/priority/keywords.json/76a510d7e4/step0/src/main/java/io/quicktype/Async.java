package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Async {
    private long async;

    @JsonProperty("async")
    public long getAsync() { return async; }
    @JsonProperty("async")
    public void setAsync(long value) { this.async = value; }
}
