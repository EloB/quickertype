package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private Meta meta;
    private List<ObjectElement> objects;

    @JsonProperty("meta")
    public Meta getMeta() { return meta; }
    @JsonProperty("meta")
    public void setMeta(Meta value) { this.meta = value; }

    @JsonProperty("objects")
    public List<ObjectElement> getObjects() { return objects; }
    @JsonProperty("objects")
    public void setObjects(List<ObjectElement> value) { this.objects = value; }
}
