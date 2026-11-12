package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Register {
    private long register;

    @JsonProperty("register")
    public long getRegister() { return register; }
    @JsonProperty("register")
    public void setRegister(long value) { this.register = value; }
}
