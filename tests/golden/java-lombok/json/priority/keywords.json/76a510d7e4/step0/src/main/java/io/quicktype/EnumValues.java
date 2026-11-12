package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class EnumValues {
    private List<EnumValue> enumValues;

    @JsonProperty("EnumValues")
    public List<EnumValue> getEnumValues() { return enumValues; }
    @JsonProperty("EnumValues")
    public void setEnumValues(List<EnumValue> value) { this.enumValues = value; }
}
