package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Weekdays {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MONDAY: return "Monday";
            case TUESDAY: return "Tuesday";
            case WEDNESDAY: return "Wednesday";
            case THURSDAY: return "Thursday";
            case FRIDAY: return "Friday";
            case SATURDAY: return "Saturday";
            case SUNDAY: return "Sunday";
        }
        return null;
    }

    @JsonCreator
    public static Weekdays forValue(String value) throws IOException {
        if (value.equals("Monday")) return MONDAY;
        if (value.equals("Tuesday")) return TUESDAY;
        if (value.equals("Wednesday")) return WEDNESDAY;
        if (value.equals("Thursday")) return THURSDAY;
        if (value.equals("Friday")) return FRIDAY;
        if (value.equals("Saturday")) return SATURDAY;
        if (value.equals("Sunday")) return SUNDAY;
        throw new IOException("Cannot deserialize Weekdays");
    }
}
