package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

/**
 * Comment delimiters:
 * * /
 * / *
 * {-
 * -}
 * """
 * </summary> & <br>
 * }
 * }
 * }
 * }
 * }
 */
case class TopLevel (
    /**
     * Ends with a backslash \
     */
    val trailingBackslash : Option[String] = None,

    /**
     * Ends with a quote "
     */
    val trailingQuote : Option[String] = None,

    /**
     * Ends with a triple quote """
     */
    val trailingTripleQuote : Option[String] = None,

    /**
     * Property delimiters:
     * * /
     * / *
     * {-
     * -}
     * """
     * </summary> & <br>
     * }
     * }
     * }
     * }
     * }
     */
    val value : String
) derives Encoder.AsObject, Decoder
