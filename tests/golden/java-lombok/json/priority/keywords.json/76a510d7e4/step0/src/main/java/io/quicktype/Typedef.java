package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Typedef {
    private long typedef;

    @JsonProperty("typedef")
    public long getTypedef() { return typedef; }
    @JsonProperty("typedef")
    public void setTypedef(long value) { this.typedef = value; }
}
