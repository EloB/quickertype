package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Protected {
    private long protectedProtected;

    @JsonProperty("protected")
    public long getProtectedProtected() { return protectedProtected; }
    @JsonProperty("protected")
    public void setProtectedProtected(long value) { this.protectedProtected = value; }
}
