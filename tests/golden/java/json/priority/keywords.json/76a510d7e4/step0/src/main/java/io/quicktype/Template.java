package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Template {
    private long template;

    @JsonProperty("template")
    public long getTemplate() { return template; }
    @JsonProperty("template")
    public void setTemplate(long value) { this.template = value; }
}
