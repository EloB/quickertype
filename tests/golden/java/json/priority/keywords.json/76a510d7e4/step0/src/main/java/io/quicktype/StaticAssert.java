package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StaticAssert {
    private long staticAssert;

    @JsonProperty("static_assert")
    public long getStaticAssert() { return staticAssert; }
    @JsonProperty("static_assert")
    public void setStaticAssert(long value) { this.staticAssert = value; }
}
