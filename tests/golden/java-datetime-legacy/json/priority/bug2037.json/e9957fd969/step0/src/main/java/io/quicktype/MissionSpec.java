package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class MissionSpec {
    private Map<String, Objective> objectives;

    @JsonProperty("objectives")
    public Map<String, Objective> getObjectives() { return objectives; }
    @JsonProperty("objectives")
    public void setObjectives(Map<String, Objective> value) { this.objectives = value; }
}
