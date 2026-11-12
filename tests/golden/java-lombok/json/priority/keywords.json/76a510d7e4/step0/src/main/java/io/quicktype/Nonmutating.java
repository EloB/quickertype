package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Nonmutating {
    private long nonmutating;

    @JsonProperty("nonmutating")
    public long getNonmutating() { return nonmutating; }
    @JsonProperty("nonmutating")
    public void setNonmutating(long value) { this.nonmutating = value; }
}
