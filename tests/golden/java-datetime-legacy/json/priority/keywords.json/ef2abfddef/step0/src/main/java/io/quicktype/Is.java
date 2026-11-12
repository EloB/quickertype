package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Is {
    private long is;

    @JsonProperty("is")
    public long getIs() { return is; }
    @JsonProperty("is")
    public void setIs(long value) { this.is = value; }
}
