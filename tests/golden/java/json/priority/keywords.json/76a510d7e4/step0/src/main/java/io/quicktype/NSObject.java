package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NSObject {
    private long nsObject;

    @JsonProperty("NSObject")
    public long getNSObject() { return nsObject; }
    @JsonProperty("NSObject")
    public void setNSObject(long value) { this.nsObject = value; }
}
