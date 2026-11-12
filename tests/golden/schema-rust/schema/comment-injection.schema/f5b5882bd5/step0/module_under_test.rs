// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

/// Comment delimiters:
/// */
/// /*
/// {-
/// -}
/// """
/// </summary> & <br>
/// }
/// }
/// }
/// }
/// }
#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct TopLevel {
    /// Ends with a backslash \
    pub trailing_backslash: Option<String>,

    /// Ends with a quote "
    pub trailing_quote: Option<String>,

    /// Ends with a triple quote """
    pub trailing_triple_quote: Option<String>,

    /// Property delimiters:
    /// */
    /// /*
    /// {-
    /// -}
    /// """
    /// </summary> & <br>
    /// }
    /// }
    /// }
    /// }
    /// }
    pub value: String,
}
