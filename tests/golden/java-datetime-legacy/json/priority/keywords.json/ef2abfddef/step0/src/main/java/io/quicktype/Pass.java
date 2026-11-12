package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Pass {
    private long pass;

    @JsonProperty("pass")
    public long getPass() { return pass; }
    @JsonProperty("pass")
    public void setPass(long value) { this.pass = value; }
}
