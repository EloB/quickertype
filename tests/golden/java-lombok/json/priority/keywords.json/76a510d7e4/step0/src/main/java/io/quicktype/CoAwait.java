package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CoAwait {
    private long coAwait;

    @JsonProperty("co_await")
    public long getCoAwait() { return coAwait; }
    @JsonProperty("co_await")
    public void setCoAwait(long value) { this.coAwait = value; }
}
