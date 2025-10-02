#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const { execSync } = require('child_process');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../..', '.env') });

async function signPackage() {
    const ROKU_IP = process.env.ROKU_IP;
    const ROKU_PASSWORD = process.env.ROKU_PASSWORD;
    const ROKU_SIGNING_PASSWORD = process.env.ROKU_SIGNING_PASSWORD;
    const rootDir = path.join(__dirname, '../..');
    const configPath = path.join(__dirname, '../bsconfig.json');

    // Validate environment variables
    if (!ROKU_IP) {
        console.error('❌ Error: ROKU_IP not set in .env file');
        process.exit(1);
    }
    if (!ROKU_PASSWORD) {
        console.error('❌ Error: ROKU_PASSWORD not set in .env file');
        process.exit(1);
    }
    if (!ROKU_SIGNING_PASSWORD) {
        console.error('❌ Error: ROKU_SIGNING_PASSWORD not set in .env file');
        process.exit(1);
    }

    // Get git hash for signed package name
    let gitHash = 'nogit';
    try {
        gitHash = execSync('git rev-parse --short HEAD', { cwd: rootDir }).toString().trim();
    } catch (error) {
        console.warn('⚠️  Warning: Could not get git hash');
    }

    // Get timestamp
    const now = new Date();
    const timestamp = now.getFullYear() +
        String(now.getMonth() + 1).padStart(2, '0') +
        String(now.getDate()).padStart(2, '0') + '_' +
        String(now.getHours()).padStart(2, '0') +
        String(now.getMinutes()).padStart(2, '0') +
        String(now.getSeconds()).padStart(2, '0');

    const signedPackageName = `${timestamp}_${gitHash}_signed.pkg`;
    const signedPackagePath = path.join(rootDir, 'build', signedPackageName);

    console.log(`🔐 Creating signed package...`);

    const builder = new ProgramBuilder();

    try {
        // Compile and create signed package
        await builder.run({
            project: configPath,
            createPackage: true,
            outFile: signedPackagePath,
            // roku-deploy options for signing
            host: ROKU_IP,
            password: ROKU_PASSWORD,
            signingPassword: ROKU_SIGNING_PASSWORD,
            signPackage: true
        });

        if (builder.program.getDiagnostics().length > 0) {
            console.log('\n❌ Signing completed with errors:');
            builder.program.getDiagnostics().forEach(diagnostic => {
                console.log(`  ${diagnostic.file?.pathAbsolute || 'unknown'}:${diagnostic.range.start.line + 1} - ${diagnostic.message}`);
            });
            process.exit(1);
        } else {
            console.log('✅ Signed package created successfully!');
            console.log(`Package: ${signedPackageName}`);
            console.log(`Path: ${signedPackagePath}`);
        }
    } catch (error) {
        console.error('❌ Signing failed:', error.message);
        process.exit(1);
    }
}

signPackage().catch(err => {
    console.error('Signing failed:', err);
    process.exit(1);
});
