// quicktype's API-level unit tests (test/unit/*.test.ts in the quicktype
// repository), ported to differential scenarios: one module per test file
// in ./api/, one case per `test`/`it` (or `test.each` row). A case makes
// the API calls its test makes and returns everything they give (results
// of several calls in an object), or lets the error propagate; it asserts
// nothing, since the comparison with the reference is the assertion.
//
// A module exports `cases`: `{ name, lang?, run(qt, ctx) }`, which become
// the scenarios `api/<test file stem>/<name>`.
//
// Not ported: CLI tests (cli-epipe, cli-options, graphql-introspection,
// the `main` parts of url-input and the CompressedJSONFromStream parts of
// integer-range-inference), packaging tests (core-package,
// renderer-options.test-d) and tests of internal modules (markov-chain,
// naming, output-diff, union-accumulator). date-time-recognizer and
// windows-paths only use deep `dist/` imports, which npm users can make
// too, so they are included.

import * as cjsonEnumDefault from "./api/cjson-enum-default.mjs";
import * as cjsonSplitSources from "./api/cjson-split-sources.mjs";
import * as cplusplusMultiSource from "./api/cplusplus-multi-source.mjs";
import * as csharpDateonlyTimeonlyConverters from "./api/csharp-dateonly-timeonly-converters.mjs";
import * as csharpPartialHelpers from "./api/csharp-partial-helpers.mjs";
import * as csharpRecords from "./api/csharp-records.mjs";
import * as csharpSuperfluousUsings from "./api/csharp-superfluous-usings.mjs";
import * as csharpSystemTextJsonExceptions from "./api/csharp-system-text-json-exceptions.mjs";
import * as dartMethodNames from "./api/dart-method-names.mjs";
import * as dateTimeRecognizer from "./api/date-time-recognizer.mjs";
import * as emptyJsonSamples from "./api/empty-json-samples.mjs";
import * as enumOrder from "./api/enum-order.mjs";
import * as golangEnumTypeNameSuffix from "./api/golang-enum-type-name-suffix.mjs";
import * as haskellEnumCaseNaming from "./api/haskell-enum-case-naming.mjs";
import * as ieSuffixSingularization from "./api/ie-suffix-singularization.mjs";
import * as integerRangeInference from "./api/integer-range-inference.mjs";
import * as javaAcronymNames from "./api/java-acronym-names.mjs";
import * as javascriptAllObjectsExports from "./api/javascript-all-objects-exports.mjs";
import * as jsonSchemaDefinitions from "./api/json-schema-definitions.mjs";
import * as justTypesOption from "./api/just-types-option.mjs";
import * as kotlinKlaxonEmptyObjectMap from "./api/kotlin-klaxon-empty-object-map.mjs";
import * as kotlinxDatetimeSerializers from "./api/kotlinx-datetime-serializers.mjs";
import * as missingSchemaPath from "./api/missing-schema-path.mjs";
import * as parseJson from "./api/parse-json.mjs";
import * as phpUnions from "./api/php-unions.mjs";
import * as phpValidation from "./api/php-validation.mjs";
import * as pipelineTiming from "./api/pipeline-timing.mjs";
import * as prefixItemsSchema from "./api/prefix-items-schema.mjs";
import * as pythonTypingType from "./api/python-typing-type.mjs";
import * as pythonUnionOrder from "./api/python-union-order.mjs";
import * as rustCycleBreakerBoxing from "./api/rust-cycle-breaker-boxing.mjs";
import * as rustEmptyTopLevels from "./api/rust-empty-top-levels.mjs";
import * as swiftAcronymNames from "./api/swift-acronym-names.mjs";
import * as swiftCodingKeysProtocol from "./api/swift-coding-keys-protocol.mjs";
import * as swiftFinalClasses from "./api/swift-final-classes.mjs";
import * as swiftJsonNullHashable from "./api/swift-json-null-hashable.mjs";
import * as typescriptEmptyObject from "./api/typescript-empty-object.mjs";
import * as typescriptFlowTopLevelAlias from "./api/typescript-flow-top-level-alias.mjs";
import * as typescriptInput from "./api/typescript-input.mjs";
import * as typescriptOutputFilename from "./api/typescript-output-filename.mjs";
import * as typescriptReadonlyIndex from "./api/typescript-readonly-index.mjs";
import * as typescriptTopLevelArray from "./api/typescript-top-level-array.mjs";
import * as urlInput from "./api/url-input.mjs";
import * as windowsPaths from "./api/windows-paths.mjs";
import * as windowsSchemaPaths from "./api/windows-schema-paths.mjs";

/** The ported test files, by file stem, in a fixed order. */
const testFiles = {
    "cjson-enum-default": cjsonEnumDefault,
    "cjson-split-sources": cjsonSplitSources,
    "cplusplus-multi-source": cplusplusMultiSource,
    "csharp-dateonly-timeonly-converters": csharpDateonlyTimeonlyConverters,
    "csharp-partial-helpers": csharpPartialHelpers,
    "csharp-records": csharpRecords,
    "csharp-superfluous-usings": csharpSuperfluousUsings,
    "csharp-system-text-json-exceptions": csharpSystemTextJsonExceptions,
    "dart-method-names": dartMethodNames,
    "date-time-recognizer": dateTimeRecognizer,
    "empty-json-samples": emptyJsonSamples,
    "enum-order": enumOrder,
    "golang-enum-type-name-suffix": golangEnumTypeNameSuffix,
    "haskell-enum-case-naming": haskellEnumCaseNaming,
    "ie-suffix-singularization": ieSuffixSingularization,
    "integer-range-inference": integerRangeInference,
    "java-acronym-names": javaAcronymNames,
    "javascript-all-objects-exports": javascriptAllObjectsExports,
    "json-schema-definitions": jsonSchemaDefinitions,
    "just-types-option": justTypesOption,
    "kotlin-klaxon-empty-object-map": kotlinKlaxonEmptyObjectMap,
    "kotlinx-datetime-serializers": kotlinxDatetimeSerializers,
    "missing-schema-path": missingSchemaPath,
    "parse-json": parseJson,
    "php-unions": phpUnions,
    "php-validation": phpValidation,
    "pipeline-timing": pipelineTiming,
    "prefix-items-schema": prefixItemsSchema,
    "python-typing-type": pythonTypingType,
    "python-union-order": pythonUnionOrder,
    "rust-cycle-breaker-boxing": rustCycleBreakerBoxing,
    "rust-empty-top-levels": rustEmptyTopLevels,
    "swift-acronym-names": swiftAcronymNames,
    "swift-coding-keys-protocol": swiftCodingKeysProtocol,
    "swift-final-classes": swiftFinalClasses,
    "swift-json-null-hashable": swiftJsonNullHashable,
    "typescript-empty-object": typescriptEmptyObject,
    "typescript-flow-top-level-alias": typescriptFlowTopLevelAlias,
    "typescript-input": typescriptInput,
    "typescript-output-filename": typescriptOutputFilename,
    "typescript-readonly-index": typescriptReadonlyIndex,
    "typescript-top-level-array": typescriptTopLevelArray,
    "url-input": urlInput,
    "windows-paths": windowsPaths,
    "windows-schema-paths": windowsSchemaPaths,
};

export function scenarios() {
    const list = [];
    for (const [stem, module] of Object.entries(testFiles)) {
        for (const c of module.cases) {
            const scenario = { id: `api/${stem}/${c.name}`, category: "api", group: stem, run: c.run };
            if (c.lang !== undefined) scenario.lang = c.lang;
            list.push(scenario);
        }
    }

    return list;
}
