class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.6.3"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.3/poof-0.6.3-x86_64-apple-darwin.tar.gz"
      sha256 "3330bd8b05845ff74ad43aba288e8b2990ca26de6cafccc2dc9e40e79d78e0d9"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.3/poof-0.6.3-aarch64-apple-darwin.tar.gz"
      sha256 "3a647de3fcb441720d8af8d83ccf1f189209d9108b74d44f96dc48f4baf91c3d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.3/poof-0.6.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b9a3f4071b2a645bbe2f46555d712a34f53af37ca718888629b9b4b00f14547"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.3/poof-0.6.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0bd20021196e0fabe048ba9c302a8bb528184f3cb60475dfd5274b270c5d3e5"
    end
  end

  def install
    # This assumes your tarball extracts directly to a binary named "poof"
    # If it's inside a folder, you might need to adjust the path, e.g. bin.install "folder/poof"
    bin.install "poof"
  end

  test do
    system "#{bin}/poof", "--version"
  end
end