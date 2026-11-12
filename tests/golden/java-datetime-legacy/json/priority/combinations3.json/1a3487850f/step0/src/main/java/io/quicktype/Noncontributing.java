package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Noncontributing {
    private String estevin;
    private double jolterhead;
    private long sauternes;
    private boolean sparsely;
    private Object unrequested;

    @JsonProperty("estevin")
    public String getEstevin() { return estevin; }
    @JsonProperty("estevin")
    public void setEstevin(String value) { this.estevin = value; }

    @JsonProperty("jolterhead")
    public double getJolterhead() { return jolterhead; }
    @JsonProperty("jolterhead")
    public void setJolterhead(double value) { this.jolterhead = value; }

    @JsonProperty("sauternes")
    public long getSauternes() { return sauternes; }
    @JsonProperty("sauternes")
    public void setSauternes(long value) { this.sauternes = value; }

    @JsonProperty("sparsely")
    public boolean getSparsely() { return sparsely; }
    @JsonProperty("sparsely")
    public void setSparsely(boolean value) { this.sparsely = value; }

    @JsonProperty("unrequested")
    public Object getUnrequested() { return unrequested; }
    @JsonProperty("unrequested")
    public void setUnrequested(Object value) { this.unrequested = value; }
}
