package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.UUID;

public class RegExp {
    private UUID regExp;

    @JsonProperty("RegExp")
    public UUID getRegExp() { return regExp; }
    @JsonProperty("RegExp")
    public void setRegExp(UUID value) { this.regExp = value; }
}
