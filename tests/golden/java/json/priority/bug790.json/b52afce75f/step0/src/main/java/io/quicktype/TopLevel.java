package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<TopLevel> childrenData;
    private long id;
    private boolean isActive;
    private long level;
    private String name;
    private long parentID;
    private long position;
    private long productCount;

    @JsonProperty("children_data")
    public List<TopLevel> getChildrenData() { return childrenData; }
    @JsonProperty("children_data")
    public void setChildrenData(List<TopLevel> value) { this.childrenData = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("is_active")
    public boolean getIsActive() { return isActive; }
    @JsonProperty("is_active")
    public void setIsActive(boolean value) { this.isActive = value; }

    @JsonProperty("level")
    public long getLevel() { return level; }
    @JsonProperty("level")
    public void setLevel(long value) { this.level = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("parent_id")
    public long getParentID() { return parentID; }
    @JsonProperty("parent_id")
    public void setParentID(long value) { this.parentID = value; }

    @JsonProperty("position")
    public long getPosition() { return position; }
    @JsonProperty("position")
    public void setPosition(long value) { this.position = value; }

    @JsonProperty("product_count")
    public long getProductCount() { return productCount; }
    @JsonProperty("product_count")
    public void setProductCount(long value) { this.productCount = value; }
}
