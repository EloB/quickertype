package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class Tm {
    private String code;
    private String codeInternational;
    private long fouls;
    private long fullScore;
    private Lds lds;
    private String logo;
    private String name;
    private String nameInternational;
    private long p1Score;
    private long p2Score;
    private long p3Score;
    private long p4Score;
    private Map<String, Pl> pl;
    private long score;
    private List<Scorer> scoring;
    private String shortName;
    private String shortNameInternational;
    private List<Shot> shot;
    private long timeouts;
    private long totEFF1;
    private long totEFF2;
    private double totEFF3;
    private long totEFF4;
    private long totEFF5;
    private long totEFF6;
    private long totEFF7;
    private long totSAssists;
    private long totSBenchPoints;
    private long totSBiggestLead;
    private long totSBiggestScoringRun;
    private long totSBlocks;
    private long totSBlocksReceived;
    private long totSFieldGoalsAttempted;
    private long totSFieldGoalsMade;
    private long totSFieldGoalsPercentage;
    private long totSFoulsOn;
    private long totSFoulsPersonal;
    private long totSFoulsTeam;
    private long totSFreeThrowsAttempted;
    private long totSFreeThrowsMade;
    private long totSFreeThrowsPercentage;
    private long totSLeadChanges;
    private long totSMinutes;
    private long totSPoints;
    private long totSPointsFastBreak;
    private long totSPointsFromTurnovers;
    private long totSPointsInThePaint;
    private long totSPointsSecondChance;
    private long totSReboundsDefensive;
    private long totSReboundsOffensive;
    private long totSReboundsTeam;
    private long totSReboundsTeamDefensive;
    private long totSReboundsTeamOffensive;
    private long totSReboundsTotal;
    private long totSSteals;
    private long totSThreePointersAttempted;
    private long totSThreePointersMade;
    private long totSThreePointersPercentage;
    private double totSTimeLeading;
    private long totSTimesScoresLevel;
    private long totSTurnovers;
    private long totSTurnoversTeam;
    private long totSTwoPointersAttempted;
    private long totSTwoPointersMade;
    private long totSTwoPointersPercentage;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("codeInternational")
    public String getCodeInternational() { return codeInternational; }
    @JsonProperty("codeInternational")
    public void setCodeInternational(String value) { this.codeInternational = value; }

    @JsonProperty("fouls")
    public long getFouls() { return fouls; }
    @JsonProperty("fouls")
    public void setFouls(long value) { this.fouls = value; }

    @JsonProperty("full_score")
    public long getFullScore() { return fullScore; }
    @JsonProperty("full_score")
    public void setFullScore(long value) { this.fullScore = value; }

    @JsonProperty("lds")
    public Lds getLds() { return lds; }
    @JsonProperty("lds")
    public void setLds(Lds value) { this.lds = value; }

    @JsonProperty("logo")
    public String getLogo() { return logo; }
    @JsonProperty("logo")
    public void setLogo(String value) { this.logo = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("nameInternational")
    public String getNameInternational() { return nameInternational; }
    @JsonProperty("nameInternational")
    public void setNameInternational(String value) { this.nameInternational = value; }

    @JsonProperty("p1_score")
    public long getP1Score() { return p1Score; }
    @JsonProperty("p1_score")
    public void setP1Score(long value) { this.p1Score = value; }

    @JsonProperty("p2_score")
    public long getP2Score() { return p2Score; }
    @JsonProperty("p2_score")
    public void setP2Score(long value) { this.p2Score = value; }

    @JsonProperty("p3_score")
    public long getP3Score() { return p3Score; }
    @JsonProperty("p3_score")
    public void setP3Score(long value) { this.p3Score = value; }

    @JsonProperty("p4_score")
    public long getP4Score() { return p4Score; }
    @JsonProperty("p4_score")
    public void setP4Score(long value) { this.p4Score = value; }

    @JsonProperty("pl")
    public Map<String, Pl> getPl() { return pl; }
    @JsonProperty("pl")
    public void setPl(Map<String, Pl> value) { this.pl = value; }

    @JsonProperty("score")
    public long getScore() { return score; }
    @JsonProperty("score")
    public void setScore(long value) { this.score = value; }

    @JsonProperty("scoring")
    public List<Scorer> getScoring() { return scoring; }
    @JsonProperty("scoring")
    public void setScoring(List<Scorer> value) { this.scoring = value; }

    @JsonProperty("shortName")
    public String getShortName() { return shortName; }
    @JsonProperty("shortName")
    public void setShortName(String value) { this.shortName = value; }

    @JsonProperty("shortNameInternational")
    public String getShortNameInternational() { return shortNameInternational; }
    @JsonProperty("shortNameInternational")
    public void setShortNameInternational(String value) { this.shortNameInternational = value; }

    @JsonProperty("shot")
    public List<Shot> getShot() { return shot; }
    @JsonProperty("shot")
    public void setShot(List<Shot> value) { this.shot = value; }

    @JsonProperty("timeouts")
    public long getTimeouts() { return timeouts; }
    @JsonProperty("timeouts")
    public void setTimeouts(long value) { this.timeouts = value; }

    @JsonProperty("tot_eff_1")
    public long getTotEFF1() { return totEFF1; }
    @JsonProperty("tot_eff_1")
    public void setTotEFF1(long value) { this.totEFF1 = value; }

    @JsonProperty("tot_eff_2")
    public long getTotEFF2() { return totEFF2; }
    @JsonProperty("tot_eff_2")
    public void setTotEFF2(long value) { this.totEFF2 = value; }

    @JsonProperty("tot_eff_3")
    public double getTotEFF3() { return totEFF3; }
    @JsonProperty("tot_eff_3")
    public void setTotEFF3(double value) { this.totEFF3 = value; }

    @JsonProperty("tot_eff_4")
    public long getTotEFF4() { return totEFF4; }
    @JsonProperty("tot_eff_4")
    public void setTotEFF4(long value) { this.totEFF4 = value; }

    @JsonProperty("tot_eff_5")
    public long getTotEFF5() { return totEFF5; }
    @JsonProperty("tot_eff_5")
    public void setTotEFF5(long value) { this.totEFF5 = value; }

    @JsonProperty("tot_eff_6")
    public long getTotEFF6() { return totEFF6; }
    @JsonProperty("tot_eff_6")
    public void setTotEFF6(long value) { this.totEFF6 = value; }

    @JsonProperty("tot_eff_7")
    public long getTotEFF7() { return totEFF7; }
    @JsonProperty("tot_eff_7")
    public void setTotEFF7(long value) { this.totEFF7 = value; }

    @JsonProperty("tot_sAssists")
    public long getTotSAssists() { return totSAssists; }
    @JsonProperty("tot_sAssists")
    public void setTotSAssists(long value) { this.totSAssists = value; }

    @JsonProperty("tot_sBenchPoints")
    public long getTotSBenchPoints() { return totSBenchPoints; }
    @JsonProperty("tot_sBenchPoints")
    public void setTotSBenchPoints(long value) { this.totSBenchPoints = value; }

    @JsonProperty("tot_sBiggestLead")
    public long getTotSBiggestLead() { return totSBiggestLead; }
    @JsonProperty("tot_sBiggestLead")
    public void setTotSBiggestLead(long value) { this.totSBiggestLead = value; }

    @JsonProperty("tot_sBiggestScoringRun")
    public long getTotSBiggestScoringRun() { return totSBiggestScoringRun; }
    @JsonProperty("tot_sBiggestScoringRun")
    public void setTotSBiggestScoringRun(long value) { this.totSBiggestScoringRun = value; }

    @JsonProperty("tot_sBlocks")
    public long getTotSBlocks() { return totSBlocks; }
    @JsonProperty("tot_sBlocks")
    public void setTotSBlocks(long value) { this.totSBlocks = value; }

    @JsonProperty("tot_sBlocksReceived")
    public long getTotSBlocksReceived() { return totSBlocksReceived; }
    @JsonProperty("tot_sBlocksReceived")
    public void setTotSBlocksReceived(long value) { this.totSBlocksReceived = value; }

    @JsonProperty("tot_sFieldGoalsAttempted")
    public long getTotSFieldGoalsAttempted() { return totSFieldGoalsAttempted; }
    @JsonProperty("tot_sFieldGoalsAttempted")
    public void setTotSFieldGoalsAttempted(long value) { this.totSFieldGoalsAttempted = value; }

    @JsonProperty("tot_sFieldGoalsMade")
    public long getTotSFieldGoalsMade() { return totSFieldGoalsMade; }
    @JsonProperty("tot_sFieldGoalsMade")
    public void setTotSFieldGoalsMade(long value) { this.totSFieldGoalsMade = value; }

    @JsonProperty("tot_sFieldGoalsPercentage")
    public long getTotSFieldGoalsPercentage() { return totSFieldGoalsPercentage; }
    @JsonProperty("tot_sFieldGoalsPercentage")
    public void setTotSFieldGoalsPercentage(long value) { this.totSFieldGoalsPercentage = value; }

    @JsonProperty("tot_sFoulsOn")
    public long getTotSFoulsOn() { return totSFoulsOn; }
    @JsonProperty("tot_sFoulsOn")
    public void setTotSFoulsOn(long value) { this.totSFoulsOn = value; }

    @JsonProperty("tot_sFoulsPersonal")
    public long getTotSFoulsPersonal() { return totSFoulsPersonal; }
    @JsonProperty("tot_sFoulsPersonal")
    public void setTotSFoulsPersonal(long value) { this.totSFoulsPersonal = value; }

    @JsonProperty("tot_sFoulsTeam")
    public long getTotSFoulsTeam() { return totSFoulsTeam; }
    @JsonProperty("tot_sFoulsTeam")
    public void setTotSFoulsTeam(long value) { this.totSFoulsTeam = value; }

    @JsonProperty("tot_sFreeThrowsAttempted")
    public long getTotSFreeThrowsAttempted() { return totSFreeThrowsAttempted; }
    @JsonProperty("tot_sFreeThrowsAttempted")
    public void setTotSFreeThrowsAttempted(long value) { this.totSFreeThrowsAttempted = value; }

    @JsonProperty("tot_sFreeThrowsMade")
    public long getTotSFreeThrowsMade() { return totSFreeThrowsMade; }
    @JsonProperty("tot_sFreeThrowsMade")
    public void setTotSFreeThrowsMade(long value) { this.totSFreeThrowsMade = value; }

    @JsonProperty("tot_sFreeThrowsPercentage")
    public long getTotSFreeThrowsPercentage() { return totSFreeThrowsPercentage; }
    @JsonProperty("tot_sFreeThrowsPercentage")
    public void setTotSFreeThrowsPercentage(long value) { this.totSFreeThrowsPercentage = value; }

    @JsonProperty("tot_sLeadChanges")
    public long getTotSLeadChanges() { return totSLeadChanges; }
    @JsonProperty("tot_sLeadChanges")
    public void setTotSLeadChanges(long value) { this.totSLeadChanges = value; }

    @JsonProperty("tot_sMinutes")
    public long getTotSMinutes() { return totSMinutes; }
    @JsonProperty("tot_sMinutes")
    public void setTotSMinutes(long value) { this.totSMinutes = value; }

    @JsonProperty("tot_sPoints")
    public long getTotSPoints() { return totSPoints; }
    @JsonProperty("tot_sPoints")
    public void setTotSPoints(long value) { this.totSPoints = value; }

    @JsonProperty("tot_sPointsFastBreak")
    public long getTotSPointsFastBreak() { return totSPointsFastBreak; }
    @JsonProperty("tot_sPointsFastBreak")
    public void setTotSPointsFastBreak(long value) { this.totSPointsFastBreak = value; }

    @JsonProperty("tot_sPointsFromTurnovers")
    public long getTotSPointsFromTurnovers() { return totSPointsFromTurnovers; }
    @JsonProperty("tot_sPointsFromTurnovers")
    public void setTotSPointsFromTurnovers(long value) { this.totSPointsFromTurnovers = value; }

    @JsonProperty("tot_sPointsInThePaint")
    public long getTotSPointsInThePaint() { return totSPointsInThePaint; }
    @JsonProperty("tot_sPointsInThePaint")
    public void setTotSPointsInThePaint(long value) { this.totSPointsInThePaint = value; }

    @JsonProperty("tot_sPointsSecondChance")
    public long getTotSPointsSecondChance() { return totSPointsSecondChance; }
    @JsonProperty("tot_sPointsSecondChance")
    public void setTotSPointsSecondChance(long value) { this.totSPointsSecondChance = value; }

    @JsonProperty("tot_sReboundsDefensive")
    public long getTotSReboundsDefensive() { return totSReboundsDefensive; }
    @JsonProperty("tot_sReboundsDefensive")
    public void setTotSReboundsDefensive(long value) { this.totSReboundsDefensive = value; }

    @JsonProperty("tot_sReboundsOffensive")
    public long getTotSReboundsOffensive() { return totSReboundsOffensive; }
    @JsonProperty("tot_sReboundsOffensive")
    public void setTotSReboundsOffensive(long value) { this.totSReboundsOffensive = value; }

    @JsonProperty("tot_sReboundsTeam")
    public long getTotSReboundsTeam() { return totSReboundsTeam; }
    @JsonProperty("tot_sReboundsTeam")
    public void setTotSReboundsTeam(long value) { this.totSReboundsTeam = value; }

    @JsonProperty("tot_sReboundsTeamDefensive")
    public long getTotSReboundsTeamDefensive() { return totSReboundsTeamDefensive; }
    @JsonProperty("tot_sReboundsTeamDefensive")
    public void setTotSReboundsTeamDefensive(long value) { this.totSReboundsTeamDefensive = value; }

    @JsonProperty("tot_sReboundsTeamOffensive")
    public long getTotSReboundsTeamOffensive() { return totSReboundsTeamOffensive; }
    @JsonProperty("tot_sReboundsTeamOffensive")
    public void setTotSReboundsTeamOffensive(long value) { this.totSReboundsTeamOffensive = value; }

    @JsonProperty("tot_sReboundsTotal")
    public long getTotSReboundsTotal() { return totSReboundsTotal; }
    @JsonProperty("tot_sReboundsTotal")
    public void setTotSReboundsTotal(long value) { this.totSReboundsTotal = value; }

    @JsonProperty("tot_sSteals")
    public long getTotSSteals() { return totSSteals; }
    @JsonProperty("tot_sSteals")
    public void setTotSSteals(long value) { this.totSSteals = value; }

    @JsonProperty("tot_sThreePointersAttempted")
    public long getTotSThreePointersAttempted() { return totSThreePointersAttempted; }
    @JsonProperty("tot_sThreePointersAttempted")
    public void setTotSThreePointersAttempted(long value) { this.totSThreePointersAttempted = value; }

    @JsonProperty("tot_sThreePointersMade")
    public long getTotSThreePointersMade() { return totSThreePointersMade; }
    @JsonProperty("tot_sThreePointersMade")
    public void setTotSThreePointersMade(long value) { this.totSThreePointersMade = value; }

    @JsonProperty("tot_sThreePointersPercentage")
    public long getTotSThreePointersPercentage() { return totSThreePointersPercentage; }
    @JsonProperty("tot_sThreePointersPercentage")
    public void setTotSThreePointersPercentage(long value) { this.totSThreePointersPercentage = value; }

    @JsonProperty("tot_sTimeLeading")
    public double getTotSTimeLeading() { return totSTimeLeading; }
    @JsonProperty("tot_sTimeLeading")
    public void setTotSTimeLeading(double value) { this.totSTimeLeading = value; }

    @JsonProperty("tot_sTimesScoresLevel")
    public long getTotSTimesScoresLevel() { return totSTimesScoresLevel; }
    @JsonProperty("tot_sTimesScoresLevel")
    public void setTotSTimesScoresLevel(long value) { this.totSTimesScoresLevel = value; }

    @JsonProperty("tot_sTurnovers")
    public long getTotSTurnovers() { return totSTurnovers; }
    @JsonProperty("tot_sTurnovers")
    public void setTotSTurnovers(long value) { this.totSTurnovers = value; }

    @JsonProperty("tot_sTurnoversTeam")
    public long getTotSTurnoversTeam() { return totSTurnoversTeam; }
    @JsonProperty("tot_sTurnoversTeam")
    public void setTotSTurnoversTeam(long value) { this.totSTurnoversTeam = value; }

    @JsonProperty("tot_sTwoPointersAttempted")
    public long getTotSTwoPointersAttempted() { return totSTwoPointersAttempted; }
    @JsonProperty("tot_sTwoPointersAttempted")
    public void setTotSTwoPointersAttempted(long value) { this.totSTwoPointersAttempted = value; }

    @JsonProperty("tot_sTwoPointersMade")
    public long getTotSTwoPointersMade() { return totSTwoPointersMade; }
    @JsonProperty("tot_sTwoPointersMade")
    public void setTotSTwoPointersMade(long value) { this.totSTwoPointersMade = value; }

    @JsonProperty("tot_sTwoPointersPercentage")
    public long getTotSTwoPointersPercentage() { return totSTwoPointersPercentage; }
    @JsonProperty("tot_sTwoPointersPercentage")
    public void setTotSTwoPointersPercentage(long value) { this.totSTwoPointersPercentage = value; }
}
