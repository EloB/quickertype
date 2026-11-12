package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ActionType {
    GAME, PERIOD, THE_3_PT, THE_2_PT, REBOUND, TIMEOUT, FOULON, FOUL, ASSIST, SUBSTITUTION, FREETHROW, STEAL, TURNOVER, BLOCK, JUMPBALL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case GAME: return "game";
            case PERIOD: return "period";
            case THE_3_PT: return "3pt";
            case THE_2_PT: return "2pt";
            case REBOUND: return "rebound";
            case TIMEOUT: return "timeout";
            case FOULON: return "foulon";
            case FOUL: return "foul";
            case ASSIST: return "assist";
            case SUBSTITUTION: return "substitution";
            case FREETHROW: return "freethrow";
            case STEAL: return "steal";
            case TURNOVER: return "turnover";
            case BLOCK: return "block";
            case JUMPBALL: return "jumpball";
        }
        return null;
    }

    @JsonCreator
    public static ActionType forValue(String value) throws IOException {
        if (value.equals("game")) return GAME;
        if (value.equals("period")) return PERIOD;
        if (value.equals("3pt")) return THE_3_PT;
        if (value.equals("2pt")) return THE_2_PT;
        if (value.equals("rebound")) return REBOUND;
        if (value.equals("timeout")) return TIMEOUT;
        if (value.equals("foulon")) return FOULON;
        if (value.equals("foul")) return FOUL;
        if (value.equals("assist")) return ASSIST;
        if (value.equals("substitution")) return SUBSTITUTION;
        if (value.equals("freethrow")) return FREETHROW;
        if (value.equals("steal")) return STEAL;
        if (value.equals("turnover")) return TURNOVER;
        if (value.equals("block")) return BLOCK;
        if (value.equals("jumpball")) return JUMPBALL;
        throw new IOException("Cannot deserialize ActionType");
    }
}
