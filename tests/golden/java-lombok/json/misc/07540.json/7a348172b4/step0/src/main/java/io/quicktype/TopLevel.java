package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Cookies cookies;

    @JsonProperty("cookies")
    public Cookies getCookies() { return cookies; }
    @JsonProperty("cookies")
    public void setCookies(Cookies value) { this.cookies = value; }
}
