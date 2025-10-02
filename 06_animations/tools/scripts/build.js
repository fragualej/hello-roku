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

        const diagnostics = builder.getDiagnostics(); // This includes plugin diagnostics

        const errors = diagnostics.filter(d => d.severity === 1); // 1 = Error
        const warnings = diagnostics.filter(d => d.severity === 2); // 2 = Warning

        if (warnings.length > 0) {
            console.log('\n⚠️  Warnings:');
            warnings.forEach(diagnostic => {
                const filePath = diagnostic.file?.pathAbsolute || 'unknown';
                const line = diagnostic.range.start.line + 1;
                const col = diagnostic.range.start.character + 1;
                console.log(`  ${filePath}:${line}:${col} - ${diagnostic.message} [${diagnostic.code}]`);
            });
        }

        if (errors.length > 0) {
            console.log('\n❌ Build completed with errors:');
            errors.forEach(diagnostic => {
                const filePath = diagnostic.file?.pathAbsolute || 'unknown';
                const line = diagnostic.range.start.line + 1;
                const col = diagnostic.range.start.character + 1;
                console.log(`  ${filePath}:${line}:${col} - ${diagnostic.message} [${diagnostic.code}]`);
            });
            process.exit(1);
        } else {
            console.log('\n✅ Build completed successfully!');
            console.log('📁 Output directory: dist/');
            if (warnings.length > 0) {
                console.log(`⚠️  ${warnings.length} warning(s) found`);
            }
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
