package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, MissionSpec> missionSpecs;

    @JsonProperty("mission_specs")
    public Map<String, MissionSpec> getMissionSpecs() { return missionSpecs; }
    @JsonProperty("mission_specs")
    public void setMissionSpecs(Map<String, MissionSpec> value) { this.missionSpecs = value; }
}
