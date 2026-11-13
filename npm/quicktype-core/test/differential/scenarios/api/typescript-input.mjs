// Port of test/unit/typescript-input.test.ts. The schema is made once per
// run by the reference checkout's quicktype-typescript-input. Tests that
// render code do what the test does; tests that only inspect the schema
// return it together with the output of the test file's own
// TypeScript-rendering pipeline (generateTypeScriptForSource) for it, so
// the schema still goes through `qt`.

import { noCheckout, schemaForTypeScriptSource, schemaInputData } from "./_support.mjs";

function schemaForSource(sourceData) {
    return {
        name: sourceData.name ?? "",
        schema: JSON.parse(sourceData.schema),
        uris: sourceData.uris,
    };
}

async function swiftFor(qt, sourceData) {
    const inputData = await schemaInputData(qt, sourceData);
    return await qt.quicktype({ inputData, lang: "swift" });
}

async function generateTypeScriptFor(qt, sourceData) {
    const inputData = await schemaInputData(qt, sourceData, new qt.FetchingJSONSchemaStore());
    return await qt.quicktype({
        inputData,
        lang: "typescript",
        rendererOptions: { "just-types": true, "prefer-unions": false },
    });
}

/** A test that renders `source` with `render`. */
function rendering(name, lang, render, source) {
    return {
        name,
        lang,
        async run(qt, ctx) {
            if (ctx.referenceCheckout === undefined) return noCheckout;
            return await render(qt, schemaForTypeScriptSource(ctx, source));
        },
    };
}

/** A test that inspects the schema of `source`. */
function schemaOnly(name, source) {
    return {
        name,
        lang: "typescript",
        async run(qt, ctx) {
            if (ctx.referenceCheckout === undefined) return noCheckout;
            const sourceData = schemaForTypeScriptSource(ctx, source);
            const schema = schemaForSource(sourceData);
            return { schema, typescript: await generateTypeScriptFor(qt, sourceData) };
        },
    };
}

export const cases = [
    rendering(
        "class-property-declaration-order",
        "swift",
        swiftFor,
        `
            class A {
                name: string;
                age: number;
            }
        `,
    ),
    schemaOnly(
        "simple-interface",
        `
            export interface Person {
                name: string;
                age?: number;
            }
        `,
    ),
    schemaOnly(
        "TopLevel-marker",
        `
            /**
             * The root type. #TopLevel
             */
            export interface Root {
                id: number;
                child: Child;
            }

            export interface Child {
                label: string;
            }
        `,
    ),
    schemaOnly(
        "export-default",
        `
            export default interface Person {
                name: string;
            }
        `,
    ),
    schemaOnly(
        "jsdoc-type-braces",
        `
            export type Person = {
                /**
                 * @type {string}
                 * @memberOf {Person}
                 */
                name: string;
            };

            export type MemberInfo = Required<Person>;
        `,
    ),
    schemaOnly(
        "class-property-initializers-become-defaults",
        `
            export class Config {
                public name: string = "default-name";

                public count: number = 42;
            }
        `,
    ),
    schemaOnly(
        "string-enum-member-names-in-schema",
        `
            export enum TestEnum {
                Foo = "000",
                Bar = "001",
                Baz = "002",
            }
        `,
    ),
    rendering(
        "string-enum-member-names-in-typescript-output",
        "typescript",
        generateTypeScriptFor,
        `
            export enum TestEnum {
                Foo = "000",
                Bar = "001",
                Baz = "002",
            }
        `,
    ),
    schemaOnly(
        "bigint-to-number",
        `
            export interface WithBigint {
                big: bigint;
            }
        `,
    ),
    schemaOnly(
        "Date-to-date-time",
        `
            export interface User {
                id: number;
                createdAt: Date;
            }
        `,
    ),
    schemaOnly(
        "Map-to-map-schema",
        `
            export interface Env {
                flags: Map<string, boolean>;
                services: Map<string, Service>;
                nested: ReadonlyMap<string, Map<string, number>>;
            }

            export interface Service {
                url: string;
            }
        `,
    ),
    schemaOnly(
        "user-defined-Map",
        `
            export interface Map {
                width: number;
            }

            export interface Atlas {
                map: Map;
            }
        `,
    ),
    schemaOnly(
        "unsupported-built-in-error",
        `
                export interface Bag {
                    tags: Set<string>;
                }
            `,
    ),
    schemaOnly(
        "compiler-error",
        `
                export interface Broken {
                    name: DoesNotExist;
                }
            `,
    ),
];
