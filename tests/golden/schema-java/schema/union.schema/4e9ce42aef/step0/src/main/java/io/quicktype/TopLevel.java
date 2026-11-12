package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Long one;
    private boolean two;
    private Double three;

    @JsonProperty("one")
    public Long getOne() { return one; }
    @JsonProperty("one")
    public void setOne(Long value) { this.one = value; }

    @JsonProperty("two")
    public boolean getTwo() { return two; }
    @JsonProperty("two")
    public void setTwo(boolean value) { this.two = value; }

    @JsonProperty("three")
    public Double getThree() { return three; }
    @JsonProperty("three")
    public void setThree(Double value) { this.three = value; }
}
