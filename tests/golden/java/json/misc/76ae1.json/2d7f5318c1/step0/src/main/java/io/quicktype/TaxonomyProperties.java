package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TaxonomyProperties {
    private Property annotations;
    private Property datatypeProperties;
    private Property id;
    private Property label;
    private Property subClassOf;
    private Property type;

    @JsonProperty("annotations")
    public Property getAnnotations() { return annotations; }
    @JsonProperty("annotations")
    public void setAnnotations(Property value) { this.annotations = value; }

    @JsonProperty("datatype_properties")
    public Property getDatatypeProperties() { return datatypeProperties; }
    @JsonProperty("datatype_properties")
    public void setDatatypeProperties(Property value) { this.datatypeProperties = value; }

    @JsonProperty("id")
    public Property getID() { return id; }
    @JsonProperty("id")
    public void setID(Property value) { this.id = value; }

    @JsonProperty("label")
    public Property getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(Property value) { this.label = value; }

    @JsonProperty("sub_class_of")
    public Property getSubClassOf() { return subClassOf; }
    @JsonProperty("sub_class_of")
    public void setSubClassOf(Property value) { this.subClassOf = value; }

    @JsonProperty("type")
    public Property getType() { return type; }
    @JsonProperty("type")
    public void setType(Property value) { this.type = value; }
}
