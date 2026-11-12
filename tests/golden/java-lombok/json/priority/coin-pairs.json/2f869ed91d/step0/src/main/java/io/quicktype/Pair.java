package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Pair {
    private long decimalPlaces;
    private double fee;
    private long hidden;
    private long maxAmount;
    private long maxPrice;
    private double minAmount;
    private double minPrice;
    private double minTotal;

    @JsonProperty("decimal_places")
    public long getDecimalPlaces() { return decimalPlaces; }
    @JsonProperty("decimal_places")
    public void setDecimalPlaces(long value) { this.decimalPlaces = value; }

    @JsonProperty("fee")
    public double getFee() { return fee; }
    @JsonProperty("fee")
    public void setFee(double value) { this.fee = value; }

    @JsonProperty("hidden")
    public long getHidden() { return hidden; }
    @JsonProperty("hidden")
    public void setHidden(long value) { this.hidden = value; }

    @JsonProperty("max_amount")
    public long getMaxAmount() { return maxAmount; }
    @JsonProperty("max_amount")
    public void setMaxAmount(long value) { this.maxAmount = value; }

    @JsonProperty("max_price")
    public long getMaxPrice() { return maxPrice; }
    @JsonProperty("max_price")
    public void setMaxPrice(long value) { this.maxPrice = value; }

    @JsonProperty("min_amount")
    public double getMinAmount() { return minAmount; }
    @JsonProperty("min_amount")
    public void setMinAmount(double value) { this.minAmount = value; }

    @JsonProperty("min_price")
    public double getMinPrice() { return minPrice; }
    @JsonProperty("min_price")
    public void setMinPrice(double value) { this.minPrice = value; }

    @JsonProperty("min_total")
    public double getMinTotal() { return minTotal; }
    @JsonProperty("min_total")
    public void setMinTotal(double value) { this.minTotal = value; }
}
