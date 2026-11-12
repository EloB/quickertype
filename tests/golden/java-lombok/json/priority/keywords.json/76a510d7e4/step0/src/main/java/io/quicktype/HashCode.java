package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class HashCode {
    private long hashCode;

    @JsonProperty("hashCode")
    public long getHashCode() { return hashCode; }
    @JsonProperty("hashCode")
    public void setHashCode(long value) { this.hashCode = value; }
}
