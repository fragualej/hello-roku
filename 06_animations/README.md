# Roku Animation App

A Roku channel application demonstrating animation techniques with BrighterScript.

## Project Structure

```
.
├── src/              # Source code
│   ├── components/   # SceneGraph XML components
│   ├── images/       # Image assets
│   ├── manifest      # App manifest
│   └── source/       # BrighterScript/BrightScript code
├── dist/             # Compiled output (gitignored)
├── build/            # Deployment packages (gitignored)
├── out/              # Temporary deployment artifacts (gitignored)
├── scripts/          # Build and deployment scripts
├── .vscode/          # VSCode debug configuration
├── bsconfig.json     # BrighterScript compiler configuration
├── bslint.json       # Code linting rules
└── package.json      # Project dependencies and scripts
```

## Prerequisites

- Node.js (v14 or higher)
- Roku device with Developer Mode enabled
- VSCode with [BrightScript Language](https://marketplace.visualstudio.com/items?itemName=RokuCommunity.brightscript) extension (recommended)

## Setup

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Environment

Create a `.env` file in the project root:

```bash
cp .env.example .env
```

Edit `.env` with your configuration:

```env
ROKU_IP=192.168.x.x
ROKU_PASSWORD=your_dev_password
ROKU_SIGNING_PASSWORD=your_signing_password
TMDB_API_KEY=your_tmdb_api_key
TMDB_API_TOKEN=your_tmdb_token
```

**Where to find these values:**

- **ROKU_IP**: Settings > Network > About on your Roku device
- **ROKU_PASSWORD**: Settings > System > Advanced system settings > Developer mode
- **ROKU_SIGNING_PASSWORD** (optional): Generate via `http://<ROKU_IP>` > Utilities > Genkey
- **TMDB_API_KEY** & **TMDB_API_TOKEN**: Get from [themoviedb.org](https://www.themoviedb.org/settings/api)

## Development

### VSCode Debugging (Recommended)

The easiest way to develop and test:

1. Open the project in VSCode
2. Press **F5** or select **Run > Start Debugging**
3. The app will automatically:
   - Build the project (`npm run build`)
   - Deploy to your Roku device
   - Attach the debugger for breakpoints and logging

**Requirements:**
- VSCode with [BrightScript Language extension](https://marketplace.visualstudio.com/items?itemName=RokuCommunity.brightscript)
- `.env` file configured with `ROKU_IP` and `ROKU_PASSWORD`

### Build Commands

All commands run from the project root:

#### `npm run build`
Compiles source code to `dist/` directory without deploying.

```bash
npm run build
```

- Transpiles BrighterScript to BrightScript
- Generates `config.json` from `.env`
- Outputs to `dist/`
- Used automatically by VSCode F5 debug

#### `npm run deploy`
Compiles and deploys directly to Roku device.

```bash
npm run deploy
```

- Compiles source code
- Creates temporary package in `out/`
- Uploads to Roku via network
- Fastest way to test changes from command line

#### `npm run zip`
Creates versioned deployment package for distribution.

```bash
npm run zip
```

- Compiles source code
- Creates package: `build/YYYYMMDD_HHMMSS_hash.zip`
- Timestamp format for chronological sorting
- Git hash for version tracking
- Upload manually at `http://<ROKU_IP>`

#### `npm run sign`
Creates signed package for Roku Channel Store submission.

```bash
npm run sign
```

- Requires `ROKU_SIGNING_PASSWORD` in `.env`
- Creates: `build/YYYYMMDD_HHMMSS_hash_signed.pkg`
- Uses device signing key for production-ready package
- Upload `.pkg` file to Roku Channel Store

## Workflows

### Quick Development Loop
```bash
# Option 1: VSCode (with debugging)
Press F5

# Option 2: Command line (fastest)
npm run deploy
```

### Creating Release Packages
```bash
# For testing/QA
npm run zip

# For production/channel store
npm run sign
```

## Project Configuration

The project includes pre-configured settings for immediate development:

- **`bsconfig.json`** - BrighterScript compiler (compiles `src/` → `dist/`)
- **`bslint.json`** - Code linting rules
- **`.vscode/`** - VSCode debug configuration (F5 to deploy & debug)
- **`.env`** - Environment variables (create from `.env.example`)

All configurations are ready to use - just clone, install dependencies, configure `.env`, and press F5!
