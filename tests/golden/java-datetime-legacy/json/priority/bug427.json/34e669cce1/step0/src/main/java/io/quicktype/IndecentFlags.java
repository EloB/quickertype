package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IndecentFlags {
    private Boolean hasExportAssignment;
    private Boolean isAbstract;
    private Boolean isConst;
    private Boolean isExported;
    private Boolean isLet;
    private Boolean isPrivate;
    private Boolean isProtected;

    @JsonProperty("hasExportAssignment")
    public Boolean getHasExportAssignment() { return hasExportAssignment; }
    @JsonProperty("hasExportAssignment")
    public void setHasExportAssignment(Boolean value) { this.hasExportAssignment = value; }

    @JsonProperty("isAbstract")
    public Boolean getIsAbstract() { return isAbstract; }
    @JsonProperty("isAbstract")
    public void setIsAbstract(Boolean value) { this.isAbstract = value; }

    @JsonProperty("isConst")
    public Boolean getIsConst() { return isConst; }
    @JsonProperty("isConst")
    public void setIsConst(Boolean value) { this.isConst = value; }

    @JsonProperty("isExported")
    public Boolean getIsExported() { return isExported; }
    @JsonProperty("isExported")
    public void setIsExported(Boolean value) { this.isExported = value; }

    @JsonProperty("isLet")
    public Boolean getIsLet() { return isLet; }
    @JsonProperty("isLet")
    public void setIsLet(Boolean value) { this.isLet = value; }

    @JsonProperty("isPrivate")
    public Boolean getIsPrivate() { return isPrivate; }
    @JsonProperty("isPrivate")
    public void setIsPrivate(Boolean value) { this.isPrivate = value; }

    @JsonProperty("isProtected")
    public Boolean getIsProtected() { return isProtected; }
    @JsonProperty("isProtected")
    public void setIsProtected(Boolean value) { this.isProtected = value; }
}
