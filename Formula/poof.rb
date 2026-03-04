class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.6.1"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.1/poof-0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "d34579d7e23ca0672cb9c2c9ff7a3c914abf9710a7595da500c57df09fb82002"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.1/poof-0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "13d32313c5de09c22bd58b11aa5ee6fe2c1c3b410da94ae5ba12f47f861a3756"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.1/poof-0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fb493fd43b56d7542085fc3d5c7f007e66723268f54e8537d6788354bc580ccc"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.6.1/poof-0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe434e7119b4e06526459442cf892a34a107d9d8aa50ace79372a0c17a02d338"
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