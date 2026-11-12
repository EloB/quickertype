package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Right {
    private long right;

    @JsonProperty("right")
    public long getRight() { return right; }
    @JsonProperty("right")
    public void setRight(long value) { this.right = value; }
}
