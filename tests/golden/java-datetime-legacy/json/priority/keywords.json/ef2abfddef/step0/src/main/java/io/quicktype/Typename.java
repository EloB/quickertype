package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Typename {
    private long typename;

    @JsonProperty("typename")
    public long getTypename() { return typename; }
    @JsonProperty("typename")
    public void setTypename(long value) { this.typename = value; }
}
