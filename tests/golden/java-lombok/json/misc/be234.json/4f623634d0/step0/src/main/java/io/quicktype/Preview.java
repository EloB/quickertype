package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Preview {
    private boolean enabled;
    private List<Image> images;

    @JsonProperty("enabled")
    public boolean getEnabled() { return enabled; }
    @JsonProperty("enabled")
    public void setEnabled(boolean value) { this.enabled = value; }

    @JsonProperty("images")
    public List<Image> getImages() { return images; }
    @JsonProperty("images")
    public void setImages(List<Image> value) { this.images = value; }
}
