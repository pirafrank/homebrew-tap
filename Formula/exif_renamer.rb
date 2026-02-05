class ExifRenamer < Formula
  desc "Fast, parallel tool to rename photos in a given directory to their EXIF DateTimeOriginal or viceversa."
  homepage "https://github.com/pirafrank/rust_exif_renamer"
  license "MIT"
  version "0.2.3"

  on_macos do
    on_intel do
      url "https://github.com/pirafrank/rust_exif_renamer/releases/download/v0.2.3/exif_renamer-0.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "ab4c79fb0d4e42d1187eae187a90ef88651a93c0efc2811a7987da2eded78baf"
    end
    on_arm do
      url "https://github.com/pirafrank/rust_exif_renamer/releases/download/v0.2.3/exif_renamer-0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "7f0ef1da75754db93247257340aa176cfa1473b47aa88507c7f3ab45d132d3d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/pirafrank/rust_exif_renamer/releases/download/v0.2.3/exif_renamer-0.2.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a798c13efb0116480654da86221eba94a272ff8d55c19525d0f3b920e0b34cc"
    end
    on_arm do
      url "https://github.com/pirafrank/rust_exif_renamer/releases/download/v0.2.3/exif_renamer-0.2.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8fad8e2627369bf4c813c96c9df1a97f493bbf40dd580ee41b2e83b58ea258f6"
    end
  end

  def install
    # This assumes your tarball extracts directly to a binary named "exif_renamer"
    # If it's inside a folder, you might need to adjust the path, e.g. bin.install "folder/exif_renamer"
    bin.install "exif_renamer"
  end

  def post_install
    # Ensure the binary is executable
    chmod 0755, "#{bin}/exif_renamer"
  end

  test do
    system "#{bin}/exif_renamer", "--version"
  end
end