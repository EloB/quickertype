package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Deinit {
    private long deinit;

    @JsonProperty("deinit")
    public long getDeinit() { return deinit; }
    @JsonProperty("deinit")
    public void setDeinit(long value) { this.deinit = value; }
}
