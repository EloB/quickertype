package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CustomFields {
    private Test test;

    @JsonProperty("TEST")
    public Test getTest() { return test; }
    @JsonProperty("TEST")
    public void setTest(Test value) { this.test = value; }
}
