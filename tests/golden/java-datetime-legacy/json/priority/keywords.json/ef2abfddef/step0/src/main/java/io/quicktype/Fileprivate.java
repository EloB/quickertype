package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Fileprivate {
    private long fileprivate;

    @JsonProperty("fileprivate")
    public long getFileprivate() { return fileprivate; }
    @JsonProperty("fileprivate")
    public void setFileprivate(long value) { this.fileprivate = value; }
}
