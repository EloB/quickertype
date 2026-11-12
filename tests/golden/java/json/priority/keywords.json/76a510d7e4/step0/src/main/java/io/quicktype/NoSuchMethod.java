package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NoSuchMethod {
    private long noSuchMethod;

    @JsonProperty("noSuchMethod")
    public long getNoSuchMethod() { return noSuchMethod; }
    @JsonProperty("noSuchMethod")
    public void setNoSuchMethod(long value) { this.noSuchMethod = value; }
}
