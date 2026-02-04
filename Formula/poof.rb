class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.6.0"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.0/poof-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "0dfbc184cd9c0d60ac9649b00e0deeca9b55754a19573a4c5015f0fc9a7212ed"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.0/poof-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "546ca6c6940d3120554d31a1c6cd6754f7f0ad5f0a338bba266abcb35bf89d89"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.0/poof-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11ba94a2a6e879f1b531efacb10f6519192a46b77cd01f81898d6793d76231a2"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.0/poof-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "813f0f4444e632782b7c36bcc7b2f3e69d7eb73dbfd191407ec3e44570f4dc97"
    end
  end

  def install
    # This assumes your tarball extracts directly to a binary named "poof"
    # If it's inside a folder, you might need to adjust the path, e.g. bin.install "folder/poof"
    bin.install "poof"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, "#{bin}/poof"
  end

  test do
    system "#{bin}/poof", "--version"
  end
end