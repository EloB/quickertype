package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class RectShape {
    private List<Part> parts;

    @JsonProperty("parts")
    public List<Part> getParts() { return parts; }
    @JsonProperty("parts")
    public void setParts(List<Part> value) { this.parts = value; }
}
