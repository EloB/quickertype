package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Super {
    private long superSuper;

    @JsonProperty("super")
    public long getSuperSuper() { return superSuper; }
    @JsonProperty("super")
    public void setSuperSuper(long value) { this.superSuper = value; }
}
