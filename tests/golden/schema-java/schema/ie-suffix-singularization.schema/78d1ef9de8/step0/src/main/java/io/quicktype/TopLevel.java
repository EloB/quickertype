package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Cookie> cookies;

    @JsonProperty("cookies")
    public List<Cookie> getCookies() { return cookies; }
    @JsonProperty("cookies")
    public void setCookies(List<Cookie> value) { this.cookies = value; }
}
