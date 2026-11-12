package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Grant {
    private List<GrantFlag> flags;
    private boolean inherited;
    private GrantType type;

    @JsonProperty("flags")
    public List<GrantFlag> getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(List<GrantFlag> value) { this.flags = value; }

    @JsonProperty("inherited")
    public boolean getInherited() { return inherited; }
    @JsonProperty("inherited")
    public void setInherited(boolean value) { this.inherited = value; }

    @JsonProperty("type")
    public GrantType getType() { return type; }
    @JsonProperty("type")
    public void setType(GrantType value) { this.type = value; }
}
