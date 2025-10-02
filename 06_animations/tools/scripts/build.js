#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');

async function build() {
    const configPath = path.join(__dirname, '../bsconfig.json');

    console.log('🔨 Building project...');

    const builder = new ProgramBuilder();

    try {
        // Only compile to dist/, no deployment
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
            console.log('✅ Build completed successfully!');
            console.log('📁 Output directory: dist/');
        }
    } catch (error) {
        console.error('❌ Build failed:', error.message);
        process.exit(1);
    }
}

build().catch(err => {
    console.error('Build failed:', err);
    process.exit(1);
});
