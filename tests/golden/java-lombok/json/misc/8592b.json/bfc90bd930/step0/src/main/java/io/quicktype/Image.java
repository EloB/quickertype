package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Image {
    private String id;
    private List<Source> resolutions;
    private Source source;
    private MediaEmbed variants;

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("resolutions")
    public List<Source> getResolutions() { return resolutions; }
    @JsonProperty("resolutions")
    public void setResolutions(List<Source> value) { this.resolutions = value; }

    @JsonProperty("source")
    public Source getSource() { return source; }
    @JsonProperty("source")
    public void setSource(Source value) { this.source = value; }

    @JsonProperty("variants")
    public MediaEmbed getVariants() { return variants; }
    @JsonProperty("variants")
    public void setVariants(MediaEmbed value) { this.variants = value; }
}
