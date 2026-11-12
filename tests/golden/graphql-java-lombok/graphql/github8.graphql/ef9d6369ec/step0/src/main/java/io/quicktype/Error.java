package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Error {
    private String message;

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }
}
