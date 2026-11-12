package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Rates {
    private Double parking;
    private Double reduced;
    private Double reduced1;
    private Double reduced2;
    private double standard;
    private Double superReduced;

    @JsonProperty("parking")
    public Double getParking() { return parking; }
    @JsonProperty("parking")
    public void setParking(Double value) { this.parking = value; }

    @JsonProperty("reduced")
    public Double getReduced() { return reduced; }
    @JsonProperty("reduced")
    public void setReduced(Double value) { this.reduced = value; }

    @JsonProperty("reduced1")
    public Double getReduced1() { return reduced1; }
    @JsonProperty("reduced1")
    public void setReduced1(Double value) { this.reduced1 = value; }

    @JsonProperty("reduced2")
    public Double getReduced2() { return reduced2; }
    @JsonProperty("reduced2")
    public void setReduced2(Double value) { this.reduced2 = value; }

    @JsonProperty("standard")
    public double getStandard() { return standard; }
    @JsonProperty("standard")
    public void setStandard(double value) { this.standard = value; }

    @JsonProperty("super_reduced")
    public Double getSuperReduced() { return superReduced; }
    @JsonProperty("super_reduced")
    public void setSuperReduced(Double value) { this.superReduced = value; }
}
