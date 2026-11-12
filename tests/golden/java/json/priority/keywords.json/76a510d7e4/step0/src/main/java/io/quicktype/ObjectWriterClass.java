package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectWriterClass {
    private long objectWriter;

    @JsonProperty("ObjectWriter")
    public long getObjectWriter() { return objectWriter; }
    @JsonProperty("ObjectWriter")
    public void setObjectWriter(long value) { this.objectWriter = value; }
}
