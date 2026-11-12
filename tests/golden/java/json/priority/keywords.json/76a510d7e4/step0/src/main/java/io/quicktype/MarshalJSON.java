package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MarshalJSON {
    private long marshalJSON;

    @JsonProperty("MarshalJSON")
    public long getMarshalJSON() { return marshalJSON; }
    @JsonProperty("MarshalJSON")
    public void setMarshalJSON(long value) { this.marshalJSON = value; }
}
