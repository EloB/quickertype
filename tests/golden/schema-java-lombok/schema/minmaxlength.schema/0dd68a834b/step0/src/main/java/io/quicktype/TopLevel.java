package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String intersection;
    private InUnion inUnion;
    private String maxlength;
    private String minlength;
    private String minMaxIntersection;
    private String minmaxlength;
    private String minMaxUnion;
    private String union;

    @JsonProperty("intersection")
    public String getIntersection() { return intersection; }
    @JsonProperty("intersection")
    public void setIntersection(String value) { this.intersection = value; }

    @JsonProperty("inUnion")
    public InUnion getInUnion() { return inUnion; }
    @JsonProperty("inUnion")
    public void setInUnion(InUnion value) { this.inUnion = value; }

    @JsonProperty("maxlength")
    public String getMaxlength() { return maxlength; }
    @JsonProperty("maxlength")
    public void setMaxlength(String value) { this.maxlength = value; }

    @JsonProperty("minlength")
    public String getMinlength() { return minlength; }
    @JsonProperty("minlength")
    public void setMinlength(String value) { this.minlength = value; }

    @JsonProperty("minMaxIntersection")
    public String getMinMaxIntersection() { return minMaxIntersection; }
    @JsonProperty("minMaxIntersection")
    public void setMinMaxIntersection(String value) { this.minMaxIntersection = value; }

    @JsonProperty("minmaxlength")
    public String getMinmaxlength() { return minmaxlength; }
    @JsonProperty("minmaxlength")
    public void setMinmaxlength(String value) { this.minmaxlength = value; }

    @JsonProperty("minMaxUnion")
    public String getMinMaxUnion() { return minMaxUnion; }
    @JsonProperty("minMaxUnion")
    public void setMinMaxUnion(String value) { this.minMaxUnion = value; }

    @JsonProperty("union")
    public String getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(String value) { this.union = value; }
}
