package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurpleFlags {
    private Boolean isExported;

    @JsonProperty("isExported")
    public Boolean getIsExported() { return isExported; }
    @JsonProperty("isExported")
    public void setIsExported(Boolean value) { this.isExported = value; }
}
