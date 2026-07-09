class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.6.2"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.2/poof-0.6.2-x86_64-apple-darwin.tar.gz"
      sha256 "45cc9b768856428f4fecc123303de90dd6eec085f539fe618b2948dc2bd6032f"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.2/poof-0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "dda97c93492198b53e7e9bae5dbcc6cabc1b5cd235a65c16e1a5eb3213982c3c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.2/poof-0.6.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3410892ae4614764ea4ac66cde0ef9eec7db99800b8fa98de64c5799c817c0c3"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.2/poof-0.6.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2ca8db9c09fa50ee9446d6b0dfaf6df20cf3ff633586c5e359cc4b2a698d13f"
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