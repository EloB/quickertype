package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MetadataRenderTypeConfig {
    private PurpleVisible visible;

    @JsonProperty("visible")
    public PurpleVisible getVisible() { return visible; }
    @JsonProperty("visible")
    public void setVisible(PurpleVisible value) { this.visible = value; }
}
