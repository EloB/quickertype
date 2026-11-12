package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ScoreboardName {
    EMPTY, T_S, R_IHATA, D_JONES, B_VALENTINE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case EMPTY: return "";
            case T_S: return "T. s";
            case R_IHATA: return "R. Ihata";
            case D_JONES: return "D. Jones";
            case B_VALENTINE: return "B. Valentine";
        }
        return null;
    }

    @JsonCreator
    public static ScoreboardName forValue(String value) throws IOException {
        if (value.equals("")) return EMPTY;
        if (value.equals("T. s")) return T_S;
        if (value.equals("R. Ihata")) return R_IHATA;
        if (value.equals("D. Jones")) return D_JONES;
        if (value.equals("B. Valentine")) return B_VALENTINE;
        throw new IOException("Cannot deserialize ScoreboardName");
    }
}
