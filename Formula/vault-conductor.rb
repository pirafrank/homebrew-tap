class VaultConductor < Formula
  desc "An SSH Agent that provides SSH keys stored in Bitwarden Secret Manager."
  homepage "https://github.com/pirafrank/vault-conductor"
  license "MIT"
  version "0.3.0"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.0/vault-conductor-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "3b62ef38469f13287c0ca07ff85c767004ea6064cd847c00f83034bc8af76551"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.0/vault-conductor-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "40179e38f110bba588d5ee198e3d5a1a6c4ba09ad0a8d33309851103c6cb0fc1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.0/vault-conductor-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cea7b7d13f8d53d1c834751184c4c7e16499f0b64b7a887352055ca21c51a2ae"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.0/vault-conductor-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1b7f368911847da089c165359a5e1df5a486bfb2c4893c6023d5a6ae803b1b22"
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