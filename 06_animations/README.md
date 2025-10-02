# Roku Animation App

## Project Structure

```
.
├── src/              # Source code
│   ├── components/
│   ├── images/
│   ├── manifest
│   └── source/
├── dist/             # Compiled output (unzipped)
├── build/            # Deployment packages (YYYYMMDD_HHMMSS_hash.zip)
├── out/              # Temporary deployment artifacts
├── scripts/          # Build scripts
├── bsconfig.json     # BrighterScript configuration
├── bslint.json       # Linting rules
└── package.json      # Project dependencies and scripts
```

## Setup

1. Install dependencies:
```bash
npm install
```

2. Configure your Roku device:
```bash
cp .env.example .env
```

Edit `.env` and add your Roku device IP and developer password:
- **ROKU_IP**: Find your Roku's IP in Settings > Network > About
- **ROKU_PASSWORD**: Set in Settings > System > Advanced system settings > Developer mode
- **ROKU_SIGNING_PASSWORD** (optional): For signed packages - generate key via `http://<ROKU_IP>` > Utilities > Genkey

## Build Commands

### `npm run build`
Compiles source code to `dist/` directory without deploying
- Transpiles BrighterScript to BrightScript
- Updates `dist/` with compiled output
- Used automatically by VSCode debug configuration
```bash
npm run build
```

### `npm run zip`
Creates deployment package with format: `build/YYYYMMDD_HHMMSS_hash.zip`
- Includes timestamp (YYYYMMDD_HHMMSS) for precise chronological sorting
- Includes git commit hash for version tracking
- Updates `dist/` with compiled output
```bash
npm run zip
```

### `npm run sign`
Creates signed package for Roku Channel Store submission: `build/YYYYMMDD_HHMMSS_hash_signed.pkg`
- Requires `ROKU_SIGNING_PASSWORD` in `.env`
- Uses device's signing key to create production-ready package
```bash
npm run sign
```

### `npm run deploy`
Compiles and deploys directly to Roku device (requires `.env` configuration)
- Automatically compiles source and updates `dist/`
- Uploads to Roku via network
- Creates temporary package in `out/`
```bash
npm run deploy
```

## Development Workflows

### VSCode Debugging (Recommended for Development)
The project includes VSCode configuration for debugging with breakpoints and logs:

1. Open project in VSCode
2. Press `F5` or Run → Start Debugging
3. Select "BrightScript Debug" configuration
4. Automatic workflow:
   - Runs `npm run build` (compiles to `dist/`)
   - Deploys to Roku device
   - Attaches debugger with breakpoints support

**VSCode Configuration** (`.vscode/` directory):
- `launch.json` - Debug configurations using env variables from `.env`
- `tasks.json` - Pre-launch build task

**Requirements:**
- [BrightScript Language](https://marketplace.visualstudio.com/items?itemName=RokuCommunity.brightscript) extension installed
- `.env` file configured with `ROKU_IP` and `ROKU_PASSWORD`

### Command Line Workflows

#### Development (Quick Deploy)
```bash
npm run deploy  # Compile + upload in one step
```

#### QA/Testing (Versioned Package)
```bash
npm run zip  # Creates build/YYYYMMDD_HHMMSS_hash.zip
```
Then upload via browser at `http://<ROKU_IP>`

#### Production (Signed Package for Channel Store)
```bash
npm run sign  # Creates build/YYYYMMDD_HHMMSS_hash_signed.pkg
```
Upload the `.pkg` file to Roku Channel Store for publication
