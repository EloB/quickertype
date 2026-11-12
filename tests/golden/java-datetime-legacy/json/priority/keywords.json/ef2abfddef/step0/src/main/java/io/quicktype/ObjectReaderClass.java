package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectReaderClass {
    private long objectReader;

    @JsonProperty("ObjectReader")
    public long getObjectReader() { return objectReader; }
    @JsonProperty("ObjectReader")
    public void setObjectReader(long value) { this.objectReader = value; }
}
