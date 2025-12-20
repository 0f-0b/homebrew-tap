class Zopfli < Formula
  desc "Very good but slow zlib-compatible compressor"
  homepage "https://github.com/google/zopfli"
  url "https://github.com/google/zopfli.git",
    revision: "ccf9f0588d4a4509cb1040310ec122243e670ee6"
  version "0+20240411"
  license "Apache-2.0"
  head "https://github.com/google/zopfli.git", branch: "master"

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
