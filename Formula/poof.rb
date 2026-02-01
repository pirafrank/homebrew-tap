class Poof < Formula
  desc "Magic manager of pre-built software. Install and manage awesome tools from GitHub Releases in one command."
  homepage "https://github.com/pirafrank/poof"
  license "MIT"
  version "0.5.2"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.5.2/poof-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "4e9c5de311168899d5030e5b62c69408ed58687f9455b1e00c289c9c31cb8306"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.5.2/poof-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "5d69ca8573461f430db0f3879b313073540d2bf984f88abecd37b6107597ea2b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/poof/releases/download/v0.5.2/poof-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2d0ead715873506121726a021d5d09429c6f28b7879e999789cf04fce93d6e4"
    end
    on_arm do
      url "https://github.com/pirafrank/poof/releases/download/v0.5.2/poof-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "798a9138fc90c037c63b0bdb47a1fad8ed8e12bde81dccc2198ee1b8cb2e8e9c"
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
