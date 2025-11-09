class Libhydrogen < Formula
  desc "Lightweight, secure, easy-to-use cryptographic library"
  homepage "https://libhydrogen.org/"
  url "https://github.com/jedisct1/libhydrogen.git",
    revision: "89c7957cffed5adcaed1ff3cee7c105f8fe52a16"
  version "0+20251020"
  license "ISC"
  head "https://github.com/jedisct1/libhydrogen.git", branch: "master"

  bottle do
    root_url "https://github.com/0f-0b/homebrew-tap/releases/download/libhydrogen-0+20251020"
    sha256 cellar: :any,                 arm64_tahoe:  "f0d6ec82168422d732eb1a7265a625d274e3fb39fc05502d4228c4c49d7a4741"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eaaf5f13d4eb28f50cb1521a8b3bc0e3f07e15bacba3fbecde351266fae49c5c"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", "-Ddefault_library=both", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath / "test.c").write <<~C
      #include <assert.h>
      #include <hydrogen.h>

      int main() {
        assert(hydro_init() == 0);
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lhydrogen", "-o", "test"
    system "./test"
  end
end
