class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS-src"
  url "https://github.com/GMLC-TDC/HELICS-src/archive/v1.0.0a.tar.gz"
  sha256 "df5a833a7cc12caf81ef894c67443bb7db34c9f069a6de16e3bc8b343865971f"
  head "https://github.com/GMLC-TDC/HELICS-src.git", :branch => "develop"

  bottle do
    cellar :any
  end

  depends_on "python" => :optional
  depends_on "python3" => :optional

  depends_on "cmake" => :build
  depends on "swig" => :build if build.with?("python") || build.with?("python3")

  depends_on "boost"
  depends_on "zeromq"

  def install

    ENV.O0

    mkdir "build" do
      args = std_cmake_args

      if build.without?("python") && build.with?("python3")
        args << "-DBUILD_PYTHON=ON"
        pythonprefix = system "python-config", "--prefix"
        # pythonprefix = ARGV.value("with-python-prefix") || pythonprefix
        args << "-DPYTHON_LIBRARY=#{pythonprefix}/lib/libpython3.6m.dylib"
        args << "-DPYTHON_INCLUDE_DIR=#{pythonprefix}/include/python3.6m/"
      elsif build.with?("python") && build.without?("python3")
        args << "-DBUILD_PYTHON=ON"
        pythonprefix = system "python-config", "--prefix"
        # pythonprefix = ARGV.value("with-python-prefix") || pythonprefix
        args << "-DPYTHON_LIBRARY=#{pythonprefix}/lib/libpython2.7.dylib"
        args << "-DPYTHON_INCLUDE_DIR=#{pythonprefix}/include/python2.7"
      elsif build.with?("python") && build.with?("python3")
        odie "Options --with-python and --with-python3 are mutually exclusive."
      else
        args << "-DBUILD_PYTHON=ON"
      end
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end



