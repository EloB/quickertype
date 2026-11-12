package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FluffyVisible {
    private boolean href;

    @JsonProperty("href")
    public boolean getHref() { return href; }
    @JsonProperty("href")
    public void setHref(boolean value) { this.href = value; }
}
