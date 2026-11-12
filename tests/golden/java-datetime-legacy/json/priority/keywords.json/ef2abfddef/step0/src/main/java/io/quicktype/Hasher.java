package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Hasher {
    private long hasher;

    @JsonProperty("Hasher")
    public long getHasher() { return hasher; }
    @JsonProperty("Hasher")
    public void setHasher(long value) { this.hasher = value; }
}
