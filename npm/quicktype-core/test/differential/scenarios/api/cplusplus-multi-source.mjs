// Port of test/unit/cplusplus-multi-source.test.ts.

async function cPlusPlusMultiSourceFiles(qt) {
    const jsonInput = qt.jsonInputForTargetLanguage("cplusplus");
    await jsonInput.addSource({
        name: "ChunkCache",
        samples: ['{"chunks":["one"],"size":1}'],
    });
    await jsonInput.addSource({
        name: "BufferPath",
        samples: ['{"path":"somewhere","maxSize":2}'],
    });

    const inputData = new qt.InputData();
    inputData.addInput(jsonInput);
    return await qt.quicktypeMultiFile({
        inputData,
        lang: "cplusplus",
        outputFilename: "quicktype.hpp",
        rendererOptions: { "source-style": "multi-source" },
    });
}

export const cases = [
    { name: "umbrella-header-includes-generators", lang: "cplusplus", run: cPlusPlusMultiSourceFiles },
    { name: "usage-comments-name-top-level-types", lang: "cplusplus", run: cPlusPlusMultiSourceFiles },
];
