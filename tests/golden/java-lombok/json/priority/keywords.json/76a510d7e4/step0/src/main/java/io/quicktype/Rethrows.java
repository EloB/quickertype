package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Rethrows {
    private long rethrows;

    @JsonProperty("rethrows")
    public long getRethrows() { return rethrows; }
    @JsonProperty("rethrows")
    public void setRethrows(long value) { this.rethrows = value; }
}
