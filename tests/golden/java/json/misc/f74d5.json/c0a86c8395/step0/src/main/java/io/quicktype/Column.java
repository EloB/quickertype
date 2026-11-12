package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Column {
    private CachedContents cachedContents;
    private TypeName dataTypeName;
    private String fieldName;
    private List<String> flags;
    private Query format;
    private long id;
    private String name;
    private long position;
    private TypeName renderTypeName;
    private Long tableColumnID;
    private Long width;

    @JsonProperty("cachedContents")
    public CachedContents getCachedContents() { return cachedContents; }
    @JsonProperty("cachedContents")
    public void setCachedContents(CachedContents value) { this.cachedContents = value; }

    @JsonProperty("dataTypeName")
    public TypeName getDataTypeName() { return dataTypeName; }
    @JsonProperty("dataTypeName")
    public void setDataTypeName(TypeName value) { this.dataTypeName = value; }

    @JsonProperty("fieldName")
    public String getFieldName() { return fieldName; }
    @JsonProperty("fieldName")
    public void setFieldName(String value) { this.fieldName = value; }

    @JsonProperty("flags")
    public List<String> getFlags() { return flags; }
    @JsonProperty("flags")
    public void setFlags(List<String> value) { this.flags = value; }

    @JsonProperty("format")
    public Query getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(Query value) { this.format = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("position")
    public long getPosition() { return position; }
    @JsonProperty("position")
    public void setPosition(long value) { this.position = value; }

    @JsonProperty("renderTypeName")
    public TypeName getRenderTypeName() { return renderTypeName; }
    @JsonProperty("renderTypeName")
    public void setRenderTypeName(TypeName value) { this.renderTypeName = value; }

    @JsonProperty("tableColumnId")
    public Long getTableColumnID() { return tableColumnID; }
    @JsonProperty("tableColumnId")
    public void setTableColumnID(Long value) { this.tableColumnID = value; }

    @JsonProperty("width")
    public Long getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Long value) { this.width = value; }
}
