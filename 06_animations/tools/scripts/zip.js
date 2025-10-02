#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

async function packageApp() {
    const rootDir = path.join(__dirname, '../..');
    const configPath = path.join(__dirname, '../bsconfig.json');

    // Get git hash (short version)
    let gitHash = 'nogit';
    try {
        gitHash = execSync('git rev-parse --short HEAD', { cwd: rootDir }).toString().trim();
    } catch (error) {
        console.warn('⚠️  Warning: Could not get git hash');
    }

    // Get timestamp in format: YYYYMMDD_HHMMSS
    const now = new Date();
    const timestamp = now.getFullYear() +
        String(now.getMonth() + 1).padStart(2, '0') +
        String(now.getDate()).padStart(2, '0') + '_' +
        String(now.getHours()).padStart(2, '0') +
        String(now.getMinutes()).padStart(2, '0') +
        String(now.getSeconds()).padStart(2, '0');

    const packageName = `${timestamp}_${gitHash}.zip`;
    const packagePath = path.join(rootDir, 'build', packageName);

    // Create build directory if it doesn't exist
    const buildDir = path.join(rootDir, 'build');
    if (!fs.existsSync(buildDir)) {
        fs.mkdirSync(buildDir, { recursive: true });
    }

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
        console.log(`Package: ${packageName}`);
        console.log(`Path: ${packagePath}`);
    }
}

packageApp().catch(err => {
    console.error('Package build failed:', err);
    process.exit(1);
});
