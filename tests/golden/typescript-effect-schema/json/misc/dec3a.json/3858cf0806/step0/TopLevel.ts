import * as S from "effect/Schema";


export class Location extends S.Class<Location>("Location")({
    "administrative_area": S.String,
    "country": S.String,
    "fax_number": S.String,
    "locality": S.String,
    "mobile_number": S.String,
    "phone_number": S.String,
    "phone_number_extension": S.String,
    "postal_code": S.String.pipe(S.pattern(/^-?\d+$/)),
    "sub_premise": S.Null,
    "thoroughfare": S.String,
}) {}

export class HiringOrg extends S.Class<HiringOrg>("HiringOrg")({
    "name": S.String,
    "uuid": S.UUID,
}) {}

export class Result extends S.Class<Result>("Result")({
    "about_office": S.String,
    "application_process": S.String,
    "body": S.String,
    "changed": S.String.pipe(S.pattern(/^-?\d+$/)),
    "created": S.String.pipe(S.pattern(/^-?\d+$/)),
    "deadline": S.Null,
    "hiring_office": S.Null,
    "hiring_org": HiringOrg,
    "job_id": S.Null,
    "language": S.String,
    "location": Location,
    "num_positions": S.String.pipe(S.pattern(/^-?\d+$/)),
    "position": S.String,
    "practice_area": S.String,
    "qualifications": S.String,
    "relocation_expenses": S.Null,
    "salary": S.String,
    "title": S.String,
    "travel": S.String,
    "url": S.String,
    "uuid": S.UUID,
    "vuuid": S.UUID,
}) {}

export class Resultset extends S.Class<Resultset>("Resultset")({
    "count": S.Int,
    "page": S.Int,
    "pagesize": S.Int,
}) {}

export class ResponseInfo extends S.Class<ResponseInfo>("ResponseInfo")({
    "developerMessage": S.String,
    "status": S.Int,
}) {}

export class Metadata extends S.Class<Metadata>("Metadata")({
    "executionTime": S.Number,
    "responseInfo": ResponseInfo,
    "resultset": Resultset,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "metadata": Metadata,
    "results": S.Array(Result),
}) {}
