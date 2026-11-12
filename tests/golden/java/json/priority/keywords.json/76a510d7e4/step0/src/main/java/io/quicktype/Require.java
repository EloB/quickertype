package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Require {
    private long require;

    @JsonProperty("require")
    public long getRequire() { return require; }
    @JsonProperty("require")
    public void setRequire(long value) { this.require = value; }
}
