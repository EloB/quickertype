package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Extends {
    private long extendsExtends;

    @JsonProperty("extends")
    public long getExtendsExtends() { return extendsExtends; }
    @JsonProperty("extends")
    public void setExtendsExtends(long value) { this.extendsExtends = value; }
}
