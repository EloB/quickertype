package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class SchemeParams {
    private List<Double> extent;
    private String name;

    /**
     * For sequential and diverging schemes only, determines the extent of the color range to
     * use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
     * range _[0, 0.2)_ are excluded from the scheme.
     */
    @JsonProperty("extent")
    public List<Double> getExtent() { return extent; }
    @JsonProperty("extent")
    public void setExtent(List<Double> value) { this.extent = value; }

    /**
     * A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
     *
     * For the full list of supported scheme, please refer to the [Vega
     * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
     */
    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
