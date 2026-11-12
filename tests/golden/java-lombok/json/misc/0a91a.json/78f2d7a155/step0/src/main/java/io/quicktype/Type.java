package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    PUSH_EVENT, CREATE_EVENT, WATCH_EVENT, PULL_REQUEST_EVENT, DELETE_EVENT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PUSH_EVENT: return "PushEvent";
            case CREATE_EVENT: return "CreateEvent";
            case WATCH_EVENT: return "WatchEvent";
            case PULL_REQUEST_EVENT: return "PullRequestEvent";
            case DELETE_EVENT: return "DeleteEvent";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("PushEvent")) return PUSH_EVENT;
        if (value.equals("CreateEvent")) return CREATE_EVENT;
        if (value.equals("WatchEvent")) return WATCH_EVENT;
        if (value.equals("PullRequestEvent")) return PULL_REQUEST_EVENT;
        if (value.equals("DeleteEvent")) return DELETE_EVENT;
        throw new IOException("Cannot deserialize Type");
    }
}
