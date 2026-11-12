from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast, Callable


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


@dataclass
class Out:
    addr: str
    n: int
    script: str
    spent: bool
    tx_index: int
    type: int
    value: int

    @staticmethod
    def from_dict(obj: Any) -> 'Out':
        assert isinstance(obj, dict)
        addr = from_str(obj["addr"])
        n = from_int(obj["n"])
        script = from_str(obj["script"])
        spent = from_bool(obj["spent"])
        tx_index = from_int(obj["tx_index"])
        type = from_int(obj["type"])
        value = from_int(obj["value"])
        return Out(addr, n, script, spent, tx_index, type, value)

    def to_dict(self) -> dict:
        result: dict = {}
        result["addr"] = from_str(self.addr)
        result["n"] = from_int(self.n)
        result["script"] = from_str(self.script)
        result["spent"] = from_bool(self.spent)
        result["tx_index"] = from_int(self.tx_index)
        result["type"] = from_int(self.type)
        result["value"] = from_int(self.value)
        return result


@dataclass
class Input:
    prev_out: Out
    script: str
    sequence: int

    @staticmethod
    def from_dict(obj: Any) -> 'Input':
        assert isinstance(obj, dict)
        prev_out = Out.from_dict(obj["prev_out"])
        script = from_str(obj["script"])
        sequence = from_int(obj["sequence"])
        return Input(prev_out, script, sequence)

    def to_dict(self) -> dict:
        result: dict = {}
        result["prev_out"] = to_class(Out, self.prev_out)
        result["script"] = from_str(self.script)
        result["sequence"] = from_int(self.sequence)
        return result


@dataclass
class Tx:
    double_spend: bool
    hash: str
    inputs: list[Input]
    lock_time: int
    out: list[Out]
    relayed_by: str
    size: int
    time: int
    tx_index: int
    ver: int
    vin_sz: int
    vout_sz: int

    @staticmethod
    def from_dict(obj: Any) -> 'Tx':
        assert isinstance(obj, dict)
        double_spend = from_bool(obj["double_spend"])
        hash = from_str(obj["hash"])
        inputs = from_list(Input.from_dict, obj["inputs"])
        lock_time = from_int(obj["lock_time"])
        out = from_list(Out.from_dict, obj["out"])
        relayed_by = from_str(obj["relayed_by"])
        size = from_int(obj["size"])
        time = from_int(obj["time"])
        tx_index = from_int(obj["tx_index"])
        ver = from_int(obj["ver"])
        vin_sz = from_int(obj["vin_sz"])
        vout_sz = from_int(obj["vout_sz"])
        return Tx(double_spend, hash, inputs, lock_time, out, relayed_by, size, time, tx_index, ver, vin_sz, vout_sz)

    def to_dict(self) -> dict:
        result: dict = {}
        result["double_spend"] = from_bool(self.double_spend)
        result["hash"] = from_str(self.hash)
        result["inputs"] = from_list(lambda x: to_class(Input, x), self.inputs)
        result["lock_time"] = from_int(self.lock_time)
        result["out"] = from_list(lambda x: to_class(Out, x), self.out)
        result["relayed_by"] = from_str(self.relayed_by)
        result["size"] = from_int(self.size)
        result["time"] = from_int(self.time)
        result["tx_index"] = from_int(self.tx_index)
        result["ver"] = from_int(self.ver)
        result["vin_sz"] = from_int(self.vin_sz)
        result["vout_sz"] = from_int(self.vout_sz)
        return result


@dataclass
class TopLevel:
    txs: list[Tx]

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        txs = from_list(Tx.from_dict, obj["txs"])
        return TopLevel(txs)

    def to_dict(self) -> dict:
        result: dict = {}
        result["txs"] = from_list(lambda x: to_class(Tx, x), self.txs)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
