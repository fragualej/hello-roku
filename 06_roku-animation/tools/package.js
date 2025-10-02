#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');
const fs = require('fs');

async function packageApp() {
    const rootDir = path.join(__dirname, '..');
    const configPath = path.join(__dirname, 'bsconfig.json');
    const packagePath = path.join(rootDir, 'build', 'roku-app.zip');

    const builder = new ProgramBuilder();

    await builder.run({
        project: configPath,
        createPackage: true,
        outFile: packagePath
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
