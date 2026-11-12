package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Left {
    private long left;

    @JsonProperty("left")
    public long getLeft() { return left; }
    @JsonProperty("left")
    public void setLeft(long value) { this.left = value; }
}
