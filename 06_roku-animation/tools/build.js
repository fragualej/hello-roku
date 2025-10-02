#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');
const fs = require('fs');

async function build() {
    const rootDir = path.join(__dirname, '..');
    const configPath = path.join(__dirname, 'bsconfig.json');

    const builder = new ProgramBuilder();

    await builder.run({
        project: configPath
    });

    if (builder.program.getDiagnostics().length > 0) {
        console.log('\n❌ Build completed with errors:');
        builder.program.getDiagnostics().forEach(diagnostic => {
            console.log(`  ${diagnostic.file?.pathAbsolute || 'unknown'}:${diagnostic.range.start.line + 1} - ${diagnostic.message}`);
        });
        process.exit(1);
    } else {
        console.log('\n✅ Build completed successfully!');
        console.log(`Output: ${path.join(rootDir, 'dist')}`);
    }
}

build().catch(err => {
    console.error('Build failed:', err);
    process.exit(1);
});
