package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum RankTitle {
    PRESIDENT, ADVISOR, VETERAN, APPLICANT;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PRESIDENT: return "President";
            case ADVISOR: return "Advisor";
            case VETERAN: return "Veteran";
            case APPLICANT: return "Applicant";
        }
        return null;
    }

    @JsonCreator
    public static RankTitle forValue(String value) throws IOException {
        if (value.equals("President")) return PRESIDENT;
        if (value.equals("Advisor")) return ADVISOR;
        if (value.equals("Veteran")) return VETERAN;
        if (value.equals("Applicant")) return APPLICANT;
        throw new IOException("Cannot deserialize RankTitle");
    }
}
