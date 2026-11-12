package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class BusinessServiceProvidersSearchGet {
    private String description;
    private List<Parameter> parameters;
    private PurpleResponses responses;
    private String summary;
    private List<String> tags;

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("parameters")
    public List<Parameter> getParameters() { return parameters; }
    @JsonProperty("parameters")
    public void setParameters(List<Parameter> value) { this.parameters = value; }

    @JsonProperty("responses")
    public PurpleResponses getResponses() { return responses; }
    @JsonProperty("responses")
    public void setResponses(PurpleResponses value) { this.responses = value; }

    @JsonProperty("summary")
    public String getSummary() { return summary; }
    @JsonProperty("summary")
    public void setSummary(String value) { this.summary = value; }

    @JsonProperty("tags")
    public List<String> getTags() { return tags; }
    @JsonProperty("tags")
    public void setTags(List<String> value) { this.tags = value; }
}
