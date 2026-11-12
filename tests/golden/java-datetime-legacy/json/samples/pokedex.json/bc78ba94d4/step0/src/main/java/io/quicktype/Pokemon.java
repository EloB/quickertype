package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Pokemon {
    private double avgSpawns;
    private String candy;
    private Long candyCount;
    private Egg egg;
    private String height;
    private long id;
    private String img;
    private List<Double> multipliers;
    private String name;
    private List<Evolution> nextEvolution;
    private String num;
    private List<Evolution> prevEvolution;
    private double spawnChance;
    private String spawnTime;
    private List<Type> type;
    private List<Type> weaknesses;
    private String weight;

    @JsonProperty("avg_spawns")
    public double getAvgSpawns() { return avgSpawns; }
    @JsonProperty("avg_spawns")
    public void setAvgSpawns(double value) { this.avgSpawns = value; }

    @JsonProperty("candy")
    public String getCandy() { return candy; }
    @JsonProperty("candy")
    public void setCandy(String value) { this.candy = value; }

    @JsonProperty("candy_count")
    public Long getCandyCount() { return candyCount; }
    @JsonProperty("candy_count")
    public void setCandyCount(Long value) { this.candyCount = value; }

    @JsonProperty("egg")
    public Egg getEgg() { return egg; }
    @JsonProperty("egg")
    public void setEgg(Egg value) { this.egg = value; }

    @JsonProperty("height")
    public String getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(String value) { this.height = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("img")
    public String getImg() { return img; }
    @JsonProperty("img")
    public void setImg(String value) { this.img = value; }

    @JsonProperty("multipliers")
    public List<Double> getMultipliers() { return multipliers; }
    @JsonProperty("multipliers")
    public void setMultipliers(List<Double> value) { this.multipliers = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("next_evolution")
    public List<Evolution> getNextEvolution() { return nextEvolution; }
    @JsonProperty("next_evolution")
    public void setNextEvolution(List<Evolution> value) { this.nextEvolution = value; }

    @JsonProperty("num")
    public String getNum() { return num; }
    @JsonProperty("num")
    public void setNum(String value) { this.num = value; }

    @JsonProperty("prev_evolution")
    public List<Evolution> getPrevEvolution() { return prevEvolution; }
    @JsonProperty("prev_evolution")
    public void setPrevEvolution(List<Evolution> value) { this.prevEvolution = value; }

    @JsonProperty("spawn_chance")
    public double getSpawnChance() { return spawnChance; }
    @JsonProperty("spawn_chance")
    public void setSpawnChance(double value) { this.spawnChance = value; }

    @JsonProperty("spawn_time")
    public String getSpawnTime() { return spawnTime; }
    @JsonProperty("spawn_time")
    public void setSpawnTime(String value) { this.spawnTime = value; }

    @JsonProperty("type")
    public List<Type> getType() { return type; }
    @JsonProperty("type")
    public void setType(List<Type> value) { this.type = value; }

    @JsonProperty("weaknesses")
    public List<Type> getWeaknesses() { return weaknesses; }
    @JsonProperty("weaknesses")
    public void setWeaknesses(List<Type> value) { this.weaknesses = value; }

    @JsonProperty("weight")
    public String getWeight() { return weight; }
    @JsonProperty("weight")
    public void setWeight(String value) { this.weight = value; }
}
