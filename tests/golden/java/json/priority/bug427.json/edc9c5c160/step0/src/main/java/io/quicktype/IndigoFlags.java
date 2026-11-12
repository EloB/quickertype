package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IndigoFlags {
    private Boolean isPrivate;
    private Boolean isProtected;

    @JsonProperty("isPrivate")
    public Boolean getIsPrivate() { return isPrivate; }
    @JsonProperty("isPrivate")
    public void setIsPrivate(Boolean value) { this.isPrivate = value; }

    @JsonProperty("isProtected")
    public Boolean getIsProtected() { return isProtected; }
    @JsonProperty("isProtected")
    public void setIsProtected(Boolean value) { this.isProtected = value; }
}
