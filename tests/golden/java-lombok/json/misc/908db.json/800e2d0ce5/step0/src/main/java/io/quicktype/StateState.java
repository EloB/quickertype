package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StateState {
    private String stateID;
    private String stateName;

    @JsonProperty("state_id")
    public String getStateID() { return stateID; }
    @JsonProperty("state_id")
    public void setStateID(String value) { this.stateID = value; }

    @JsonProperty("state_name")
    public String getStateName() { return stateName; }
    @JsonProperty("state_name")
    public void setStateName(String value) { this.stateName = value; }
}
