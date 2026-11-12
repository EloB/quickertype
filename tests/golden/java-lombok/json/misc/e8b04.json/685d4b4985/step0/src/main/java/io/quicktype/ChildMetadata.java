package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ChildMetadata {
    private List<String> customValues;
    private Boolean freeform;
    private Long includeAuto;
    private MetadataOperator operator;
    private TableColumnID tableColumnID;
    private Long unifiedVersion;

    @JsonProperty("customValues")
    public List<String> getCustomValues() { return customValues; }
    @JsonProperty("customValues")
    public void setCustomValues(List<String> value) { this.customValues = value; }

    @JsonProperty("freeform")
    public Boolean getFreeform() { return freeform; }
    @JsonProperty("freeform")
    public void setFreeform(Boolean value) { this.freeform = value; }

    @JsonProperty("includeAuto")
    public Long getIncludeAuto() { return includeAuto; }
    @JsonProperty("includeAuto")
    public void setIncludeAuto(Long value) { this.includeAuto = value; }

    @JsonProperty("operator")
    public MetadataOperator getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(MetadataOperator value) { this.operator = value; }

    @JsonProperty("tableColumnId")
    public TableColumnID getTableColumnID() { return tableColumnID; }
    @JsonProperty("tableColumnId")
    public void setTableColumnID(TableColumnID value) { this.tableColumnID = value; }

    @JsonProperty("unifiedVersion")
    public Long getUnifiedVersion() { return unifiedVersion; }
    @JsonProperty("unifiedVersion")
    public void setUnifiedVersion(Long value) { this.unifiedVersion = value; }
}
