import datetime
from dataclasses import dataclass
from typing import Any, TypeVar, Type, Callable, cast
from enum import Enum
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_datetime(x: Any) -> datetime.datetime:
    return dateutil.parser.parse(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


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


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


@dataclass
class Facets:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'Facets':
        assert isinstance(obj, dict)
        return Facets()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


class Status(Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"


class CustomIncomeType(Enum):
    PUBLIC = "public"
    OTHER = "other"


@dataclass
class CustomIncome:
    amount: int
    created_at: datetime.datetime
    id: str
    name: str
    status: Status
    type: CustomIncomeType
    updated_at: datetime.datetime
    uri: str

    @staticmethod
    def from_dict(obj: Any) -> 'CustomIncome':
        assert isinstance(obj, dict)
        amount = from_int(obj["amount"])
        created_at = from_datetime(obj["created_at"])
        id = from_str(obj["id"])
        name = from_str(obj["name"])
        status = Status(obj["status"])
        type = CustomIncomeType(obj["type"])
        updated_at = from_datetime(obj["updated_at"])
        uri = from_str(obj["uri"])
        return CustomIncome(amount, created_at, id, name, status, type, updated_at, uri)

    def to_dict(self) -> dict:
        result: dict = {}
        result["amount"] = from_int(self.amount)
        result["created_at"] = self.created_at.isoformat()
        result["id"] = from_str(self.id)
        result["name"] = from_str(self.name)
        result["status"] = to_enum(Status, self.status)
        result["type"] = to_enum(CustomIncomeType, self.type)
        result["updated_at"] = self.updated_at.isoformat()
        result["uri"] = from_str(self.uri)
        return result


class ResultType(Enum):
    FINANCIAL_DATA_NGO = "FinancialDataNGO"
    FINANCIAL_DATA_LAWYER = "FinancialDataLawyer"
    FINANCIAL_DATA_TRADE_ASSOCIATION = "FinancialDataTradeAssociation"


@dataclass
class Result:
    created_at: datetime.datetime
    custom_incomes: list[CustomIncome]
    end_date: datetime.datetime
    eur_sources_grants: int
    eur_sources_procurement: int
    id: str
    representative: str
    start_date: datetime.datetime
    status: Status
    type: ResultType
    updated_at: datetime.datetime
    uri: str
    cost_absolute: int | None
    cost_max: int | None
    cost_min: int | None
    direct_rep_costs_max: None
    direct_rep_costs_min: None
    eur_sources_grants_src: str | None
    eur_sources_procurement_src: str | None
    new_organisation: None
    no_clients: str | None
    other_financial_information: str | None
    other_sources_contributions: int | None
    other_sources_donation: int | None
    other_sources_total: int | None
    public_financing_infranational: int | None
    public_financing_national: int | None
    public_financing_total: int | None
    total_budget: int | None
    turnover_absolute: int | None
    turnover_max: int | None
    turnover_min: int | None

    @staticmethod
    def from_dict(obj: Any) -> 'Result':
        assert isinstance(obj, dict)
        created_at = from_datetime(obj["created_at"])
        custom_incomes = from_list(CustomIncome.from_dict, obj["customIncomes"])
        end_date = from_datetime(obj["end_date"])
        eur_sources_grants = from_int(obj["eur_sources_grants"])
        eur_sources_procurement = from_int(obj["eur_sources_procurement"])
        id = from_str(obj["id"])
        representative = from_str(obj["representative"])
        start_date = from_datetime(obj["start_date"])
        status = Status(obj["status"])
        type = ResultType(obj["type"])
        updated_at = from_datetime(obj["updated_at"])
        uri = from_str(obj["uri"])
        cost_absolute = from_union([from_int, from_none], obj["cost_absolute"])
        cost_max = from_union([from_int, from_none], obj["cost_max"])
        cost_min = from_union([from_int, from_none], obj["cost_min"])
        direct_rep_costs_max = from_none(obj["direct_rep_costs_max"])
        direct_rep_costs_min = from_none(obj["direct_rep_costs_min"])
        eur_sources_grants_src = from_union([from_none, from_str], obj["eur_sources_grants_src"])
        eur_sources_procurement_src = from_union([from_none, from_str], obj["eur_sources_procurement_src"])
        new_organisation = from_none(obj["new_organisation"])
        no_clients = from_union([from_none, from_str], obj["no_clients"])
        other_financial_information = from_union([from_none, from_str], obj["other_financial_information"])
        other_sources_contributions = from_union([from_int, from_none], obj["other_sources_contributions"])
        other_sources_donation = from_union([from_int, from_none], obj["other_sources_donation"])
        other_sources_total = from_union([from_int, from_none], obj["other_sources_total"])
        public_financing_infranational = from_union([from_int, from_none], obj["public_financing_infranational"])
        public_financing_national = from_union([from_int, from_none], obj["public_financing_national"])
        public_financing_total = from_union([from_int, from_none], obj["public_financing_total"])
        total_budget = from_union([from_int, from_none], obj["total_budget"])
        turnover_absolute = from_union([from_int, from_none], obj["turnover_absolute"])
        turnover_max = from_union([from_int, from_none], obj["turnover_max"])
        turnover_min = from_union([from_int, from_none], obj["turnover_min"])
        return Result(created_at, custom_incomes, end_date, eur_sources_grants, eur_sources_procurement, id, representative, start_date, status, type, updated_at, uri, cost_absolute, cost_max, cost_min, direct_rep_costs_max, direct_rep_costs_min, eur_sources_grants_src, eur_sources_procurement_src, new_organisation, no_clients, other_financial_information, other_sources_contributions, other_sources_donation, other_sources_total, public_financing_infranational, public_financing_national, public_financing_total, total_budget, turnover_absolute, turnover_max, turnover_min)

    def to_dict(self) -> dict:
        result: dict = {}
        result["created_at"] = self.created_at.isoformat()
        result["customIncomes"] = from_list(lambda x: to_class(CustomIncome, x), self.custom_incomes)
        result["end_date"] = self.end_date.isoformat()
        result["eur_sources_grants"] = from_int(self.eur_sources_grants)
        result["eur_sources_procurement"] = from_int(self.eur_sources_procurement)
        result["id"] = from_str(self.id)
        result["representative"] = from_str(self.representative)
        result["start_date"] = self.start_date.isoformat()
        result["status"] = to_enum(Status, self.status)
        result["type"] = to_enum(ResultType, self.type)
        result["updated_at"] = self.updated_at.isoformat()
        result["uri"] = from_str(self.uri)
        result["cost_absolute"] = from_union([from_int, from_none], self.cost_absolute)
        result["cost_max"] = from_union([from_int, from_none], self.cost_max)
        result["cost_min"] = from_union([from_int, from_none], self.cost_min)
        result["direct_rep_costs_max"] = from_none(self.direct_rep_costs_max)
        result["direct_rep_costs_min"] = from_none(self.direct_rep_costs_min)
        result["eur_sources_grants_src"] = from_union([from_none, from_str], self.eur_sources_grants_src)
        result["eur_sources_procurement_src"] = from_union([from_none, from_str], self.eur_sources_procurement_src)
        result["new_organisation"] = from_none(self.new_organisation)
        result["no_clients"] = from_union([from_none, from_str], self.no_clients)
        result["other_financial_information"] = from_union([from_none, from_str], self.other_financial_information)
        result["other_sources_contributions"] = from_union([from_int, from_none], self.other_sources_contributions)
        result["other_sources_donation"] = from_union([from_int, from_none], self.other_sources_donation)
        result["other_sources_total"] = from_union([from_int, from_none], self.other_sources_total)
        result["public_financing_infranational"] = from_union([from_int, from_none], self.public_financing_infranational)
        result["public_financing_national"] = from_union([from_int, from_none], self.public_financing_national)
        result["public_financing_total"] = from_union([from_int, from_none], self.public_financing_total)
        result["total_budget"] = from_union([from_int, from_none], self.total_budget)
        result["turnover_absolute"] = from_union([from_int, from_none], self.turnover_absolute)
        result["turnover_max"] = from_union([from_int, from_none], self.turnover_max)
        result["turnover_min"] = from_union([from_int, from_none], self.turnover_min)
        return result


@dataclass
class TopLevel:
    count: int
    facets: Facets
    limit: int
    next: str
    offset: int
    previous: bool
    results: list[Result]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        count = from_int(obj["count"])
        facets = Facets.from_dict(obj["facets"])
        limit = from_int(obj["limit"])
        next = from_str(obj["next"])
        offset = from_int(obj["offset"])
        previous = from_bool(obj["previous"])
        results = from_list(Result.from_dict, obj["results"])
        return TopLevel(count, facets, limit, next, offset, previous, results)

    def to_dict(self) -> dict:
        result: dict = {}
        result["count"] = from_int(self.count)
        result["facets"] = to_class(Facets, self.facets)
        result["limit"] = from_int(self.limit)
        result["next"] = from_str(self.next)
        result["offset"] = from_int(self.offset)
        result["previous"] = from_bool(self.previous)
        result["results"] = from_list(lambda x: to_class(Result, x), self.results)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
