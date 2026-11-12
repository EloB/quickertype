package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Private {
    private long privatePrivate;

    @JsonProperty("private")
    public long getPrivatePrivate() { return privatePrivate; }
    @JsonProperty("private")
    public void setPrivatePrivate(long value) { this.privatePrivate = value; }
}
