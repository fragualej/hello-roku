# Roku Animation App

## Project Structure

```
.
├── src/           # Source code
│   ├── components/
│   ├── images/
│   ├── manifest
│   └── source/
├── build/         # Build artifacts
└── tools/         # Build scripts and utilities
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

### Create a build (compiles to `build/out/`)
```bash
cd tools
npm run build
```

### Create a deployment package (creates `build/roku-app.zip`)
```bash
cd tools
npm run package
```

## Deploy to Roku Device

1. Build the package:
```bash
cd tools
npm run package
```

2. Access the Roku Developer Installer:
   - Open browser to `http://<ROKU_IP>`
   - Login with your developer password

3. Upload and install:
   - Click "Browse" and select `build/roku-app.zip`
   - Click "Install"
   - Your app will be installed on channel 1

Alternatively, you can sideload via curl:
```bash
source ../.env
curl -F "mysubmit=Install" \
     -F "archive=@../build/roku-app.zip" \
     -u rokudev:$ROKU_PASSWORD \
     http://$ROKU_IP/plugin_install
```
