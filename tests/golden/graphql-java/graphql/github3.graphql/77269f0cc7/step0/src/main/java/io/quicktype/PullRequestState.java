package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PullRequestState {
    OPEN, CLOSED, MERGED;

    @JsonValue
    public String toValue() {
        switch (this) {
            case OPEN: return "OPEN";
            case CLOSED: return "CLOSED";
            case MERGED: return "MERGED";
        }
        return null;
    }

    @JsonCreator
    public static PullRequestState forValue(String value) throws IOException {
        if (value.equals("OPEN")) return OPEN;
        if (value.equals("CLOSED")) return CLOSED;
        if (value.equals("MERGED")) return MERGED;
        throw new IOException("Cannot deserialize PullRequestState");
    }
}
