package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Throws {
    private long throwsThrows;

    @JsonProperty("throws")
    public long getThrowsThrows() { return throwsThrows; }
    @JsonProperty("throws")
    public void setThrowsThrows(long value) { this.throwsThrows = value; }
}
