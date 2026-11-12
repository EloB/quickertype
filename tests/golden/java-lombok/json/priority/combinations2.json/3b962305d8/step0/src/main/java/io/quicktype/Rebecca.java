package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Rebecca {
    private double catharticalness;
    private long chirotherium;
    private String disdiapason;
    private boolean homocerc;
    private Object nonbookish;

    @JsonProperty("catharticalness")
    public double getCatharticalness() { return catharticalness; }
    @JsonProperty("catharticalness")
    public void setCatharticalness(double value) { this.catharticalness = value; }

    @JsonProperty("Chirotherium")
    public long getChirotherium() { return chirotherium; }
    @JsonProperty("Chirotherium")
    public void setChirotherium(long value) { this.chirotherium = value; }

    @JsonProperty("disdiapason")
    public String getDisdiapason() { return disdiapason; }
    @JsonProperty("disdiapason")
    public void setDisdiapason(String value) { this.disdiapason = value; }

    @JsonProperty("homocerc")
    public boolean getHomocerc() { return homocerc; }
    @JsonProperty("homocerc")
    public void setHomocerc(boolean value) { this.homocerc = value; }

    @JsonProperty("nonbookish")
    public Object getNonbookish() { return nonbookish; }
    @JsonProperty("nonbookish")
    public void setNonbookish(Object value) { this.nonbookish = value; }
}
