package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AddReactionPayload {
    private String clientMutationID;
    private Reaction reaction;
    private Reactable subject;

    @JsonProperty("clientMutationId")
    public String getClientMutationID() { return clientMutationID; }
    @JsonProperty("clientMutationId")
    public void setClientMutationID(String value) { this.clientMutationID = value; }

    @JsonProperty("reaction")
    public Reaction getReaction() { return reaction; }
    @JsonProperty("reaction")
    public void setReaction(Reaction value) { this.reaction = value; }

    @JsonProperty("subject")
    public Reactable getSubject() { return subject; }
    @JsonProperty("subject")
    public void setSubject(Reactable value) { this.subject = value; }
}
