package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Enum topLevelEnum;

    @JsonProperty("enum")
    public Enum getTopLevelEnum() { return topLevelEnum; }
    @JsonProperty("enum")
    public void setTopLevelEnum(Enum value) { this.topLevelEnum = value; }
}
