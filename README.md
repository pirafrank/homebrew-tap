# 🍺 pirafrank's Homebrew Tap

[![Update Formula](https://github.com/pirafrank/homebrew-tap/actions/workflows/generate.yml/badge.svg?branch=main)](https://github.com/pirafrank/homebrew-tap/actions/workflows/generate.yml)

Homebrew tap of my CLI tools.

## Available Tools

- [vault-conductor](https://github.com/pirafrank/vault-conductor) - An SSH Agent that provides SSH keys stored in Bitwarden Secret Manager
- [poof](https://github.com/pirafrank/poof) - Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command. No manifests, formulae, ports, or repositories required
- [exif_renamer](https://github.com/pirafrank/rust_exif_renamer) - Fast, parallel tool to rename photos in a given directory to their EXIF DateTimeOriginal or viceversa

## Install

How to get software provided by this tap.

### 1. Install Tap

```bash
brew tap pirafrank/tap
```

### 2. Get Packages

```bash
brew install pirafrank/tap/<FORMULA_NAME>
```

## Automation

This tap uses an automated system to keep formulas updated with the latest GitHub releases.

### Components

**Python Script** (`scripts/update_formula.py`)

- Fetches the latest release from GitHub for a given project in one API call
- Extracts SHA256 checksums directly from release asset digests
- Renders Homebrew formula files using Jinja2 templates
- Supports placeholder variables: `{NAME}` (project name) and `{VERSION}` (release version)

**GitHub Workflow** (`.github/workflows/generate.yml`)

- Automatically updates formulas when triggered
- Can be invoked via `workflow_dispatch` (manual) or `repository_dispatch` (webhook)
- Creates and commits updated formula files with signed commits
- Runs on Ubuntu 24.04 with Python 3.11

### Directory Structure

```txt
configurations/     # YAML config files (e.g., poof.yaml)
templates/          # Jinja2 templates (e.g., pirafrank@poof.rb.jinja)
Formula/            # Generated Homebrew formulas (e.g., poof.rb)
```

### Configuration Requirements

Each project requires:

1. A YAML configuration file in `configurations/{name}.yaml` with:
   - `github_repo`: Repository path (e.g., "pirafrank/poof")
   - `template_path`: Path to Jinja2 template
   - `output_path`: Path to output formula file
   - `asset_patterns`: Dictionary of assets to fetch (supports placeholders)
2. A Jinja2 template in the `templates/` directory
3. Matching filenames across `configurations/` and `Formula/` directories

### Usage

**Local execution:**

```bash
python scripts/update_formula.py <project_name>
```

**GitHub Actions:**

- Manual: Run workflow from Actions tab with project name
- Webhook: Send `repository_dispatch` event with `project_name` in payload

Changes are automatically committed using [github-commit-sign](https://github.com/marketplace/actions/github-commit-sign) action.
