package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<MixedElement> mixed;

    @JsonProperty("mixed")
    public List<MixedElement> getMixed() { return mixed; }
    @JsonProperty("mixed")
    public void setMixed(List<MixedElement> value) { this.mixed = value; }
}
