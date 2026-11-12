package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String myProperty;
    private String secondProperty;

    @JsonProperty("myProperty")
    public String getMyProperty() { return myProperty; }
    @JsonProperty("myProperty")
    public void setMyProperty(String value) { this.myProperty = value; }

    @JsonProperty("secondProperty")
    public String getSecondProperty() { return secondProperty; }
    @JsonProperty("secondProperty")
    public void setSecondProperty(String value) { this.secondProperty = value; }
}
