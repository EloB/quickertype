package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PersonElement {
    private IntOrString intOrString;
    private String name;
    private Boolean optionalValue;

    @JsonProperty("intOrString")
    public IntOrString getIntOrString() { return intOrString; }
    @JsonProperty("intOrString")
    public void setIntOrString(IntOrString value) { this.intOrString = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("optionalValue")
    public Boolean getOptionalValue() { return optionalValue; }
    @JsonProperty("optionalValue")
    public void setOptionalValue(Boolean value) { this.optionalValue = value; }
}
