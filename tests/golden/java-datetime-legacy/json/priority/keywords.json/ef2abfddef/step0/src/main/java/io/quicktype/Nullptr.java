package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Nullptr {
    private long nullptr;

    @JsonProperty("nullptr")
    public long getNullptr() { return nullptr; }
    @JsonProperty("nullptr")
    public void setNullptr(long value) { this.nullptr = value; }
}
