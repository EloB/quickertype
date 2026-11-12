package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Interacinar {
    private double assapan;
    private boolean benefactorship;
    private String triseriatim;
    private long tubbing;
    private Object untrimmed;

    @JsonProperty("assapan")
    public double getAssapan() { return assapan; }
    @JsonProperty("assapan")
    public void setAssapan(double value) { this.assapan = value; }

    @JsonProperty("benefactorship")
    public boolean getBenefactorship() { return benefactorship; }
    @JsonProperty("benefactorship")
    public void setBenefactorship(boolean value) { this.benefactorship = value; }

    @JsonProperty("triseriatim")
    public String getTriseriatim() { return triseriatim; }
    @JsonProperty("triseriatim")
    public void setTriseriatim(String value) { this.triseriatim = value; }

    @JsonProperty("tubbing")
    public long getTubbing() { return tubbing; }
    @JsonProperty("tubbing")
    public void setTubbing(long value) { this.tubbing = value; }

    @JsonProperty("untrimmed")
    public Object getUntrimmed() { return untrimmed; }
    @JsonProperty("untrimmed")
    public void setUntrimmed(Object value) { this.untrimmed = value; }
}
