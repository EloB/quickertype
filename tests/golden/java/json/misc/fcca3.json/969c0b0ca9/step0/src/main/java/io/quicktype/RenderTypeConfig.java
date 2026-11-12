package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class RenderTypeConfig {
    private Visible visible;

    @JsonProperty("visible")
    public Visible getVisible() { return visible; }
    @JsonProperty("visible")
    public void setVisible(Visible value) { this.visible = value; }
}
