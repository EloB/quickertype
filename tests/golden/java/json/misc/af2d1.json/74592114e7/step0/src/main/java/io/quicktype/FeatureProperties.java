package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FeatureProperties {
    private AddImprov addImprov;
    private double area;
    private String assetNumb;
    private String comments;
    private long condition;
    private String constructi;
    private Object createdate;
    private Object createuser;
    private Object disposalD;
    private String documents;
    private String drawingNu;
    private String fileNumbe;
    private String folderNum;
    private FundingBa fundingBa;
    private long historicC;
    private String inspection;
    private Object inspectors;
    private Object lastUpdat;
    private LevelAccu levelAccu;
    private Material material;
    private long miPrinx;
    private MiSymbolo miSymbolo;
    private long numberLAN;
    private String owner;
    private LevelAccu positional;
    private String projectNu;
    private long recID;
    private String recordCre;
    private double shapeArea;
    private double shapeLeng;
    private Status status;
    private Object surveyNum;
    private double toeRl;
    private double topRl;
    private PropertiesType type;
    private String updateDAT;
    private Object updatedate;
    private Object updateuser;

    @JsonProperty("add_improv")
    public AddImprov getAddImprov() { return addImprov; }
    @JsonProperty("add_improv")
    public void setAddImprov(AddImprov value) { this.addImprov = value; }

    @JsonProperty("area_")
    public double getArea() { return area; }
    @JsonProperty("area_")
    public void setArea(double value) { this.area = value; }

    @JsonProperty("asset_numb")
    public String getAssetNumb() { return assetNumb; }
    @JsonProperty("asset_numb")
    public void setAssetNumb(String value) { this.assetNumb = value; }

    @JsonProperty("comments")
    public String getComments() { return comments; }
    @JsonProperty("comments")
    public void setComments(String value) { this.comments = value; }

    @JsonProperty("condition")
    public long getCondition() { return condition; }
    @JsonProperty("condition")
    public void setCondition(long value) { this.condition = value; }

    @JsonProperty("constructi")
    public String getConstructi() { return constructi; }
    @JsonProperty("constructi")
    public void setConstructi(String value) { this.constructi = value; }

    @JsonProperty("createdate")
    public Object getCreatedate() { return createdate; }
    @JsonProperty("createdate")
    public void setCreatedate(Object value) { this.createdate = value; }

    @JsonProperty("createuser")
    public Object getCreateuser() { return createuser; }
    @JsonProperty("createuser")
    public void setCreateuser(Object value) { this.createuser = value; }

    @JsonProperty("disposal_d")
    public Object getDisposalD() { return disposalD; }
    @JsonProperty("disposal_d")
    public void setDisposalD(Object value) { this.disposalD = value; }

    @JsonProperty("documents")
    public String getDocuments() { return documents; }
    @JsonProperty("documents")
    public void setDocuments(String value) { this.documents = value; }

    @JsonProperty("drawing_nu")
    public String getDrawingNu() { return drawingNu; }
    @JsonProperty("drawing_nu")
    public void setDrawingNu(String value) { this.drawingNu = value; }

    @JsonProperty("file_numbe")
    public String getFileNumbe() { return fileNumbe; }
    @JsonProperty("file_numbe")
    public void setFileNumbe(String value) { this.fileNumbe = value; }

    @JsonProperty("folder_num")
    public String getFolderNum() { return folderNum; }
    @JsonProperty("folder_num")
    public void setFolderNum(String value) { this.folderNum = value; }

    @JsonProperty("funding_ba")
    public FundingBa getFundingBa() { return fundingBa; }
    @JsonProperty("funding_ba")
    public void setFundingBa(FundingBa value) { this.fundingBa = value; }

    @JsonProperty("historic_c")
    public long getHistoricC() { return historicC; }
    @JsonProperty("historic_c")
    public void setHistoricC(long value) { this.historicC = value; }

    @JsonProperty("inspection")
    public String getInspection() { return inspection; }
    @JsonProperty("inspection")
    public void setInspection(String value) { this.inspection = value; }

    @JsonProperty("inspectors")
    public Object getInspectors() { return inspectors; }
    @JsonProperty("inspectors")
    public void setInspectors(Object value) { this.inspectors = value; }

    @JsonProperty("last_updat")
    public Object getLastUpdat() { return lastUpdat; }
    @JsonProperty("last_updat")
    public void setLastUpdat(Object value) { this.lastUpdat = value; }

    @JsonProperty("level_accu")
    public LevelAccu getLevelAccu() { return levelAccu; }
    @JsonProperty("level_accu")
    public void setLevelAccu(LevelAccu value) { this.levelAccu = value; }

    @JsonProperty("material")
    public Material getMaterial() { return material; }
    @JsonProperty("material")
    public void setMaterial(Material value) { this.material = value; }

    @JsonProperty("mi_prinx")
    public long getMiPrinx() { return miPrinx; }
    @JsonProperty("mi_prinx")
    public void setMiPrinx(long value) { this.miPrinx = value; }

    @JsonProperty("mi_symbolo")
    public MiSymbolo getMiSymbolo() { return miSymbolo; }
    @JsonProperty("mi_symbolo")
    public void setMiSymbolo(MiSymbolo value) { this.miSymbolo = value; }

    @JsonProperty("number_lan")
    public long getNumberLAN() { return numberLAN; }
    @JsonProperty("number_lan")
    public void setNumberLAN(long value) { this.numberLAN = value; }

    @JsonProperty("owner")
    public String getOwner() { return owner; }
    @JsonProperty("owner")
    public void setOwner(String value) { this.owner = value; }

    @JsonProperty("positional")
    public LevelAccu getPositional() { return positional; }
    @JsonProperty("positional")
    public void setPositional(LevelAccu value) { this.positional = value; }

    @JsonProperty("project_nu")
    public String getProjectNu() { return projectNu; }
    @JsonProperty("project_nu")
    public void setProjectNu(String value) { this.projectNu = value; }

    @JsonProperty("rec_id")
    public long getRecID() { return recID; }
    @JsonProperty("rec_id")
    public void setRecID(long value) { this.recID = value; }

    @JsonProperty("record_cre")
    public String getRecordCre() { return recordCre; }
    @JsonProperty("record_cre")
    public void setRecordCre(String value) { this.recordCre = value; }

    @JsonProperty("shape_area")
    public double getShapeArea() { return shapeArea; }
    @JsonProperty("shape_area")
    public void setShapeArea(double value) { this.shapeArea = value; }

    @JsonProperty("shape_leng")
    public double getShapeLeng() { return shapeLeng; }
    @JsonProperty("shape_leng")
    public void setShapeLeng(double value) { this.shapeLeng = value; }

    @JsonProperty("status")
    public Status getStatus() { return status; }
    @JsonProperty("status")
    public void setStatus(Status value) { this.status = value; }

    @JsonProperty("survey_num")
    public Object getSurveyNum() { return surveyNum; }
    @JsonProperty("survey_num")
    public void setSurveyNum(Object value) { this.surveyNum = value; }

    @JsonProperty("toe_rl")
    public double getToeRl() { return toeRl; }
    @JsonProperty("toe_rl")
    public void setToeRl(double value) { this.toeRl = value; }

    @JsonProperty("top_rl")
    public double getTopRl() { return topRl; }
    @JsonProperty("top_rl")
    public void setTopRl(double value) { this.topRl = value; }

    @JsonProperty("type")
    public PropertiesType getType() { return type; }
    @JsonProperty("type")
    public void setType(PropertiesType value) { this.type = value; }

    @JsonProperty("update_dat")
    public String getUpdateDAT() { return updateDAT; }
    @JsonProperty("update_dat")
    public void setUpdateDAT(String value) { this.updateDAT = value; }

    @JsonProperty("updatedate")
    public Object getUpdatedate() { return updatedate; }
    @JsonProperty("updatedate")
    public void setUpdatedate(Object value) { this.updatedate = value; }

    @JsonProperty("updateuser")
    public Object getUpdateuser() { return updateuser; }
    @JsonProperty("updateuser")
    public void setUpdateuser(Object value) { this.updateuser = value; }
}
