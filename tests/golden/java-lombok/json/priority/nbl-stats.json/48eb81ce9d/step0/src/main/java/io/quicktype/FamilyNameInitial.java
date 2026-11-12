package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FamilyNameInitial {
    R, M, S, C, O, W, A, P, V, I, J, FAMILY_NAME_INITIAL_S, H, B;

    @JsonValue
    public String toValue() {
        switch (this) {
            case R: return "R";
            case M: return "M";
            case S: return "s";
            case C: return "C";
            case O: return "O";
            case W: return "W";
            case A: return "A";
            case P: return "P";
            case V: return "V";
            case I: return "I";
            case J: return "J";
            case FAMILY_NAME_INITIAL_S: return "S";
            case H: return "H";
            case B: return "B";
        }
        return null;
    }

    @JsonCreator
    public static FamilyNameInitial forValue(String value) throws IOException {
        if (value.equals("R")) return R;
        if (value.equals("M")) return M;
        if (value.equals("s")) return S;
        if (value.equals("C")) return C;
        if (value.equals("O")) return O;
        if (value.equals("W")) return W;
        if (value.equals("A")) return A;
        if (value.equals("P")) return P;
        if (value.equals("V")) return V;
        if (value.equals("I")) return I;
        if (value.equals("J")) return J;
        if (value.equals("S")) return FAMILY_NAME_INITIAL_S;
        if (value.equals("H")) return H;
        if (value.equals("B")) return B;
        throw new IOException("Cannot deserialize FamilyNameInitial");
    }
}
