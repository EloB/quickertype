package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.UUID;

public class TopLevel {
    private boolean booleanValue;
    private double doubleValue;
    private long intValue;
    private String stringValue;
    private UUID uuidValue;
    private List<UUID> uuidValues;

    @JsonProperty("booleanValue")
    public boolean getBooleanValue() { return booleanValue; }
    @JsonProperty("booleanValue")
    public void setBooleanValue(boolean value) { this.booleanValue = value; }

    @JsonProperty("doubleValue")
    public double getDoubleValue() { return doubleValue; }
    @JsonProperty("doubleValue")
    public void setDoubleValue(double value) { this.doubleValue = value; }

    @JsonProperty("intValue")
    public long getIntValue() { return intValue; }
    @JsonProperty("intValue")
    public void setIntValue(long value) { this.intValue = value; }

    @JsonProperty("stringValue")
    public String getStringValue() { return stringValue; }
    @JsonProperty("stringValue")
    public void setStringValue(String value) { this.stringValue = value; }

    @JsonProperty("uuidValue")
    public UUID getUUIDValue() { return uuidValue; }
    @JsonProperty("uuidValue")
    public void setUUIDValue(UUID value) { this.uuidValue = value; }

    @JsonProperty("uuidValues")
    public List<UUID> getUUIDValues() { return uuidValues; }
    @JsonProperty("uuidValues")
    public void setUUIDValues(List<UUID> value) { this.uuidValues = value; }
}
