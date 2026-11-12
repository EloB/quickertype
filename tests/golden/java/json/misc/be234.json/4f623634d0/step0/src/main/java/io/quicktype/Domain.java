package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Domain {
    REDDIT_COM, I_REDD_IT, I_IMGUR_COM, GFYCAT_COM, IMGUR_COM;

    @JsonValue
    public String toValue() {
        switch (this) {
            case REDDIT_COM: return "reddit.com";
            case I_REDD_IT: return "i.redd.it";
            case I_IMGUR_COM: return "i.imgur.com";
            case GFYCAT_COM: return "gfycat.com";
            case IMGUR_COM: return "imgur.com";
        }
        return null;
    }

    @JsonCreator
    public static Domain forValue(String value) throws IOException {
        if (value.equals("reddit.com")) return REDDIT_COM;
        if (value.equals("i.redd.it")) return I_REDD_IT;
        if (value.equals("i.imgur.com")) return I_IMGUR_COM;
        if (value.equals("gfycat.com")) return GFYCAT_COM;
        if (value.equals("imgur.com")) return IMGUR_COM;
        throw new IOException("Cannot deserialize Domain");
    }
}
