package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DecodingError {
    private long decodingError;

    @JsonProperty("DecodingError")
    public long getDecodingError() { return decodingError; }
    @JsonProperty("DecodingError")
    public void setDecodingError(long value) { this.decodingError = value; }
}
