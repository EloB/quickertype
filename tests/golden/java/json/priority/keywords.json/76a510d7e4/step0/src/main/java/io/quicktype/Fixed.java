package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Fixed {
    private long fixed;

    @JsonProperty("fixed")
    public long getFixed() { return fixed; }
    @JsonProperty("fixed")
    public void setFixed(long value) { this.fixed = value; }
}
