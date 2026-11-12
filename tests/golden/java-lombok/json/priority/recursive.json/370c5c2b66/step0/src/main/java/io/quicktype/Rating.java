package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Rating {
    private Useraveragerating useraveragerating;

    @JsonProperty("useraveragerating")
    public Useraveragerating getUseraveragerating() { return useraveragerating; }
    @JsonProperty("useraveragerating")
    public void setUseraveragerating(Useraveragerating value) { this.useraveragerating = value; }
}
