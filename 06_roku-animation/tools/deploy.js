#!/usr/bin/env node

const { ProgramBuilder } = require('brighterscript');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

async function deploy() {
    const ROKU_IP = process.env.ROKU_IP;
    const ROKU_PASSWORD = process.env.ROKU_PASSWORD;
    const configPath = path.join(__dirname, 'bsconfig.json');

    // Validate environment variables
    if (!ROKU_IP) {
        console.error('❌ Error: ROKU_IP not set in .env file');
        process.exit(1);
    }
    if (!ROKU_PASSWORD) {
        console.error('❌ Error: ROKU_PASSWORD not set in .env file');
        process.exit(1);
    }

    console.log(`📦 Deploying to Roku device at ${ROKU_IP}...`);

    const builder = new ProgramBuilder();

    const rootDir = path.join(__dirname, '..');
    const outDir = path.join(rootDir, 'out');

    try {
        // BrighterScript will compile and deploy in one command
        await builder.run({
            project: configPath,
            deploy: true,
            host: ROKU_IP,
            password: ROKU_PASSWORD,
            outFile: path.join(outDir, 'package.zip')
        });

        if (builder.program.getDiagnostics().length > 0) {
            console.log('\n❌ Deployment completed with errors:');
            builder.program.getDiagnostics().forEach(diagnostic => {
                console.log(`  ${diagnostic.file?.pathAbsolute || 'unknown'}:${diagnostic.range.start.line + 1} - ${diagnostic.message}`);
            });
            process.exit(1);
        } else {
            console.log('✅ App deployed successfully!');
            console.log(`🚀 Access your app on the Roku device`);
        }
    } catch (error) {
        console.error('❌ Deployment failed:', error.message);
        process.exit(1);
    }
}

deploy().catch(err => {
    console.error('Deployment failed:', err);
    process.exit(1);
});
