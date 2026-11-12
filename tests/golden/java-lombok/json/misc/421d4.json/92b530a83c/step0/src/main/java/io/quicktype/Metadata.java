package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Metadata {
    private List<String> availableDisplayTypes;
    private String rdfClass;
    private String rdfSubject;
    private RenderTypeConfig renderTypeConfig;
    private String rowIdentifier;

    @JsonProperty("availableDisplayTypes")
    public List<String> getAvailableDisplayTypes() { return availableDisplayTypes; }
    @JsonProperty("availableDisplayTypes")
    public void setAvailableDisplayTypes(List<String> value) { this.availableDisplayTypes = value; }

    @JsonProperty("rdfClass")
    public String getRDFClass() { return rdfClass; }
    @JsonProperty("rdfClass")
    public void setRDFClass(String value) { this.rdfClass = value; }

    @JsonProperty("rdfSubject")
    public String getRDFSubject() { return rdfSubject; }
    @JsonProperty("rdfSubject")
    public void setRDFSubject(String value) { this.rdfSubject = value; }

    @JsonProperty("renderTypeConfig")
    public RenderTypeConfig getRenderTypeConfig() { return renderTypeConfig; }
    @JsonProperty("renderTypeConfig")
    public void setRenderTypeConfig(RenderTypeConfig value) { this.renderTypeConfig = value; }

    @JsonProperty("rowIdentifier")
    public String getRowIdentifier() { return rowIdentifier; }
    @JsonProperty("rowIdentifier")
    public void setRowIdentifier(String value) { this.rowIdentifier = value; }
}
