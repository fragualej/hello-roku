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
├── build/         # Deployment package (roku-app.zip)
└── tools/         # Build scripts and utilities
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

### Compile source code (outputs to `dist/`)
```bash
cd tools
npm run build
```

### Create deployment package (creates `build/roku-app.zip`)
```bash
cd tools
npm run zip
```

### Deploy to Roku device (automatic upload)
```bash
cd tools
npm run deploy
```

## Deploy to Roku Device

### Automatic Deployment
```bash
cd tools
npm run zip     # Create the package
npm run deploy  # Upload to Roku
```

### Manual Deployment

1. Create the package:
```bash
cd tools
npm run zip
```

2. Access the Roku Developer Installer:
   - Open browser to `http://<ROKU_IP>`
   - Login with your developer password

3. Upload and install:
   - Click "Browse" and select `build/roku-app.zip`
   - Click "Install"
   - Your app will be installed on channel 1
