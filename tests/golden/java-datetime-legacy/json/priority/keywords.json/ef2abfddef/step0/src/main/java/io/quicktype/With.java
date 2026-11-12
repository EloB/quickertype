package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class With {
    private long with;

    @JsonProperty("with")
    public long getWith() { return with; }
    @JsonProperty("with")
    public void setWith(long value) { this.with = value; }
}
