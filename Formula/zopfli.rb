class Zopfli < Formula
  desc "Very good but slow zlib-compatible compressor"
  homepage "https://github.com/google/zopfli"
  url "https://github.com/google/zopfli.git",
    revision: "ccf9f0588d4a4509cb1040310ec122243e670ee6"
  version "0+20240411"
  license "Apache-2.0"
  head "https://github.com/google/zopfli.git", branch: "master"

  bottle do
    root_url "https://github.com/0f-0b/homebrew-tap/releases/download/zopfli-0+20240411"
    sha256 cellar: :any,                 arm64_tahoe:  "999f926232054b750e1cdf395d695c80dbd1aa56aa43162191d48ba1fd2eedb9"
    sha256 cellar: :any,                 sequoia:      "7dcc45d8242b9cb73de6af14b3f2acac6aece6146260c10e326534c3221bb79e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1863a93332a66c95b6716f41337bc9a8a6abe767dc1ab0292380e1ccf340ffd9"
  end

  depends_on "cmake" => :build

  def install
    args = [
      "-DBUILD_SHARED_LIBS=ON",
      "-DCMAKE_INSTALL_RPATH=#{rpath}",
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
    ]
    system "cmake", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin / "zopfli"
    system bin / "zopflipng", test_fixtures("test.png"), "#{testpath}/out.png"
    assert_path_exists testpath / "out.png"
  end
end
