from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class TopLevel:
    """Comment delimiters:
    */
    /*
    {-
    -}
    \"\"\"
    </summary> & <br>
    }
    }
    }
    }
    }
    """
    value: str
    """Property delimiters:
    */
    /*
    {-
    -}
    \"\"\"
    </summary> & <br>
    }
    }
    }
    }
    }
    """
    trailing_backslash: str | None = None
    """Ends with a backslash \\"""

    trailing_quote: str | None = None
    """Ends with a quote \""""

    trailing_triple_quote: str | None = None
    """Ends with a triple quote \"\"\""""

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        value = from_str(obj["value"])
        trailing_backslash = from_union([from_str, from_none], obj.get("trailingBackslash"))
        trailing_quote = from_union([from_str, from_none], obj.get("trailingQuote"))
        trailing_triple_quote = from_union([from_str, from_none], obj.get("trailingTripleQuote"))
        return TopLevel(value, trailing_backslash, trailing_quote, trailing_triple_quote)

    def to_dict(self) -> dict:
        result: dict = {}
        result["value"] = from_str(self.value)
        if self.trailing_backslash is not None:
            result["trailingBackslash"] = from_union([from_str, from_none], self.trailing_backslash)
        if self.trailing_quote is not None:
            result["trailingQuote"] = from_union([from_str, from_none], self.trailing_quote)
        if self.trailing_triple_quote is not None:
            result["trailingTripleQuote"] = from_union([from_str, from_none], self.trailing_triple_quote)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
