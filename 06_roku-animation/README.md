# Roku Animation App

## Project Structure

```
.
├── src/           # Source code
│   ├── components/
│   ├── images/
│   ├── manifest
│   └── source/
├── dist/          # Compiled output (unzipped)
├── build/         # Deployment packages (YYYYMMDD_HHMMSS_hash.zip)
├── out/           # Temporary deployment artifacts
└── tools/         # Build scripts and utilities
    ├── scripts/
    ├── bsconfig.json
    └── package.json
```

## Setup

1. Install dependencies:
```bash
cd tools
npm install
```

2. Configure your Roku device:
```bash
cp .env.example .env
```

Edit `.env` and add your Roku device IP and developer password:
- **ROKU_IP**: Find your Roku's IP in Settings > Network > About
- **ROKU_PASSWORD**: Set in Settings > System > Advanced system settings > Developer mode

## Build Commands

### `npm run zip`
Creates deployment package with format: `build/YYYYMMDD_HHMMSS_hash.zip`
- Includes timestamp (YYYYMMDD_HHMMSS) for precise chronological sorting
- Includes git commit hash for version tracking
- Updates `dist/` with compiled output
```bash
cd tools
npm run zip
```

### `npm run deploy`
Compiles and deploys directly to Roku device (requires `.env` configuration)
- Automatically compiles source and updates `dist/`
- Uploads to Roku via network
- Creates temporary package in `out/`
```bash
cd tools
npm run deploy
```

## Deployment

### Quick Deploy (Development)
```bash
cd tools
npm run deploy  # Compile + upload in one step
```

### Manual Deploy (Production/QA)
1. Create versioned package:
```bash
cd tools
npm run zip  # Creates build/YYYYMMDD_HHMMSS_hash.zip
```

2. Upload via browser:
   - Open `http://<ROKU_IP>`
   - Login with developer password
   - Upload the zip file from `build/`
   - Click "Install"
