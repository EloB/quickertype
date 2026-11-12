// Code generated from JSON Schema using quicktype. DO NOT EDIT.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    topLevel, err := UnmarshalTopLevel(bytes)
//    bytes, err = topLevel.Marshal()

package main

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
	Txs []Tx `json:"txs"`
}

type Tx struct {
	DoubleSpend bool    `json:"double_spend"`
	Hash        string  `json:"hash"`
	Inputs      []Input `json:"inputs"`
	LockTime    int64   `json:"lock_time"`
	Out         []Out   `json:"out"`
	RelayedBy   string  `json:"relayed_by"`
	Size        int64   `json:"size"`
	Time        int64   `json:"time"`
	TxIndex     int64   `json:"tx_index"`
	Ver         int64   `json:"ver"`
	VinSz       int64   `json:"vin_sz"`
	VoutSz      int64   `json:"vout_sz"`
}

type Input struct {
	PrevOut  Out    `json:"prev_out"`
	Script   string `json:"script"`
	Sequence int64  `json:"sequence"`
}

type Out struct {
	Addr    string `json:"addr"`
	N       int64  `json:"n"`
	Script  string `json:"script"`
	Spent   bool   `json:"spent"`
	TxIndex int64  `json:"tx_index"`
	Type    int64  `json:"type"`
	Value   int64  `json:"value"`
}
