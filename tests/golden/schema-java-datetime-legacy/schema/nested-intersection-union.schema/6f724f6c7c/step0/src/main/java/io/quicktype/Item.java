package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Item {
    private String content;
    private String id;
    private String output;
    private String summary;

    @JsonProperty("content")
    public String getContent() { return content; }
    @JsonProperty("content")
    public void setContent(String value) { this.content = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("output")
    public String getOutput() { return output; }
    @JsonProperty("output")
    public void setOutput(String value) { this.output = value; }

    @JsonProperty("summary")
    public String getSummary() { return summary; }
    @JsonProperty("summary")
    public void setSummary(String value) { this.summary = value; }
}
