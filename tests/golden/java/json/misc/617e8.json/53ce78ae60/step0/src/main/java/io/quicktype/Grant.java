package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Grant {
    private List<String> flags;
    private boolean inherited;
    private String type;

    @JsonProperty("flags")
    public List<String> getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(List<String> value) { this.flags = value; }

    @JsonProperty("inherited")
    public boolean getInherited() { return inherited; }
    @JsonProperty("inherited")
    public void setInherited(boolean value) { this.inherited = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
