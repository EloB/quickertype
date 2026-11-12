package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum WhitelistStatus {
    ALL_ADS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case ALL_ADS: return "all_ads";
        }
        return null;
    }

    @JsonCreator
    public static WhitelistStatus forValue(String value) throws IOException {
        if (value.equals("all_ads")) return ALL_ADS;
        throw new IOException("Cannot deserialize WhitelistStatus");
    }
}
