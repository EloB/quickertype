package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long aboveI32Max;
    private long belowI32Min;
    private long i32Range;
    private long largeBounds;
    private long onlyMaximum;
    private long onlyMinimum;
    private long smallNegative;
    private long smallPositive;
    private long unbounded;

    @JsonProperty("above_i32_max")
    public long getAboveI32Max() { return aboveI32Max; }
    @JsonProperty("above_i32_max")
    public void setAboveI32Max(long value) { this.aboveI32Max = value; }

    @JsonProperty("below_i32_min")
    public long getBelowI32Min() { return belowI32Min; }
    @JsonProperty("below_i32_min")
    public void setBelowI32Min(long value) { this.belowI32Min = value; }

    @JsonProperty("i32_range")
    public long getI32Range() { return i32Range; }
    @JsonProperty("i32_range")
    public void setI32Range(long value) { this.i32Range = value; }

    @JsonProperty("large_bounds")
    public long getLargeBounds() { return largeBounds; }
    @JsonProperty("large_bounds")
    public void setLargeBounds(long value) { this.largeBounds = value; }

    @JsonProperty("only_maximum")
    public long getOnlyMaximum() { return onlyMaximum; }
    @JsonProperty("only_maximum")
    public void setOnlyMaximum(long value) { this.onlyMaximum = value; }

    @JsonProperty("only_minimum")
    public long getOnlyMinimum() { return onlyMinimum; }
    @JsonProperty("only_minimum")
    public void setOnlyMinimum(long value) { this.onlyMinimum = value; }

    @JsonProperty("small_negative")
    public long getSmallNegative() { return smallNegative; }
    @JsonProperty("small_negative")
    public void setSmallNegative(long value) { this.smallNegative = value; }

    @JsonProperty("small_positive")
    public long getSmallPositive() { return smallPositive; }
    @JsonProperty("small_positive")
    public void setSmallPositive(long value) { this.smallPositive = value; }

    @JsonProperty("unbounded")
    public long getUnbounded() { return unbounded; }
    @JsonProperty("unbounded")
    public void setUnbounded(long value) { this.unbounded = value; }
}
