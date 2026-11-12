package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private double amount;
    private Frequency frequency;
    private String description;
    private Type type;

    @JsonProperty("amount")
    public double getAmount() { return amount; }
    @JsonProperty("amount")
    public void setAmount(double value) { this.amount = value; }

    @JsonProperty("frequency")
    public Frequency getFrequency() { return frequency; }
    @JsonProperty("frequency")
    public void setFrequency(Frequency value) { this.frequency = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }
}
