package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String label;
    private double score;

    @JsonProperty("label")
    public String getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(String value) { this.label = value; }

    @JsonProperty("score")
    public double getScore() { return score; }
    @JsonProperty("score")
    public void setScore(double value) { this.score = value; }
}
