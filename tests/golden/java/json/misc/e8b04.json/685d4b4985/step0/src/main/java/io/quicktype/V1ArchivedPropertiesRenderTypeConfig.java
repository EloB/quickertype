package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class V1ArchivedPropertiesRenderTypeConfig {
    private FluffyVisible visible;

    @JsonProperty("visible")
    public FluffyVisible getVisible() { return visible; }
    @JsonProperty("visible")
    public void setVisible(FluffyVisible value) { this.visible = value; }
}
