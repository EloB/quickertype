// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

import "bytes"
import "errors"

import "encoding/json"

func UnmarshalTopLevel(data []byte) (TopLevel, error) {
	var r TopLevel
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *TopLevel) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type TopLevel struct {
	Data [][]Datum `json:"data"`
	Meta Meta      `json:"meta"`
}

type Meta struct {
	View View `json:"view"`
}

type View struct {
	Attribution              string   `json:"attribution"`
	AttributionLink          string   `json:"attributionLink"`
	AverageRating            int64    `json:"averageRating"`
	Category                 string   `json:"category"`
	Columns                  []Column `json:"columns"`
	CreatedAt                int64    `json:"createdAt"`
	Description              string   `json:"description"`
	DisplayType              string   `json:"displayType"`
	DownloadCount            int64    `json:"downloadCount"`
	Flags                    []string `json:"flags"`
	Grants                   []Grant  `json:"grants"`
	HideFromCatalog          bool     `json:"hideFromCatalog"`
	HideFromDataJSON         bool     `json:"hideFromDataJson"`
	ID                       string   `json:"id"`
	IndexUpdatedAt           int64    `json:"indexUpdatedAt"`
	Locale                   string   `json:"locale"`
	Metadata                 Metadata `json:"metadata"`
	Name                     string   `json:"name"`
	NewBackend               bool     `json:"newBackend"`
	NumberOfComments         int64    `json:"numberOfComments"`
	OID                      int64    `json:"oid"`
	Owner                    Owner    `json:"owner"`
	Provenance               string   `json:"provenance"`
	PublicationAppendEnabled bool     `json:"publicationAppendEnabled"`
	PublicationDate          int64    `json:"publicationDate"`
	PublicationGroup         int64    `json:"publicationGroup"`
	PublicationStage         string   `json:"publicationStage"`
	Query                    Query    `json:"query"`
	Rights                   []string `json:"rights"`
	RowsUpdatedAt            int64    `json:"rowsUpdatedAt"`
	RowsUpdatedBy            string   `json:"rowsUpdatedBy"`
	TableAuthor              Owner    `json:"tableAuthor"`
	TableID                  int64    `json:"tableId"`
	Tags                     []string `json:"tags"`
	TotalTimesRated          int64    `json:"totalTimesRated"`
	ViewCount                int64    `json:"viewCount"`
	ViewLastModified         int64    `json:"viewLastModified"`
	ViewType                 string   `json:"viewType"`
}

type Column struct {
	CachedContents *CachedContents `json:"cachedContents,omitempty"`
	DataTypeName   TypeName        `json:"dataTypeName"`
	FieldName      string          `json:"fieldName"`
	Flags          *[]string       `json:"flags,omitempty"`
	Format         Format          `json:"format"`
	ID             int64           `json:"id"`
	Name           string          `json:"name"`
	Position       int64           `json:"position"`
	RenderTypeName TypeName        `json:"renderTypeName"`
	TableColumnID  *int64          `json:"tableColumnId,omitempty"`
	Width          *int64          `json:"width,omitempty"`
}

type CachedContents struct {
	Largest  string `json:"largest"`
	NonNull  int64  `json:"non_null"`
	Null     int64  `json:"null"`
	Smallest string `json:"smallest"`
	Top      []Top  `json:"top"`
}

type Top struct {
	Count int64  `json:"count"`
	Item  string `json:"item"`
}

type Format struct {
	Align *string `json:"align,omitempty"`
	View  *string `json:"view,omitempty"`
}

type Grant struct {
	Flags     []string `json:"flags"`
	Inherited bool     `json:"inherited"`
	Type      string   `json:"type"`
}

type Metadata struct {
	Attachments           []Attachment     `json:"attachments"`
	AvailableDisplayTypes []string         `json:"availableDisplayTypes"`
	CustomFields          CustomFields     `json:"custom_fields"`
	JSONQuery             JSONQuery        `json:"jsonQuery"`
	RDFSubject            string           `json:"rdfSubject"`
	RenderTypeConfig      RenderTypeConfig `json:"renderTypeConfig"`
}

type Attachment struct {
	AssetID  string `json:"assetId"`
	BlobID   string `json:"blobId"`
	Filename string `json:"filename"`
	Name     string `json:"name"`
}

type CustomFields struct {
	AdditionalResources AdditionalResources `json:"Additional Resources"`
	CommonCore          CommonCore          `json:"Common Core"`
	DatasetInformation  DatasetInformation  `json:"Dataset Information"`
	DatasetSummary      DatasetSummary      `json:"Dataset Summary"`
	Notes               Notes               `json:"Notes"`
}

type AdditionalResources struct {
	AdditionalResourcesSeeAlso string `json:"See Also "`
	SeeAlso                    string `json:"See Also"`
}

type CommonCore struct {
	ContactEmail string `json:"Contact Email"`
	ContactName  string `json:"Contact Name"`
	Publisher    string `json:"Publisher"`
}

type DatasetInformation struct {
	Agency string `json:"Agency"`
}

type DatasetSummary struct {
	ContactInformation string `json:"Contact Information"`
	Coverage           string `json:"Coverage"`
	DataFrequency      string `json:"Data Frequency"`
	DatasetOwner       string `json:"Dataset Owner"`
	Granularity        string `json:"Granularity"`
	Organization       string `json:"Organization"`
	PostingFrequency   string `json:"Posting Frequency"`
	TimePeriod         string `json:"Time Period"`
	Units              string `json:"Units"`
}

type Notes struct {
	Notes string `json:"Notes"`
}

type JSONQuery struct {
	Order []Order `json:"order"`
}

type Order struct {
	Ascending       bool   `json:"ascending"`
	ColumnFieldName string `json:"columnFieldName"`
}

type RenderTypeConfig struct {
	Visible Visible `json:"visible"`
}

type Visible struct {
	Table bool `json:"table"`
}

type Owner struct {
	DisplayName           string   `json:"displayName"`
	ID                    string   `json:"id"`
	ProfileImageURLLarge  string   `json:"profileImageUrlLarge"`
	ProfileImageURLMedium string   `json:"profileImageUrlMedium"`
	ProfileImageURLSmall  string   `json:"profileImageUrlSmall"`
	Rights                []string `json:"rights"`
	RoleName              string   `json:"roleName"`
	ScreenName            string   `json:"screenName"`
}

type Query struct {
	OrderBys []OrderBy `json:"orderBys"`
}

type OrderBy struct {
	Ascending  bool       `json:"ascending"`
	Expression Expression `json:"expression"`
}

type Expression struct {
	ColumnID int64  `json:"columnId"`
	Type     string `json:"type"`
}

type TypeName string

const (
	MetaData     TypeName = "meta_data"
	CalendarDate TypeName = "calendar_date"
	Text         TypeName = "text"
)

type invalidTypeName string
func (x invalidTypeName) Error() string { return "invalid TypeName: " + string(x) }

func (x *TypeName) UnmarshalJSON(data []byte) error {
	var value string
	if err := json.Unmarshal(data, &value); err != nil { return err }
	switch TypeName(value) {
	case MetaData, CalendarDate, Text: *x = TypeName(value); return nil
	}
	return invalidTypeName(value)
}

type Datum struct {
	Integer *int64
	String  *string
}

func (x *Datum) UnmarshalJSON(data []byte) error {
	object, err := unmarshalUnion(data, &x.Integer, nil, nil, &x.String, false, nil, false, nil, false, nil, false, nil, true)
	if err != nil {
		return err
	}
	if object {
	}
	return nil
}

func (x *Datum) MarshalJSON() ([]byte, error) {
	return marshalUnion(x.Integer, nil, nil, x.String, false, nil, false, nil, false, nil, false, nil, true)
}

func unmarshalUnion(data []byte, pi **int64, pf **float64, pb **bool, ps **string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) (bool, error) {
	if pi != nil {
			*pi = nil
	}
	if pf != nil {
			*pf = nil
	}
	if pb != nil {
			*pb = nil
	}
	if ps != nil {
			*ps = nil
	}

	dec := json.NewDecoder(bytes.NewReader(data))
	dec.UseNumber()
	tok, err := dec.Token()
	if err != nil {
			return false, err
	}

	switch v := tok.(type) {
	case json.Number:
			if pi != nil {
					i, err := v.Int64()
					if err == nil {
							*pi = &i
							return false, nil
					}
			}
			if pf != nil {
					f, err := v.Float64()
					if err == nil {
							*pf = &f
							return false, nil
					}
					return false, errors.New("Unparsable number")
			}
			return false, errors.New("Union does not contain number")
	case float64:
			return false, errors.New("Decoder should not return float64")
	case bool:
			if pb != nil {
					*pb = &v
					return false, nil
			}
			return false, errors.New("Union does not contain bool")
	case string:
			if haveEnum {
					return false, json.Unmarshal(data, pe)
			}
			if ps != nil {
					*ps = &v
					return false, nil
			}
			return false, errors.New("Union does not contain string")
	case nil:
			if nullable {
					return false, nil
			}
			return false, errors.New("Union does not contain null")
	case json.Delim:
			if v == '{' {
					if haveObject {
							return true, json.Unmarshal(data, pc)
					}
					if haveMap {
							return false, json.Unmarshal(data, pm)
					}
					return false, errors.New("Union does not contain object")
			}
			if v == '[' {
					if haveArray {
							return false, json.Unmarshal(data, pa)
					}
					return false, errors.New("Union does not contain array")
			}
			return false, errors.New("Cannot handle delimiter")
	}
	return false, errors.New("Cannot unmarshal union")
}

func marshalUnion(pi *int64, pf *float64, pb *bool, ps *string, haveArray bool, pa interface{}, haveObject bool, pc interface{}, haveMap bool, pm interface{}, haveEnum bool, pe interface{}, nullable bool) ([]byte, error) {
	if pi != nil {
			return json.Marshal(*pi)
	}
	if pf != nil {
			return json.Marshal(*pf)
	}
	if pb != nil {
			return json.Marshal(*pb)
	}
	if ps != nil {
			return json.Marshal(*ps)
	}
	if haveArray {
			return json.Marshal(pa)
	}
	if haveObject {
			return json.Marshal(pc)
	}
	if haveMap {
			return json.Marshal(pm)
	}
	if haveEnum {
			return json.Marshal(pe)
	}
	if nullable {
			return json.Marshal(nil)
	}
	return nil, errors.New("Union must not be null")
}
