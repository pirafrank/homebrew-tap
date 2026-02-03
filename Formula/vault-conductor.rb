class VaultConductor < Formula
  desc "An SSH Agent that provides SSH keys stored in Bitwarden Secret Manager."
  homepage "https://github.com/pirafrank/vault-conductor"
  license "MIT"
  version "0.2.1"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.2.1/vault-conductor-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "8640599789486258551491cbc2a3b6ab316be868166b69fde242ec5beddfab48"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.2.1/vault-conductor-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "0dc4c75689d075dec819f80d448e82b1dd8ea78236e785811596c259c61b0e60"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.2.1/vault-conductor-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d4a17737d67498903dd195ed302c3ce2f8176771f7be05c9ad885255a8d5e45c"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.2.1/vault-conductor-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0ac7394c6f6c8a17ec27d0622e321aa7c57988e15e8711198a54fdc5049310d"
    end
  end

  def install
    # This assumes your tarball extracts directly to a binary named "vault-conductor"
    # If it's inside a folder, you might need to adjust the path, e.g. bin.install "folder/vault-conductor"
    bin.install "vault-conductor"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, "#{bin}/vault-conductor"
  end

  test do
    system "#{bin}/vault-conductor", "--version"
  end
end