package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UnmarshalJSON {
    private long unmarshalJSON;

    @JsonProperty("UnmarshalJSON")
    public long getUnmarshalJSON() { return unmarshalJSON; }
    @JsonProperty("UnmarshalJSON")
    public void setUnmarshalJSON(long value) { this.unmarshalJSON = value; }
}
