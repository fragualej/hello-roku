#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');
const fs = require('fs');

async function packageApp() {
    const rootDir = path.join(__dirname, '..');
    const srcDir = path.join(rootDir, 'src');
    const outDir = path.join(rootDir, 'build', 'out');
    const packagePath = path.join(rootDir, 'build', 'roku-app.zip');

    // Create build output directory
    if (!fs.existsSync(outDir)) {
        fs.mkdirSync(outDir, { recursive: true });
    }

    const builder = new ProgramBuilder();

    await builder.run({
        project: srcDir,
        outDir: outDir,
        createPackage: true,
        stagingDir: outDir,
        outFile: packagePath,
        diagnosticFilters: ['**/*']
    });

    if (builder.program.getDiagnostics().length > 0) {
        console.log('\n❌ Package build completed with errors:');
        builder.program.getDiagnostics().forEach(diagnostic => {
            console.log(`  ${diagnostic.file?.pathAbsolute || 'unknown'}:${diagnostic.range.start.line + 1} - ${diagnostic.message}`);
        });
        process.exit(1);
    } else {
        console.log('\n✅ Package created successfully!');
        console.log(`Package: ${packagePath}`);
    }
}

packageApp().catch(err => {
    console.error('Package build failed:', err);
    process.exit(1);
});
