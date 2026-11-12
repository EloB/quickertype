package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Media {
    private Oembed oembed;
    private String type;

    @JsonProperty("oembed")
    public Oembed getOembed() { return oembed; }
    @JsonProperty("oembed")
    public void setOembed(Oembed value) { this.oembed = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
