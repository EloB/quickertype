package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Readonly {
    private long readonly;

    @JsonProperty("readonly")
    public long getReadonly() { return readonly; }
    @JsonProperty("readonly")
    public void setReadonly(long value) { this.readonly = value; }
}
