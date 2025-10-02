#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');
const fs = require('fs');

async function build() {
    const rootDir = path.join(__dirname, '..');
    const srcDir = path.join(rootDir, 'src');
    const outDir = path.join(rootDir, 'build', 'out');

    // Create build output directory
    if (!fs.existsSync(outDir)) {
        fs.mkdirSync(outDir, { recursive: true });
    }

    const builder = new ProgramBuilder();

    await builder.run({
        project: srcDir,
        outDir: outDir,
        createPackage: false,
        copyToStaging: true,
        stagingDir: outDir,
        diagnosticFilters: ['**/*']
    });

    if (builder.program.getDiagnostics().length > 0) {
        console.log('\n❌ Build completed with errors:');
        builder.program.getDiagnostics().forEach(diagnostic => {
            console.log(`  ${diagnostic.file?.pathAbsolute || 'unknown'}:${diagnostic.range.start.line + 1} - ${diagnostic.message}`);
        });
        process.exit(1);
    } else {
        console.log('\n✅ Build completed successfully!');
        console.log(`Output: ${outDir}`);
    }
}

build().catch(err => {
    console.error('Build failed:', err);
    process.exit(1);
});
