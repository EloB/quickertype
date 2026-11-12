package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Locale {
    private long locale;

    @JsonProperty("Locale")
    public long getLocale() { return locale; }
    @JsonProperty("Locale")
    public void setLocale(long value) { this.locale = value; }
}
