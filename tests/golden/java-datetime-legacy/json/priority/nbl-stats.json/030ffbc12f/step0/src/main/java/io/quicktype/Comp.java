package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Comp {
    private double sAssistsAverage;
    private String sMinutesAverage;
    private double sPointsAverage;
    private double sReboundsTotalAverage;

    @JsonProperty("sAssistsAverage")
    public double getSAssistsAverage() { return sAssistsAverage; }
    @JsonProperty("sAssistsAverage")
    public void setSAssistsAverage(double value) { this.sAssistsAverage = value; }

    @JsonProperty("sMinutesAverage")
    public String getSMinutesAverage() { return sMinutesAverage; }
    @JsonProperty("sMinutesAverage")
    public void setSMinutesAverage(String value) { this.sMinutesAverage = value; }

    @JsonProperty("sPointsAverage")
    public double getSPointsAverage() { return sPointsAverage; }
    @JsonProperty("sPointsAverage")
    public void setSPointsAverage(double value) { this.sPointsAverage = value; }

    @JsonProperty("sReboundsTotalAverage")
    public double getSReboundsTotalAverage() { return sReboundsTotalAverage; }
    @JsonProperty("sReboundsTotalAverage")
    public void setSReboundsTotalAverage(double value) { this.sReboundsTotalAverage = value; }
}
