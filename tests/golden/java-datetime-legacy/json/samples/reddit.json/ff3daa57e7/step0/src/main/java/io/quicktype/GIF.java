package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class GIF {
    private List<Source> resolutions;
    private Source source;

    @JsonProperty("resolutions")
    public List<Source> getResolutions() { return resolutions; }
    @JsonProperty("resolutions")
    public void setResolutions(List<Source> value) { this.resolutions = value; }

    @JsonProperty("source")
    public Source getSource() { return source; }
    @JsonProperty("source")
    public void setSource(Source value) { this.source = value; }
}
