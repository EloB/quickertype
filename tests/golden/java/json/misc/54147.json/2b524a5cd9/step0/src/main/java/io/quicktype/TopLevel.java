package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Args args;
    private String data;
    private Args files;
    private Args form;
    private Headers headers;
    private String origin;
    private String url;

    @JsonProperty("args")
    public Args getArgs() { return args; }
    @JsonProperty("args")
    public void setArgs(Args value) { this.args = value; }

    @JsonProperty("data")
    public String getData() { return data; }
    @JsonProperty("data")
    public void setData(String value) { this.data = value; }

    @JsonProperty("files")
    public Args getFiles() { return files; }
    @JsonProperty("files")
    public void setFiles(Args value) { this.files = value; }

    @JsonProperty("form")
    public Args getForm() { return form; }
    @JsonProperty("form")
    public void setForm(Args value) { this.form = value; }

    @JsonProperty("headers")
    public Headers getHeaders() { return headers; }
    @JsonProperty("headers")
    public void setHeaders(Headers value) { this.headers = value; }

    @JsonProperty("origin")
    public String getOrigin() { return origin; }
    @JsonProperty("origin")
    public void setOrigin(String value) { this.origin = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}
