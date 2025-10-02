#!/usr/bin/env node

const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

async function deploy() {
    const ROKU_IP = process.env.ROKU_IP;
    const ROKU_PASSWORD = process.env.ROKU_PASSWORD;
    const rootDir = path.join(__dirname, '..');
    const packagePath = path.join(rootDir, 'build', 'roku-app.zip');

    // Validate environment variables
    if (!ROKU_IP) {
        console.error('❌ Error: ROKU_IP not set in .env file');
        process.exit(1);
    }
    if (!ROKU_PASSWORD) {
        console.error('❌ Error: ROKU_PASSWORD not set in .env file');
        process.exit(1);
    }

    // Check if package exists
    if (!fs.existsSync(packagePath)) {
        console.error('❌ Error: Package not found. Run "npm run package" first.');
        process.exit(1);
    }

    console.log(`📦 Deploying to Roku device at ${ROKU_IP}...`);

    const command = `curl -s -S -F "mysubmit=Install" -F "archive=@${packagePath}" -u rokudev:${ROKU_PASSWORD} http://${ROKU_IP}/plugin_install`;

    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error('❌ Deployment failed:', error.message);
            process.exit(1);
        }
        if (stderr) {
            console.error('⚠️  Warning:', stderr);
        }

        if (stdout.includes('Install Success')) {
            console.log('✅ App deployed successfully!');
            console.log(`🚀 Access your app on the Roku device`);
        } else if (stdout.includes('Identical to previous version')) {
            console.log('✅ App deployed (identical to previous version)');
        } else {
            console.log('Response:', stdout);
        }
    });
}

deploy().catch(err => {
    console.error('Deployment failed:', err);
    process.exit(1);
});
