package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Properties {
    private Annotations annotations;
    private Annotations datatypeProperties;
    private Annotations id;
    private Annotations label;
    private Annotations subClassOf;
    private Annotations type;

    @JsonProperty("annotations")
    public Annotations getAnnotations() { return annotations; }
    @JsonProperty("annotations")
    public void setAnnotations(Annotations value) { this.annotations = value; }

    @JsonProperty("datatype_properties")
    public Annotations getDatatypeProperties() { return datatypeProperties; }
    @JsonProperty("datatype_properties")
    public void setDatatypeProperties(Annotations value) { this.datatypeProperties = value; }

    @JsonProperty("id")
    public Annotations getID() { return id; }
    @JsonProperty("id")
    public void setID(Annotations value) { this.id = value; }

    @JsonProperty("label")
    public Annotations getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(Annotations value) { this.label = value; }

    @JsonProperty("sub_class_of")
    public Annotations getSubClassOf() { return subClassOf; }
    @JsonProperty("sub_class_of")
    public void setSubClassOf(Annotations value) { this.subClassOf = value; }

    @JsonProperty("type")
    public Annotations getType() { return type; }
    @JsonProperty("type")
    public void setType(Annotations value) { this.type = value; }
}
