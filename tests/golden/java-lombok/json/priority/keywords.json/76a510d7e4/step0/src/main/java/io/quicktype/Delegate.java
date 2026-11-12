package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Delegate {
    private long delegate;

    @JsonProperty("delegate")
    public long getDelegate() { return delegate; }
    @JsonProperty("delegate")
    public void setDelegate(long value) { this.delegate = value; }
}
