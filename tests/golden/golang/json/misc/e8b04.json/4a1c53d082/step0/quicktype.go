// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "encoding/json"

type TopLevel []TopLevelElement

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevelElement struct {
	AverageRating            int64             `json:"averageRating"`
	Category                 *string           `json:"category,omitempty"`
	CreatedAt                int64             `json:"createdAt"`
	Description              *string           `json:"description,omitempty"`
	DisplayType              *DisplayType      `json:"displayType,omitempty"`
	DownloadCount            int64             `json:"downloadCount"`
	Flags                    *[]TopLevelFlag   `json:"flags,omitempty"`
	Grants                   []Grant           `json:"grants"`
	HideFromCatalog          bool              `json:"hideFromCatalog"`
	HideFromDataJSON         bool              `json:"hideFromDataJson"`
	ID                       string            `json:"id"`
	IndexUpdatedAt           *int64            `json:"indexUpdatedAt,omitempty"`
	Locale                   string            `json:"locale"`
	Metadata                 TopLevelMetadata  `json:"metadata"`
	ModerationStatus         *bool             `json:"moderationStatus,omitempty"`
	ModifyingViewUid         *ModifyingViewUid `json:"modifyingViewUid,omitempty"`
	Name                     string            `json:"name"`
	NewBackend               bool              `json:"newBackend"`
	NumberOfComments         int64             `json:"numberOfComments"`
	OID                      int64             `json:"oid"`
	Owner                    Owner             `json:"owner"`
	Provenance               Provenance        `json:"provenance"`
	PublicationAppendEnabled bool              `json:"publicationAppendEnabled"`
	PublicationDate          *int64            `json:"publicationDate,omitempty"`
	PublicationGroup         int64             `json:"publicationGroup"`
	PublicationStage         PublicationStage  `json:"publicationStage"`
	Ratings                  *Ratings          `json:"ratings,omitempty"`
	ResourceName             *string           `json:"resourceName,omitempty"`
	Rights                   []Right           `json:"rights"`
	RowClass                 *string           `json:"rowClass,omitempty"`
	RowIdentifierColumnID    *int64            `json:"rowIdentifierColumnId,omitempty"`
	RowsUpdatedAt            *int64            `json:"rowsUpdatedAt,omitempty"`
	RowsUpdatedBy            *RowsUpdatedBy    `json:"rowsUpdatedBy,omitempty"`
	TableAuthor              TableAuthor       `json:"tableAuthor"`
	TableID                  int64             `json:"tableId"`
	Tags                     *[]string         `json:"tags,omitempty"`
	TotalTimesRated          int64             `json:"totalTimesRated"`
	ViewCount                int64             `json:"viewCount"`
	ViewLastModified         int64             `json:"viewLastModified"`
	ViewType                 ViewType          `json:"viewType"`
}

type Grant struct {
	Flags     []GrantFlag `json:"flags"`
	Inherited bool        `json:"inherited"`
	Type      GrantType   `json:"type"`
}

type TopLevelMetadata struct {
	AvailableDisplayTypes *[]DisplayType            `json:"availableDisplayTypes,omitempty"`
	CustomFields          *CustomFields             `json:"custom_fields,omitempty"`
	JSONQuery             *JSONQuery                `json:"jsonQuery,omitempty"`
	RDFClass              *string                   `json:"rdfClass,omitempty"`
	RDFSubject            *string                   `json:"rdfSubject,omitempty"`
	RenderTypeConfig      *MetadataRenderTypeConfig `json:"renderTypeConfig,omitempty"`
	RichRendererConfigs   *RichRendererConfigs      `json:"richRendererConfigs,omitempty"`
	RowIdentifier         *string                   `json:"rowIdentifier,omitempty"`
	RowLabel              *string                   `json:"rowLabel,omitempty"`
	V1ArchivedProperties  *V1ArchivedProperties     `json:"v1_archived_properties,omitempty"`
}

type CustomFields struct {
	Test Test `json:"TEST"`
}

type Test struct {
	Cfpb1 string `json:"CFPB1"`
}

type JSONQuery struct {
	Group  *[]Group  `json:"group,omitempty"`
	Order  *[]Order  `json:"order,omitempty"`
	Select *[]Select `json:"select,omitempty"`
	Where  *Where    `json:"where,omitempty"`
}

type Group struct {
	ColumnFieldName string `json:"columnFieldName"`
}

type Order struct {
	Ascending       bool                 `json:"ascending"`
	ColumnFieldName OrderColumnFieldName `json:"columnFieldName"`
}

type Select struct {
	Aggregate       *string `json:"aggregate,omitempty"`
	ColumnFieldName string  `json:"columnFieldName"`
}

type Where struct {
	Children        *[]Child              `json:"children,omitempty"`
	ColumnFieldName *ChildColumnFieldName `json:"columnFieldName,omitempty"`
	Metadata        *ChildMetadata        `json:"metadata,omitempty"`
	Operator        WhereOperator         `json:"operator"`
	Value           *string               `json:"value,omitempty"`
}

type Child struct {
	ColumnFieldName ChildColumnFieldName `json:"columnFieldName"`
	Metadata        *ChildMetadata       `json:"metadata,omitempty"`
	Operator        ChildOperator        `json:"operator"`
	Value           *string              `json:"value,omitempty"`
}

type ChildMetadata struct {
	CustomValues   *[]string         `json:"customValues,omitempty"`
	Freeform       *bool             `json:"freeform,omitempty"`
	IncludeAuto    *int64            `json:"includeAuto,omitempty"`
	Operator       *MetadataOperator `json:"operator,omitempty"`
	TableColumnID  *TableColumnID    `json:"tableColumnId,omitempty"`
	UnifiedVersion *int64            `json:"unifiedVersion,omitempty"`
}

type TableColumnID struct {
	The2819740 int64 `json:"2819740"`
}

type MetadataRenderTypeConfig struct {
	Visible PurpleVisible `json:"visible"`
}

type PurpleVisible struct {
	Fatrow *bool `json:"fatrow,omitempty"`
	Table  *bool `json:"table,omitempty"`
}

type RichRendererConfigs struct {
	FatRow FatRow `json:"fatRow"`
}

type FatRow struct {
	Columns []Column `json:"columns"`
}

type Column struct {
	Rows   []Row  `json:"rows"`
	Styles Styles `json:"styles"`
}

type Row struct {
	Fields []Field `json:"fields"`
}

type Field struct {
	TableColumnID int64     `json:"tableColumnId"`
	Type          FieldType `json:"type"`
}

type Styles struct {
	Width Width `json:"width"`
}

type V1ArchivedProperties struct {
	AccessPoints     AccessPoints                         `json:"accessPoints"`
	BlistID          string                               `json:"blist_id"`
	RenderTypeConfig V1ArchivedPropertiesRenderTypeConfig `json:"renderTypeConfig"`
}

type AccessPoints struct {
	NewView string `json:"new_view"`
}

type V1ArchivedPropertiesRenderTypeConfig struct {
	Visible FluffyVisible `json:"visible"`
}

type FluffyVisible struct {
	Href bool `json:"href"`
}

type Owner struct {
	DisplayName            string    `json:"displayName"`
	Flags                  *[]string `json:"flags,omitempty"`
	ID                     string    `json:"id"`
	LastNotificationSeenAt *int64    `json:"lastNotificationSeenAt,omitempty"`
	ProfileImageURLLarge   *string   `json:"profileImageUrlLarge,omitempty"`
	ProfileImageURLMedium  *string   `json:"profileImageUrlMedium,omitempty"`
	ProfileImageURLSmall   *string   `json:"profileImageUrlSmall,omitempty"`
	Rights                 *[]string `json:"rights,omitempty"`
	RoleName               *RoleName `json:"roleName,omitempty"`
	ScreenName             string    `json:"screenName"`
}

type Ratings struct {
	Rating int64 `json:"rating"`
}

type TableAuthor struct {
	DisplayName string    `json:"displayName"`
	ID          string    `json:"id"`
	Rights      *[]string `json:"rights,omitempty"`
	RoleName    *RoleName `json:"roleName,omitempty"`
	ScreenName  string    `json:"screenName"`
}

type DisplayType string

const (
	Table    DisplayType = "table"
	DataLens DisplayType = "data_lens"
	Fatrow   DisplayType = "fatrow"
	Page     DisplayType = "page"
)

type invalidDisplayType string
func (x invalidDisplayType) Error() string { return "invalid DisplayType: " + string(x) }

func (x *DisplayType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch DisplayType(value) {
	case Table, DataLens, Fatrow, Page: *x = DisplayType(value); return nil
	}
	return invalidDisplayType(value)
}

type TopLevelFlag string

const (
	Default                TopLevelFlag = "default"
	Restorable             TopLevelFlag = "restorable"
	RestorePossibleForType TopLevelFlag = "restorePossibleForType"
)

type invalidTopLevelFlag string
func (x invalidTopLevelFlag) Error() string { return "invalid TopLevelFlag: " + string(x) }

func (x *TopLevelFlag) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TopLevelFlag(value) {
	case Default, Restorable, RestorePossibleForType: *x = TopLevelFlag(value); return nil
	}
	return invalidTopLevelFlag(value)
}

type GrantFlag string

const (
	Public GrantFlag = "public"
)

type invalidGrantFlag string
func (x invalidGrantFlag) Error() string { return "invalid GrantFlag: " + string(x) }

func (x *GrantFlag) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GrantFlag(value) {
	case Public: *x = GrantFlag(value); return nil
	}
	return invalidGrantFlag(value)
}

type GrantType string

const (
	Viewer GrantType = "viewer"
)

type invalidGrantType string
func (x invalidGrantType) Error() string { return "invalid GrantType: " + string(x) }

func (x *GrantType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch GrantType(value) {
	case Viewer: *x = GrantType(value); return nil
	}
	return invalidGrantType(value)
}

type OrderColumnFieldName string

const (
	DateReceived         OrderColumnFieldName = "date_received"
	AgreementDate        OrderColumnFieldName = "agreement_date"
	InEffectAsOf1_1_2012 OrderColumnFieldName = "in_effect_as_of_1_1_2012"
)

type invalidOrderColumnFieldName string
func (x invalidOrderColumnFieldName) Error() string { return "invalid OrderColumnFieldName: " + string(x) }

func (x *OrderColumnFieldName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch OrderColumnFieldName(value) {
	case DateReceived, AgreementDate, InEffectAsOf1_1_2012: *x = OrderColumnFieldName(value); return nil
	}
	return invalidOrderColumnFieldName(value)
}

type ChildColumnFieldName string

const (
	Product               ChildColumnFieldName = "product"
	ComplaintWhatHappened ChildColumnFieldName = "complaint_what_happened"
	SubProduct            ChildColumnFieldName = "sub_product"
	Issue                 ChildColumnFieldName = "issue"
)

type invalidChildColumnFieldName string
func (x invalidChildColumnFieldName) Error() string { return "invalid ChildColumnFieldName: " + string(x) }

func (x *ChildColumnFieldName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ChildColumnFieldName(value) {
	case Product, ComplaintWhatHappened, SubProduct, Issue: *x = ChildColumnFieldName(value); return nil
	}
	return invalidChildColumnFieldName(value)
}

type MetadataOperator string

const (
	PurpleEQUALS MetadataOperator = "EQUALS"
	Blank        MetadataOperator = "blank?"
)

type invalidMetadataOperator string
func (x invalidMetadataOperator) Error() string { return "invalid MetadataOperator: " + string(x) }

func (x *MetadataOperator) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch MetadataOperator(value) {
	case PurpleEQUALS, Blank: *x = MetadataOperator(value); return nil
	}
	return invalidMetadataOperator(value)
}

type ChildOperator string

const (
	FluffyEQUALS ChildOperator = "EQUALS"
	IsNotBlank   ChildOperator = "IS_NOT_BLANK"
)

type invalidChildOperator string
func (x invalidChildOperator) Error() string { return "invalid ChildOperator: " + string(x) }

func (x *ChildOperator) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ChildOperator(value) {
	case FluffyEQUALS, IsNotBlank: *x = ChildOperator(value); return nil
	}
	return invalidChildOperator(value)
}

type WhereOperator string

const (
	TentacledEQUALS WhereOperator = "EQUALS"
	And             WhereOperator = "AND"
)

type invalidWhereOperator string
func (x invalidWhereOperator) Error() string { return "invalid WhereOperator: " + string(x) }

func (x *WhereOperator) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch WhereOperator(value) {
	case TentacledEQUALS, And: *x = WhereOperator(value); return nil
	}
	return invalidWhereOperator(value)
}

type FieldType string

const (
	ColumnLabel FieldType = "columnLabel"
	ColumnData  FieldType = "columnData"
)

type invalidFieldType string
func (x invalidFieldType) Error() string { return "invalid FieldType: " + string(x) }

func (x *FieldType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch FieldType(value) {
	case ColumnLabel, ColumnData: *x = FieldType(value); return nil
	}
	return invalidFieldType(value)
}

type Width string

const (
	The27 Width = "27%"
	The40 Width = "40%"
	The30 Width = "30%"
	The33 Width = "33%"
)

type invalidWidth string
func (x invalidWidth) Error() string { return "invalid Width: " + string(x) }

func (x *Width) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Width(value) {
	case The27, The40, The30, The33: *x = Width(value); return nil
	}
	return invalidWidth(value)
}

type ModifyingViewUid string

const (
	S6EwH6Mp ModifyingViewUid = "s6ew-h6mp"
)

type invalidModifyingViewUid string
func (x invalidModifyingViewUid) Error() string { return "invalid ModifyingViewUid: " + string(x) }

func (x *ModifyingViewUid) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ModifyingViewUid(value) {
	case S6EwH6Mp: *x = ModifyingViewUid(value); return nil
	}
	return invalidModifyingViewUid(value)
}

type RoleName string

const (
	Administrator RoleName = "administrator"
	Publisher     RoleName = "publisher"
)

type invalidRoleName string
func (x invalidRoleName) Error() string { return "invalid RoleName: " + string(x) }

func (x *RoleName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RoleName(value) {
	case Administrator, Publisher: *x = RoleName(value); return nil
	}
	return invalidRoleName(value)
}

type Provenance string

const (
	Official Provenance = "official"
)

type invalidProvenance string
func (x invalidProvenance) Error() string { return "invalid Provenance: " + string(x) }

func (x *Provenance) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Provenance(value) {
	case Official: *x = Provenance(value); return nil
	}
	return invalidProvenance(value)
}

type PublicationStage string

const (
	Published PublicationStage = "published"
)

type invalidPublicationStage string
func (x invalidPublicationStage) Error() string { return "invalid PublicationStage: " + string(x) }

func (x *PublicationStage) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch PublicationStage(value) {
	case Published: *x = PublicationStage(value); return nil
	}
	return invalidPublicationStage(value)
}

type Right string

const (
	Read Right = "read"
)

type invalidRight string
func (x invalidRight) Error() string { return "invalid Right: " + string(x) }

func (x *Right) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch Right(value) {
	case Read: *x = Right(value); return nil
	}
	return invalidRight(value)
}

type RowsUpdatedBy string

const (
	PjxgVe4M    RowsUpdatedBy = "pjxg-ve4m"
	The54A3Qyun RowsUpdatedBy = "54a3-qyun"
	The9E3M2843 RowsUpdatedBy = "9e3m-2843"
	VvcaFr6G    RowsUpdatedBy = "vvca-fr6g"
)

type invalidRowsUpdatedBy string
func (x invalidRowsUpdatedBy) Error() string { return "invalid RowsUpdatedBy: " + string(x) }

func (x *RowsUpdatedBy) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch RowsUpdatedBy(value) {
	case PjxgVe4M, The54A3Qyun, The9E3M2843, VvcaFr6G: *x = RowsUpdatedBy(value); return nil
	}
	return invalidRowsUpdatedBy(value)
}

type ViewType string

const (
	Tabular ViewType = "tabular"
)

type invalidViewType string
func (x invalidViewType) Error() string { return "invalid ViewType: " + string(x) }

func (x *ViewType) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch ViewType(value) {
	case Tabular: *x = ViewType(value); return nil
	}
	return invalidViewType(value)
}
