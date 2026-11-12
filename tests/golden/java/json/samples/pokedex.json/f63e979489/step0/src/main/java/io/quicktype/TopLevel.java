package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Pokemon> pokemon;

    @JsonProperty("pokemon")
    public List<Pokemon> getPokemon() { return pokemon; }
    @JsonProperty("pokemon")
    public void setPokemon(List<Pokemon> value) { this.pokemon = value; }
}
