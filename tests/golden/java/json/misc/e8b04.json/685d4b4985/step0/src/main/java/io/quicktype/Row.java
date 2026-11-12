package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Row {
    private List<Field> fields;

    @JsonProperty("fields")
    public List<Field> getFields() { return fields; }
    @JsonProperty("fields")
    public void setFields(List<Field> value) { this.fields = value; }
}
