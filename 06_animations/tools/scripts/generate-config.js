#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../..', '.env') });

function generateConfig() {
    const TMDB_API_KEY = process.env.TMDB_API_KEY || '';
    const TMDB_TOKEN = process.env.TMDB_TOKEN || '';

    if (!TMDB_API_KEY) {
        console.warn('⚠️  Warning: TMDB_API_KEY not set in .env file');
    }
    if (!TMDB_TOKEN) {
        console.warn('⚠️  Warning: TMDB_TOKEN not set in .env file');
    }

    const config = {
        api: {
            baseUrl: "https://api.themoviedb.org/3",
            endpoint: "https://api.themoviedb.org/3/trending/movie/week?api_key=",
            imageUrl: "https://image.tmdb.org/t/p/w500",
            key: TMDB_API_KEY,
            token: TMDB_TOKEN,
        }
    };

    const srcConfigDir = path.join(__dirname, '../../src/config');

    // Ensure config directory exists in src
    if (!fs.existsSync(srcConfigDir)) {
        fs.mkdirSync(srcConfigDir, { recursive: true });
    }

    const outputPath = path.join(srcConfigDir, 'config.json');
    fs.writeFileSync(outputPath, JSON.stringify(config, null, 4));

    console.log('✅ Generated config/config.json with API keys from .env');
}

generateConfig();
