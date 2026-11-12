package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Await {
    private long await;

    @JsonProperty("await")
    public long getAwait() { return await; }
    @JsonProperty("await")
    public void setAwait(long value) { this.await = value; }
}
