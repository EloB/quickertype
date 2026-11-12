package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Pl {
    private long active;
    private Long captain;
    private Comp comp;
    private long eff1;
    private long eff2;
    private double eff3;
    private double eff4;
    private long eff5;
    private long eff6;
    private long eff7;
    private String familyName;
    private FamilyNameInitial familyNameInitial;
    private String firstName;
    private FirstNameInitial firstNameInitial;
    private String internationalFamilyName;
    private FamilyNameInitial internationalFamilyNameInitial;
    private String internationalFirstName;
    private FirstNameInitial internationalFirstNameInitial;
    private String name;
    private String playingPosition;
    private long sAssists;
    private long sBlocks;
    private long sBlocksReceived;
    private long sFieldGoalsAttempted;
    private long sFieldGoalsMade;
    private long sFieldGoalsPercentage;
    private long sFoulsOn;
    private long sFoulsPersonal;
    private long sFreeThrowsAttempted;
    private long sFreeThrowsMade;
    private long sFreeThrowsPercentage;
    private SMinutes sMinutes;
    private long sPlusMinusPoints;
    private long sPoints;
    private long sPointsFastBreak;
    private long sPointsInThePaint;
    private long sPointsSecondChance;
    private long sReboundsDefensive;
    private long sReboundsOffensive;
    private long sReboundsTotal;
    private long sSteals;
    private long sThreePointersAttempted;
    private long sThreePointersMade;
    private long sThreePointersPercentage;
    private long sTurnovers;
    private long sTwoPointersAttempted;
    private long sTwoPointersMade;
    private long sTwoPointersPercentage;
    private String shirtNumber;
    private long starter;

    @JsonProperty("active")
    public long getActive() { return active; }
    @JsonProperty("active")
    public void setActive(long value) { this.active = value; }

    @JsonProperty("captain")
    public Long getCaptain() { return captain; }
    @JsonProperty("captain")
    public void setCaptain(Long value) { this.captain = value; }

    @JsonProperty("comp")
    public Comp getComp() { return comp; }
    @JsonProperty("comp")
    public void setComp(Comp value) { this.comp = value; }

    @JsonProperty("eff_1")
    public long getEff1() { return eff1; }
    @JsonProperty("eff_1")
    public void setEff1(long value) { this.eff1 = value; }

    @JsonProperty("eff_2")
    public long getEff2() { return eff2; }
    @JsonProperty("eff_2")
    public void setEff2(long value) { this.eff2 = value; }

    @JsonProperty("eff_3")
    public double getEff3() { return eff3; }
    @JsonProperty("eff_3")
    public void setEff3(double value) { this.eff3 = value; }

    @JsonProperty("eff_4")
    public double getEff4() { return eff4; }
    @JsonProperty("eff_4")
    public void setEff4(double value) { this.eff4 = value; }

    @JsonProperty("eff_5")
    public long getEff5() { return eff5; }
    @JsonProperty("eff_5")
    public void setEff5(long value) { this.eff5 = value; }

    @JsonProperty("eff_6")
    public long getEff6() { return eff6; }
    @JsonProperty("eff_6")
    public void setEff6(long value) { this.eff6 = value; }

    @JsonProperty("eff_7")
    public long getEff7() { return eff7; }
    @JsonProperty("eff_7")
    public void setEff7(long value) { this.eff7 = value; }

    @JsonProperty("familyName")
    public String getFamilyName() { return familyName; }
    @JsonProperty("familyName")
    public void setFamilyName(String value) { this.familyName = value; }

    @JsonProperty("familyNameInitial")
    public FamilyNameInitial getFamilyNameInitial() { return familyNameInitial; }
    @JsonProperty("familyNameInitial")
    public void setFamilyNameInitial(FamilyNameInitial value) { this.familyNameInitial = value; }

    @JsonProperty("firstName")
    public String getFirstName() { return firstName; }
    @JsonProperty("firstName")
    public void setFirstName(String value) { this.firstName = value; }

    @JsonProperty("firstNameInitial")
    public FirstNameInitial getFirstNameInitial() { return firstNameInitial; }
    @JsonProperty("firstNameInitial")
    public void setFirstNameInitial(FirstNameInitial value) { this.firstNameInitial = value; }

    @JsonProperty("internationalFamilyName")
    public String getInternationalFamilyName() { return internationalFamilyName; }
    @JsonProperty("internationalFamilyName")
    public void setInternationalFamilyName(String value) { this.internationalFamilyName = value; }

    @JsonProperty("internationalFamilyNameInitial")
    public FamilyNameInitial getInternationalFamilyNameInitial() { return internationalFamilyNameInitial; }
    @JsonProperty("internationalFamilyNameInitial")
    public void setInternationalFamilyNameInitial(FamilyNameInitial value) { this.internationalFamilyNameInitial = value; }

    @JsonProperty("internationalFirstName")
    public String getInternationalFirstName() { return internationalFirstName; }
    @JsonProperty("internationalFirstName")
    public void setInternationalFirstName(String value) { this.internationalFirstName = value; }

    @JsonProperty("internationalFirstNameInitial")
    public FirstNameInitial getInternationalFirstNameInitial() { return internationalFirstNameInitial; }
    @JsonProperty("internationalFirstNameInitial")
    public void setInternationalFirstNameInitial(FirstNameInitial value) { this.internationalFirstNameInitial = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("playingPosition")
    public String getPlayingPosition() { return playingPosition; }
    @JsonProperty("playingPosition")
    public void setPlayingPosition(String value) { this.playingPosition = value; }

    @JsonProperty("sAssists")
    public long getSAssists() { return sAssists; }
    @JsonProperty("sAssists")
    public void setSAssists(long value) { this.sAssists = value; }

    @JsonProperty("sBlocks")
    public long getSBlocks() { return sBlocks; }
    @JsonProperty("sBlocks")
    public void setSBlocks(long value) { this.sBlocks = value; }

    @JsonProperty("sBlocksReceived")
    public long getSBlocksReceived() { return sBlocksReceived; }
    @JsonProperty("sBlocksReceived")
    public void setSBlocksReceived(long value) { this.sBlocksReceived = value; }

    @JsonProperty("sFieldGoalsAttempted")
    public long getSFieldGoalsAttempted() { return sFieldGoalsAttempted; }
    @JsonProperty("sFieldGoalsAttempted")
    public void setSFieldGoalsAttempted(long value) { this.sFieldGoalsAttempted = value; }

    @JsonProperty("sFieldGoalsMade")
    public long getSFieldGoalsMade() { return sFieldGoalsMade; }
    @JsonProperty("sFieldGoalsMade")
    public void setSFieldGoalsMade(long value) { this.sFieldGoalsMade = value; }

    @JsonProperty("sFieldGoalsPercentage")
    public long getSFieldGoalsPercentage() { return sFieldGoalsPercentage; }
    @JsonProperty("sFieldGoalsPercentage")
    public void setSFieldGoalsPercentage(long value) { this.sFieldGoalsPercentage = value; }

    @JsonProperty("sFoulsOn")
    public long getSFoulsOn() { return sFoulsOn; }
    @JsonProperty("sFoulsOn")
    public void setSFoulsOn(long value) { this.sFoulsOn = value; }

    @JsonProperty("sFoulsPersonal")
    public long getSFoulsPersonal() { return sFoulsPersonal; }
    @JsonProperty("sFoulsPersonal")
    public void setSFoulsPersonal(long value) { this.sFoulsPersonal = value; }

    @JsonProperty("sFreeThrowsAttempted")
    public long getSFreeThrowsAttempted() { return sFreeThrowsAttempted; }
    @JsonProperty("sFreeThrowsAttempted")
    public void setSFreeThrowsAttempted(long value) { this.sFreeThrowsAttempted = value; }

    @JsonProperty("sFreeThrowsMade")
    public long getSFreeThrowsMade() { return sFreeThrowsMade; }
    @JsonProperty("sFreeThrowsMade")
    public void setSFreeThrowsMade(long value) { this.sFreeThrowsMade = value; }

    @JsonProperty("sFreeThrowsPercentage")
    public long getSFreeThrowsPercentage() { return sFreeThrowsPercentage; }
    @JsonProperty("sFreeThrowsPercentage")
    public void setSFreeThrowsPercentage(long value) { this.sFreeThrowsPercentage = value; }

    @JsonProperty("sMinutes")
    public SMinutes getSMinutes() { return sMinutes; }
    @JsonProperty("sMinutes")
    public void setSMinutes(SMinutes value) { this.sMinutes = value; }

    @JsonProperty("sPlusMinusPoints")
    public long getSPlusMinusPoints() { return sPlusMinusPoints; }
    @JsonProperty("sPlusMinusPoints")
    public void setSPlusMinusPoints(long value) { this.sPlusMinusPoints = value; }

    @JsonProperty("sPoints")
    public long getSPoints() { return sPoints; }
    @JsonProperty("sPoints")
    public void setSPoints(long value) { this.sPoints = value; }

    @JsonProperty("sPointsFastBreak")
    public long getSPointsFastBreak() { return sPointsFastBreak; }
    @JsonProperty("sPointsFastBreak")
    public void setSPointsFastBreak(long value) { this.sPointsFastBreak = value; }

    @JsonProperty("sPointsInThePaint")
    public long getSPointsInThePaint() { return sPointsInThePaint; }
    @JsonProperty("sPointsInThePaint")
    public void setSPointsInThePaint(long value) { this.sPointsInThePaint = value; }

    @JsonProperty("sPointsSecondChance")
    public long getSPointsSecondChance() { return sPointsSecondChance; }
    @JsonProperty("sPointsSecondChance")
    public void setSPointsSecondChance(long value) { this.sPointsSecondChance = value; }

    @JsonProperty("sReboundsDefensive")
    public long getSReboundsDefensive() { return sReboundsDefensive; }
    @JsonProperty("sReboundsDefensive")
    public void setSReboundsDefensive(long value) { this.sReboundsDefensive = value; }

    @JsonProperty("sReboundsOffensive")
    public long getSReboundsOffensive() { return sReboundsOffensive; }
    @JsonProperty("sReboundsOffensive")
    public void setSReboundsOffensive(long value) { this.sReboundsOffensive = value; }

    @JsonProperty("sReboundsTotal")
    public long getSReboundsTotal() { return sReboundsTotal; }
    @JsonProperty("sReboundsTotal")
    public void setSReboundsTotal(long value) { this.sReboundsTotal = value; }

    @JsonProperty("sSteals")
    public long getSSteals() { return sSteals; }
    @JsonProperty("sSteals")
    public void setSSteals(long value) { this.sSteals = value; }

    @JsonProperty("sThreePointersAttempted")
    public long getSThreePointersAttempted() { return sThreePointersAttempted; }
    @JsonProperty("sThreePointersAttempted")
    public void setSThreePointersAttempted(long value) { this.sThreePointersAttempted = value; }

    @JsonProperty("sThreePointersMade")
    public long getSThreePointersMade() { return sThreePointersMade; }
    @JsonProperty("sThreePointersMade")
    public void setSThreePointersMade(long value) { this.sThreePointersMade = value; }

    @JsonProperty("sThreePointersPercentage")
    public long getSThreePointersPercentage() { return sThreePointersPercentage; }
    @JsonProperty("sThreePointersPercentage")
    public void setSThreePointersPercentage(long value) { this.sThreePointersPercentage = value; }

    @JsonProperty("sTurnovers")
    public long getSTurnovers() { return sTurnovers; }
    @JsonProperty("sTurnovers")
    public void setSTurnovers(long value) { this.sTurnovers = value; }

    @JsonProperty("sTwoPointersAttempted")
    public long getSTwoPointersAttempted() { return sTwoPointersAttempted; }
    @JsonProperty("sTwoPointersAttempted")
    public void setSTwoPointersAttempted(long value) { this.sTwoPointersAttempted = value; }

    @JsonProperty("sTwoPointersMade")
    public long getSTwoPointersMade() { return sTwoPointersMade; }
    @JsonProperty("sTwoPointersMade")
    public void setSTwoPointersMade(long value) { this.sTwoPointersMade = value; }

    @JsonProperty("sTwoPointersPercentage")
    public long getSTwoPointersPercentage() { return sTwoPointersPercentage; }
    @JsonProperty("sTwoPointersPercentage")
    public void setSTwoPointersPercentage(long value) { this.sTwoPointersPercentage = value; }

    @JsonProperty("shirtNumber")
    public String getShirtNumber() { return shirtNumber; }
    @JsonProperty("shirtNumber")
    public void setShirtNumber(String value) { this.shirtNumber = value; }

    @JsonProperty("starter")
    public long getStarter() { return starter; }
    @JsonProperty("starter")
    public void setStarter(long value) { this.starter = value; }
}
