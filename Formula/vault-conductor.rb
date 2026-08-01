class VaultConductor < Formula
  desc "An SSH Agent that provides SSH keys stored in Bitwarden Secret Manager."
  homepage "https://github.com/pirafrank/vault-conductor"
  license "MIT"
  version "0.3.1"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.1/vault-conductor-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "0dd75d5c298dfc5e9e9ee8ac5899d8acc9784875bf7555367458bbc32fa4967e"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.1/vault-conductor-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "c8d534826d54d425f2632a3cbce0c23de399d06ab1ee88c111e37cc2272bf63f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.1/vault-conductor-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "026a376d625a3539ec7d5820b6a2d43911498dc4bf538cba185e75bbe2073a2d"
    end
    on_arm do
      url "https://github.com/pirafrank/vault-conductor/releases/download/v0.3.1/vault-conductor-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06e1aa2e87a3cd611de1fad0017410b0cc3bc815ef947c05fb2bfb2b67e60b30"
    end
  end

  def install
    # This assumes your tarball extracts directly to a binary named "vault-conductor"
    # If it's inside a folder, you might need to adjust the path, e.g. bin.install "folder/vault-conductor"
    bin.install "vault-conductor"
  end

  test do
    system "#{bin}/vault-conductor", "--version"
  end
end