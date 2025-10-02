#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

async function build() {
    // Generate config.json from .env before building
    console.log('📝 Generating config from .env...');
    try {
        execSync('node scripts/generate-config.js', {
            cwd: path.join(__dirname, '..'),
            stdio: 'inherit'
        });
    } catch (error) {
        console.error('❌ Failed to generate config:', error.message);
        process.exit(1);
    }

    const configPath = path.join(__dirname, '../bsconfig.json');

    console.log('🔨 Building project...');

    const builder = new ProgramBuilder();

    try {
        // Only compile to dist/, no deployment
        await builder.run({
            project: configPath
        });

        const diagnostics = builder.getDiagnostics(); // This includes plugin diagnostics

        // Filter out LINT3013 and LINT3007 (code style) - treat as warnings
        const filteredDiagnostics = diagnostics.map(d => {
            const code = String(d.code);
            if (code === 'LINT3013' || code === 'LINT3007' || code === 'LINT3008') {
                return { ...d, severity: 2 }; // Convert to warning
            }
            return d;
        });

        const errors = filteredDiagnostics.filter(d => d.severity === 1); // 1 = Error
        const warnings = filteredDiagnostics.filter(d => d.severity === 2); // 2 = Warning

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
            // Copy config.json to dist after build
            const srcConfigPath = path.join(__dirname, '../../src/source/config/config.json');
            const distConfigDir = path.join(__dirname, '../../dist/source/config');
            const distConfigPath = path.join(distConfigDir, 'config.json');

            if (fs.existsSync(srcConfigPath)) {
                if (!fs.existsSync(distConfigDir)) {
                    fs.mkdirSync(distConfigDir, { recursive: true });
                }
                fs.copyFileSync(srcConfigPath, distConfigPath);
                console.log('📋 Copied config.json to dist/config/');
            }

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
