package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevelMetadata {
    private List<DisplayType> availableDisplayTypes;
    private CustomFields customFields;
    private JSONQuery jsonQuery;
    private String rdfClass;
    private String rdfSubject;
    private MetadataRenderTypeConfig renderTypeConfig;
    private RichRendererConfigs richRendererConfigs;
    private String rowIdentifier;
    private String rowLabel;
    private V1ArchivedProperties v1ArchivedProperties;

    @JsonProperty("availableDisplayTypes")
    public List<DisplayType> getAvailableDisplayTypes() { return availableDisplayTypes; }
    @JsonProperty("availableDisplayTypes")
    public void setAvailableDisplayTypes(List<DisplayType> value) { this.availableDisplayTypes = value; }

    @JsonProperty("custom_fields")
    public CustomFields getCustomFields() { return customFields; }
    @JsonProperty("custom_fields")
    public void setCustomFields(CustomFields value) { this.customFields = value; }

    @JsonProperty("jsonQuery")
    public JSONQuery getJSONQuery() { return jsonQuery; }
    @JsonProperty("jsonQuery")
    public void setJSONQuery(JSONQuery value) { this.jsonQuery = value; }

    @JsonProperty("rdfClass")
    public String getRDFClass() { return rdfClass; }
    @JsonProperty("rdfClass")
    public void setRDFClass(String value) { this.rdfClass = value; }

    @JsonProperty("rdfSubject")
    public String getRDFSubject() { return rdfSubject; }
    @JsonProperty("rdfSubject")
    public void setRDFSubject(String value) { this.rdfSubject = value; }

    @JsonProperty("renderTypeConfig")
    public MetadataRenderTypeConfig getRenderTypeConfig() { return renderTypeConfig; }
    @JsonProperty("renderTypeConfig")
    public void setRenderTypeConfig(MetadataRenderTypeConfig value) { this.renderTypeConfig = value; }

    @JsonProperty("richRendererConfigs")
    public RichRendererConfigs getRichRendererConfigs() { return richRendererConfigs; }
    @JsonProperty("richRendererConfigs")
    public void setRichRendererConfigs(RichRendererConfigs value) { this.richRendererConfigs = value; }

    @JsonProperty("rowIdentifier")
    public String getRowIdentifier() { return rowIdentifier; }
    @JsonProperty("rowIdentifier")
    public void setRowIdentifier(String value) { this.rowIdentifier = value; }

    @JsonProperty("rowLabel")
    public String getRowLabel() { return rowLabel; }
    @JsonProperty("rowLabel")
    public void setRowLabel(String value) { this.rowLabel = value; }

    @JsonProperty("v1_archived_properties")
    public V1ArchivedProperties getV1ArchivedProperties() { return v1ArchivedProperties; }
    @JsonProperty("v1_archived_properties")
    public void setV1ArchivedProperties(V1ArchivedProperties value) { this.v1ArchivedProperties = value; }
}
