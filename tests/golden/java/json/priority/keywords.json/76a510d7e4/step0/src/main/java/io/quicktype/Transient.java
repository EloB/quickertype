package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Transient {
    private long transientTransient;

    @JsonProperty("transient")
    public long getTransientTransient() { return transientTransient; }
    @JsonProperty("transient")
    public void setTransientTransient(long value) { this.transientTransient = value; }
}
