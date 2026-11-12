package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class Objective {
    private Map<String, Reward> rewards;

    @JsonProperty("rewards")
    public Map<String, Reward> getRewards() { return rewards; }
    @JsonProperty("rewards")
    public void setRewards(Map<String, Reward> value) { this.rewards = value; }
}
