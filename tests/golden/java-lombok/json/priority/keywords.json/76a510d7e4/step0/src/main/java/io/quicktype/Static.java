package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Static {
    private long staticStatic;

    @JsonProperty("static")
    public long getStaticStatic() { return staticStatic; }
    @JsonProperty("static")
    public void setStaticStatic(long value) { this.staticStatic = value; }
}
