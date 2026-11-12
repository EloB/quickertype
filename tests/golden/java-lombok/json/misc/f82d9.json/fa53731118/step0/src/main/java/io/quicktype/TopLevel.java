package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private String basePath;
    private Definitions definitions;
    private String host;
    private Info info;
    private Paths paths;
    private List<String> produces;
    private List<String> schemes;
    private String swagger;

    @JsonProperty("basePath")
    public String getBasePath() { return basePath; }
    @JsonProperty("basePath")
    public void setBasePath(String value) { this.basePath = value; }

    @JsonProperty("definitions")
    public Definitions getDefinitions() { return definitions; }
    @JsonProperty("definitions")
    public void setDefinitions(Definitions value) { this.definitions = value; }

    @JsonProperty("host")
    public String getHost() { return host; }
    @JsonProperty("host")
    public void setHost(String value) { this.host = value; }

    @JsonProperty("info")
    public Info getInfo() { return info; }
    @JsonProperty("info")
    public void setInfo(Info value) { this.info = value; }

    @JsonProperty("paths")
    public Paths getPaths() { return paths; }
    @JsonProperty("paths")
    public void setPaths(Paths value) { this.paths = value; }

    @JsonProperty("produces")
    public List<String> getProduces() { return produces; }
    @JsonProperty("produces")
    public void setProduces(List<String> value) { this.produces = value; }

    @JsonProperty("schemes")
    public List<String> getSchemes() { return schemes; }
    @JsonProperty("schemes")
    public void setSchemes(List<String> value) { this.schemes = value; }

    @JsonProperty("swagger")
    public String getSwagger() { return swagger; }
    @JsonProperty("swagger")
    public void setSwagger(String value) { this.swagger = value; }
}
