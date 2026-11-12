package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Mutable {
    private long mutable;

    @JsonProperty("mutable")
    public long getMutable() { return mutable; }
    @JsonProperty("mutable")
    public void setMutable(long value) { this.mutable = value; }
}
