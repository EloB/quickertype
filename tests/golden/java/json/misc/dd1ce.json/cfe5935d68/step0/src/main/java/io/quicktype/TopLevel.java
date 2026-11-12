package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.util.List;

public class TopLevel {
    private List<Booster> booster;
    private String border;
    private List<Card> cards;
    private String code;
    private String gathererCode;
    private String magicCardsInfoCode;
    private long mkmID;
    private String mkmName;
    private String name;
    private LocalDate releaseDate;
    private String type;

    @JsonProperty("booster")
    public List<Booster> getBooster() { return booster; }
    @JsonProperty("booster")
    public void setBooster(List<Booster> value) { this.booster = value; }

    @JsonProperty("border")
    public String getBorder() { return border; }
    @JsonProperty("border")
    public void setBorder(String value) { this.border = value; }

    @JsonProperty("cards")
    public List<Card> getCards() { return cards; }
    @JsonProperty("cards")
    public void setCards(List<Card> value) { this.cards = value; }

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("gathererCode")
    public String getGathererCode() { return gathererCode; }
    @JsonProperty("gathererCode")
    public void setGathererCode(String value) { this.gathererCode = value; }

    @JsonProperty("magicCardsInfoCode")
    public String getMagicCardsInfoCode() { return magicCardsInfoCode; }
    @JsonProperty("magicCardsInfoCode")
    public void setMagicCardsInfoCode(String value) { this.magicCardsInfoCode = value; }

    @JsonProperty("mkm_id")
    public long getMkmID() { return mkmID; }
    @JsonProperty("mkm_id")
    public void setMkmID(long value) { this.mkmID = value; }

    @JsonProperty("mkm_name")
    public String getMkmName() { return mkmName; }
    @JsonProperty("mkm_name")
    public void setMkmName(String value) { this.mkmName = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("releaseDate")
    public LocalDate getReleaseDate() { return releaseDate; }
    @JsonProperty("releaseDate")
    public void setReleaseDate(LocalDate value) { this.releaseDate = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}
