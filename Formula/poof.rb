class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.6.4"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.4/poof-0.6.4-x86_64-apple-darwin.tar.gz"
      sha256 "b259c443d83447a196c31496a5ca02df942f68525a952270e5f8704415d774fa"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.4/poof-0.6.4-aarch64-apple-darwin.tar.gz"
      sha256 "08bd8b05bd56b649d690eb4de10b5914dcc34f632eb3840778bf2cf6801531c9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.4/poof-0.6.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e0b22321ac25df2e8b74f464d0a35602ab8fc05a9b92d86691e9fe6aefc48bbf"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.4/poof-0.6.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1c35a1e9acbe92f6ad1b36775bd2f7f96c80ac5adc766b3700db1d420d9a5942"
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