package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Domain {
    SELF_ANNOUNCEMENTS, I_REDD_IT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case SELF_ANNOUNCEMENTS: return "self.announcements";
            case I_REDD_IT: return "i.redd.it";
        }
        return null;
    }

    @JsonCreator
    public static Domain forValue(String value) throws IOException {
        if (value.equals("self.announcements")) return SELF_ANNOUNCEMENTS;
        if (value.equals("i.redd.it")) return I_REDD_IT;
        throw new IOException("Cannot deserialize Domain");
    }
}
