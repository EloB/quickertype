package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String literal;
    private long the11;
    private List<Value> values;

    @JsonProperty("literal")
    public String getLiteral() { return literal; }
    @JsonProperty("literal")
    public void setLiteral(String value) { this.literal = value; }

    @JsonProperty("#{1+1}")
    public long getThe11() { return the11; }
    @JsonProperty("#{1+1}")
    public void setThe11(long value) { this.the11 = value; }

    @JsonProperty("values")
    public List<Value> getValues() { return values; }
    @JsonProperty("values")
    public void setValues(List<Value> value) { this.values = value; }
}
