package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private Data data;
    private List<Error> errors;

    @JsonProperty("data")
    public Data getData() { return data; }
    @JsonProperty("data")
    public void setData(Data value) { this.data = value; }

    @JsonProperty("errors")
    public List<Error> getErrors() { return errors; }
    @JsonProperty("errors")
    public void setErrors(List<Error> value) { this.errors = value; }
}
