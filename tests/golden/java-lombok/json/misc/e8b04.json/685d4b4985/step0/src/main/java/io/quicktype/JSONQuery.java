package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class JSONQuery {
    private List<Group> group;
    private List<Order> order;
    private List<Select> select;
    private Where where;

    @JsonProperty("group")
    public List<Group> getGroup() { return group; }
    @JsonProperty("group")
    public void setGroup(List<Group> value) { this.group = value; }

    @JsonProperty("order")
    public List<Order> getOrder() { return order; }
    @JsonProperty("order")
    public void setOrder(List<Order> value) { this.order = value; }

    @JsonProperty("select")
    public List<Select> getSelect() { return select; }
    @JsonProperty("select")
    public void setSelect(List<Select> value) { this.select = value; }

    @JsonProperty("where")
    public Where getWhere() { return where; }
    @JsonProperty("where")
    public void setWhere(Where value) { this.where = value; }
}
