package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Data {
    private AddReactionPayload addReaction;

    @JsonProperty("addReaction")
    public AddReactionPayload getAddReaction() { return addReaction; }
    @JsonProperty("addReaction")
    public void setAddReaction(AddReactionPayload value) { this.addReaction = value; }
}
