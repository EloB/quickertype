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

// Comment delimiters:
// */
// /*
// {-
// -}
// """
// </summary> & <br>
// }
// }
// }
// }
// }
type TopLevel struct {
	// Ends with a backslash \             
	TrailingBackslash              *string `json:"trailingBackslash,omitempty"`
	// Ends with a quote "                 
	TrailingQuote                  *string `json:"trailingQuote,omitempty"`
	// Ends with a triple quote """        
	TrailingTripleQuote            *string `json:"trailingTripleQuote,omitempty"`
	// Property delimiters:                
	// */                                  
	// /*                                  
	// {-                                  
	// -}                                  
	// """                                 
	// </summary> & <br>                   
	// }                                   
	// }                                   
	// }                                   
	// }                                   
	// }                                   
	Value                          string  `json:"value"`
}
