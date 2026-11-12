package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Noexcept {
    private long noexcept;

    @JsonProperty("noexcept")
    public long getNoexcept() { return noexcept; }
    @JsonProperty("noexcept")
    public void setNoexcept(long value) { this.noexcept = value; }
}
