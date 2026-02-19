#!/usr/bin/env python3
"""
Update Homebrew formula from GitHub releases.

This script fetches the latest release from GitHub and extracts asset
SHA256 checksums directly from the API response, then renders the
Homebrew formula template.
"""

import argparse
import sys
from pathlib import Path
from typing import Dict, Optional

import requests
import yaml
from minijinja import Environment


def load_config(name: str, script_dir: Path) -> Dict:
    """Load configuration from YAML file.

    Args:
        name: Project name (e.g., 'poof')
        script_dir: Directory where the script is located

    Returns:
        Configuration dictionary with required keys

    Raises:
        SystemExit: If configuration file not found or invalid

    Note:
        Asset patterns support placeholders:
        - {NAME}: Replaced with project name from github_repo (e.g., "poof")
        - {VERSION}: Replaced with release version (e.g., "0.5.2")

        Example: "{NAME}-{VERSION}-x86_64.tar.gz" -> "poof-0.5.2-x86_64.tar.gz"
    """
    config_path = script_dir / "../configurations" / f"{name}.yaml"
    config_path = config_path.resolve()

    if not config_path.exists():
        print(f"Error: Configuration file not found at {config_path}", file=sys.stderr)
        print(f"Expected: configurations/{name}.yaml", file=sys.stderr)
        sys.exit(1)

    try:
        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML configuration: {e}", file=sys.stderr)
        sys.exit(1)

    # Validate required keys
    required_keys = ['github_repo', 'template_path', 'output_path', 'asset_patterns']
    missing_keys = [key for key in required_keys if key not in config]

    if missing_keys:
        print(f"Error: Missing required keys in configuration: {', '.join(missing_keys)}", file=sys.stderr)
        sys.exit(1)

    # Validate asset_patterns is not empty
    if not config['asset_patterns'] or not isinstance(config['asset_patterns'], dict):
        print("Error: 'asset_patterns' must be a non-empty dictionary", file=sys.stderr)
        sys.exit(1)

    print(f"Loaded configuration from {config_path}")
    return config


def fetch_latest_release(github_repo: str) -> Dict:
    """Fetch the latest release information from GitHub API."""
    url = f"https://api.github.com/repos/{github_repo}/releases/latest"
    print(f"Fetching latest release from {url}...")

    try:
        response = requests.get(url, timeout=30)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching release: {e}", file=sys.stderr)
        sys.exit(1)


def find_asset(assets: list, pattern: str) -> Optional[Dict]:
    """Find an asset by filename pattern."""
    for asset in assets:
        if asset["name"] == pattern:
            return asset
    return None


def extract_version(tag_name: str) -> str:
    """Extract version from tag name (removes 'v' prefix if present)."""
    return tag_name.lstrip("v")


def extract_sha256_from_digest(digest: str) -> str:
    """Extract SHA256 hash from GitHub digest field.

    Args:
        digest: Digest string in format "sha256:hash"

    Returns:
        The SHA256 hash string

    Raises:
        SystemExit: If digest format is invalid
    """
    if not digest or not digest.startswith("sha256:"):
        print(f"Error: Invalid digest format: {digest}", file=sys.stderr)
        sys.exit(1)

    return digest.split(":", 1)[1]


def main():
    """Main function to update the Homebrew formula."""
    # Parse command-line arguments
    parser = argparse.ArgumentParser(
        description="Update Homebrew formula from GitHub releases"
    )
    parser.add_argument(
        "name",
        help="Project name (looks for configurations/{name}.yaml)"
    )
    args = parser.parse_args()

    # Get script directory to resolve paths
    script_dir = Path(__file__).parent.resolve()

    # Load configuration
    config = load_config(args.name, script_dir)

    template_path = script_dir / "../" / config['template_path']
    output_path = script_dir / "../" / config['output_path']
    template_path = template_path.resolve()
    output_path = output_path.resolve()

    # Validate template exists
    if not template_path.exists():
        print(f"Error: Template not found at {template_path}", file=sys.stderr)
        sys.exit(1)

    # Fetch latest release
    release = fetch_latest_release(config['github_repo'])
    tag_name = release["tag_name"]
    version = extract_version(tag_name)
    assets = release["assets"]

    print(f"Latest release: {tag_name} (version: {version})")
    print(f"Found {len(assets)} assets")

    # Replace placeholders in asset patterns
    # Extract project name from github_repo (e.g., "pirafrank/poof" -> "poof")
    project_name = config['github_repo'].split('/')[-1]

    resolved_patterns = {}
    for key, pattern in config['asset_patterns'].items():
        resolved_pattern = pattern.replace('{NAME}', project_name).replace('{VERSION}', version)
        resolved_patterns[key] = resolved_pattern
        if pattern != resolved_pattern:
            print(f"Resolved pattern '{pattern}' -> '{resolved_pattern}'")

    # Find all required assets and extract checksums
    template_vars = {"version": version}

    for key, pattern in resolved_patterns.items():
        asset = find_asset(assets, pattern)
        if not asset:
            print(f"Error: Required asset '{pattern}' not found in release", file=sys.stderr)
            sys.exit(1)

        # Extract SHA256 from digest field
        digest = asset.get("digest")
        if not digest:
            print(f"Error: No digest found for asset '{pattern}'", file=sys.stderr)
            print(f"Asset data: {asset.get('name')}", file=sys.stderr)
            sys.exit(1)

        # Parse digest (format: "sha256:hash")
        sha256 = extract_sha256_from_digest(digest)

        template_vars[f"{key}_url"] = asset["browser_download_url"]
        template_vars[f"{key}_sha256"] = sha256
        print(f"Found asset: {asset['name']} (sha256: {sha256[:16]}...)")

    # Load and render template
    print(f"\nRendering template from {template_path}...")
    env = Environment()
    template_content = template_path.read_text()
    rendered = env.render_str(template_content, **template_vars)

    # Write output
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(rendered)
    print(f"Successfully updated {output_path}")
    print(f"\nFormula updated to version {version}")


if __name__ == "__main__":
    main()
