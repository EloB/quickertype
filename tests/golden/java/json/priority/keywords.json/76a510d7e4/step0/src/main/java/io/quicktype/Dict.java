package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Dict {
    private long dict;

    @JsonProperty("dict")
    public long getDict() { return dict; }
    @JsonProperty("dict")
    public void setDict(long value) { this.dict = value; }
}
