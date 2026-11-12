package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ViewMetadata {
    private List<Attachment> attachments;
    private List<String> availableDisplayTypes;
    private CustomFields customFields;
    private FilterCondition filterCondition;
    private JSONQuery jsonQuery;
    private String rdfSubject;
    private RenderTypeConfig renderTypeConfig;
    private String rowLabel;

    @JsonProperty("attachments")
    public List<Attachment> getAttachments() { return attachments; }
    @JsonProperty("attachments")
    public void setAttachments(List<Attachment> value) { this.attachments = value; }

    @JsonProperty("availableDisplayTypes")
    public List<String> getAvailableDisplayTypes() { return availableDisplayTypes; }
    @JsonProperty("availableDisplayTypes")
    public void setAvailableDisplayTypes(List<String> value) { this.availableDisplayTypes = value; }

    @JsonProperty("custom_fields")
    public CustomFields getCustomFields() { return customFields; }
    @JsonProperty("custom_fields")
    public void setCustomFields(CustomFields value) { this.customFields = value; }

    @JsonProperty("filterCondition")
    public FilterCondition getFilterCondition() { return filterCondition; }
    @JsonProperty("filterCondition")
    public void setFilterCondition(FilterCondition value) { this.filterCondition = value; }

    @JsonProperty("jsonQuery")
    public JSONQuery getJSONQuery() { return jsonQuery; }
    @JsonProperty("jsonQuery")
    public void setJSONQuery(JSONQuery value) { this.jsonQuery = value; }

    @JsonProperty("rdfSubject")
    public String getRDFSubject() { return rdfSubject; }
    @JsonProperty("rdfSubject")
    public void setRDFSubject(String value) { this.rdfSubject = value; }

    @JsonProperty("renderTypeConfig")
    public RenderTypeConfig getRenderTypeConfig() { return renderTypeConfig; }
    @JsonProperty("renderTypeConfig")
    public void setRenderTypeConfig(RenderTypeConfig value) { this.renderTypeConfig = value; }

    @JsonProperty("rowLabel")
    public String getRowLabel() { return rowLabel; }
    @JsonProperty("rowLabel")
    public void setRowLabel(String value) { this.rowLabel = value; }
}
