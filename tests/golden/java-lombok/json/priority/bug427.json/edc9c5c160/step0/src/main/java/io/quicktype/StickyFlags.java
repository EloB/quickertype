package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StickyFlags {
    private Boolean isAbstract;
    private Boolean isConstructorProperty;
    private Boolean isExported;
    private Boolean isPrivate;
    private Boolean isProtected;
    private Boolean isPublic;
    private Boolean isStatic;

    @JsonProperty("isAbstract")
    public Boolean getIsAbstract() { return isAbstract; }
    @JsonProperty("isAbstract")
    public void setIsAbstract(Boolean value) { this.isAbstract = value; }

    @JsonProperty("isConstructorProperty")
    public Boolean getIsConstructorProperty() { return isConstructorProperty; }
    @JsonProperty("isConstructorProperty")
    public void setIsConstructorProperty(Boolean value) { this.isConstructorProperty = value; }

    @JsonProperty("isExported")
    public Boolean getIsExported() { return isExported; }
    @JsonProperty("isExported")
    public void setIsExported(Boolean value) { this.isExported = value; }

    @JsonProperty("isPrivate")
    public Boolean getIsPrivate() { return isPrivate; }
    @JsonProperty("isPrivate")
    public void setIsPrivate(Boolean value) { this.isPrivate = value; }

    @JsonProperty("isProtected")
    public Boolean getIsProtected() { return isProtected; }
    @JsonProperty("isProtected")
    public void setIsProtected(Boolean value) { this.isProtected = value; }

    @JsonProperty("isPublic")
    public Boolean getIsPublic() { return isPublic; }
    @JsonProperty("isPublic")
    public void setIsPublic(Boolean value) { this.isPublic = value; }

    @JsonProperty("isStatic")
    public Boolean getIsStatic() { return isStatic; }
    @JsonProperty("isStatic")
    public void setIsStatic(Boolean value) { this.isStatic = value; }
}
