package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Format {
    private FormatsClass formats;

    @JsonProperty("formats")
    public FormatsClass getFormats() { return formats; }
    @JsonProperty("formats")
    public void setFormats(FormatsClass value) { this.formats = value; }
}
