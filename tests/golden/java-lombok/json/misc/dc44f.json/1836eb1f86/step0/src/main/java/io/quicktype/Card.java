package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Card {
    private String artist;
    private long cmc;
    private List<ColorIdentity> colorIdentity;
    private List<Color> colors;
    private String flavor;
    private String id;
    private String imageName;
    private Layout layout;
    private List<LegalityElement> legalities;
    private String manaCost;
    private String mciNumber;
    private long multiverseid;
    private String name;
    private String originalText;
    private String originalType;
    private String power;
    private List<String> printings;
    private Rarity rarity;
    private Boolean reserved;
    private List<Ruling> rulings;
    private List<String> subtypes;
    private List<Supertype> supertypes;
    private String text;
    private String toughness;
    private String type;
    private List<Type> types;
    private List<Long> variations;

    @JsonProperty("artist")
    public String getArtist() { return artist; }
    @JsonProperty("artist")
    public void setArtist(String value) { this.artist = value; }

    @JsonProperty("cmc")
    public long getCmc() { return cmc; }
    @JsonProperty("cmc")
    public void setCmc(long value) { this.cmc = value; }

    @JsonProperty("colorIdentity")
    public List<ColorIdentity> getColorIdentity() { return colorIdentity; }
    @JsonProperty("colorIdentity")
    public void setColorIdentity(List<ColorIdentity> value) { this.colorIdentity = value; }

    @JsonProperty("colors")
    public List<Color> getColors() { return colors; }
    @JsonProperty("colors")
    public void setColors(List<Color> value) { this.colors = value; }

    @JsonProperty("flavor")
    public String getFlavor() { return flavor; }
    @JsonProperty("flavor")
    public void setFlavor(String value) { this.flavor = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("imageName")
    public String getImageName() { return imageName; }
    @JsonProperty("imageName")
    public void setImageName(String value) { this.imageName = value; }

    @JsonProperty("layout")
    public Layout getLayout() { return layout; }
    @JsonProperty("layout")
    public void setLayout(Layout value) { this.layout = value; }

    @JsonProperty("legalities")
    public List<LegalityElement> getLegalities() { return legalities; }
    @JsonProperty("legalities")
    public void setLegalities(List<LegalityElement> value) { this.legalities = value; }

    @JsonProperty("manaCost")
    public String getManaCost() { return manaCost; }
    @JsonProperty("manaCost")
    public void setManaCost(String value) { this.manaCost = value; }

    @JsonProperty("mciNumber")
    public String getMciNumber() { return mciNumber; }
    @JsonProperty("mciNumber")
    public void setMciNumber(String value) { this.mciNumber = value; }

    @JsonProperty("multiverseid")
    public long getMultiverseid() { return multiverseid; }
    @JsonProperty("multiverseid")
    public void setMultiverseid(long value) { this.multiverseid = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("originalText")
    public String getOriginalText() { return originalText; }
    @JsonProperty("originalText")
    public void setOriginalText(String value) { this.originalText = value; }

    @JsonProperty("originalType")
    public String getOriginalType() { return originalType; }
    @JsonProperty("originalType")
    public void setOriginalType(String value) { this.originalType = value; }

    @JsonProperty("power")
    public String getPower() { return power; }
    @JsonProperty("power")
    public void setPower(String value) { this.power = value; }

    @JsonProperty("printings")
    public List<String> getPrintings() { return printings; }
    @JsonProperty("printings")
    public void setPrintings(List<String> value) { this.printings = value; }

    @JsonProperty("rarity")
    public Rarity getRarity() { return rarity; }
    @JsonProperty("rarity")
    public void setRarity(Rarity value) { this.rarity = value; }

    @JsonProperty("reserved")
    public Boolean getReserved() { return reserved; }
    @JsonProperty("reserved")
    public void setReserved(Boolean value) { this.reserved = value; }

    @JsonProperty("rulings")
    public List<Ruling> getRulings() { return rulings; }
    @JsonProperty("rulings")
    public void setRulings(List<Ruling> value) { this.rulings = value; }

    @JsonProperty("subtypes")
    public List<String> getSubtypes() { return subtypes; }
    @JsonProperty("subtypes")
    public void setSubtypes(List<String> value) { this.subtypes = value; }

    @JsonProperty("supertypes")
    public List<Supertype> getSupertypes() { return supertypes; }
    @JsonProperty("supertypes")
    public void setSupertypes(List<Supertype> value) { this.supertypes = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }

    @JsonProperty("toughness")
    public String getToughness() { return toughness; }
    @JsonProperty("toughness")
    public void setToughness(String value) { this.toughness = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("types")
    public List<Type> getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(List<Type> value) { this.types = value; }

    @JsonProperty("variations")
    public List<Long> getVariations() { return variations; }
    @JsonProperty("variations")
    public void setVariations(List<Long> value) { this.variations = value; }
}
