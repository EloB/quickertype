package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private long integer;
    private List<Long> integers;
    private double number;
    private String string;
    private boolean topLevelBoolean;

    @JsonProperty("integer")
    public long getInteger() { return integer; }
    @JsonProperty("integer")
    public void setInteger(long value) { this.integer = value; }

    @JsonProperty("integers")
    public List<Long> getIntegers() { return integers; }
    @JsonProperty("integers")
    public void setIntegers(List<Long> value) { this.integers = value; }

    @JsonProperty("number")
    public double getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(double value) { this.number = value; }

    @JsonProperty("string")
    public String getString() { return string; }
    @JsonProperty("string")
    public void setString(String value) { this.string = value; }

    @JsonProperty("boolean")
    public boolean getTopLevelBoolean() { return topLevelBoolean; }
    @JsonProperty("boolean")
    public void setTopLevelBoolean(boolean value) { this.topLevelBoolean = value; }
}
