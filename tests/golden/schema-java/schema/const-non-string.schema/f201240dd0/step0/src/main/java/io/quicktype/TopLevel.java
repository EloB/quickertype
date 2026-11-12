package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long amount;
    private boolean enabled;
    private Kind kind;
    private double ratio;
    private double version;

    @JsonProperty("amount")
    public long getAmount() { return amount; }
    @JsonProperty("amount")
    public void setAmount(long value) { this.amount = value; }

    @JsonProperty("enabled")
    public boolean getEnabled() { return enabled; }
    @JsonProperty("enabled")
    public void setEnabled(boolean value) { this.enabled = value; }

    @JsonProperty("kind")
    public Kind getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(Kind value) { this.kind = value; }

    @JsonProperty("ratio")
    public double getRatio() { return ratio; }
    @JsonProperty("ratio")
    public void setRatio(double value) { this.ratio = value; }

    @JsonProperty("version")
    public double getVersion() { return version; }
    @JsonProperty("version")
    public void setVersion(double value) { this.version = value; }
}
