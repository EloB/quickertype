package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class InterpolateParams {
    private Double gamma;
    private InterpolateParamsType type;

    @JsonProperty("gamma")
    public Double getGamma() { return gamma; }
    @JsonProperty("gamma")
    public void setGamma(Double value) { this.gamma = value; }

    @JsonProperty("type")
    public InterpolateParamsType getType() { return type; }
    @JsonProperty("type")
    public void setType(InterpolateParamsType value) { this.type = value; }
}
