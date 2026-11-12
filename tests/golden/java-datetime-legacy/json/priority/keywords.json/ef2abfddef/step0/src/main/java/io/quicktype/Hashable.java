package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Hashable {
    private long hashable;

    @JsonProperty("Hashable")
    public long getHashable() { return hashable; }
    @JsonProperty("Hashable")
    public void setHashable(long value) { this.hashable = value; }
}
