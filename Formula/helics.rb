class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS"
  url "https://github.com/GMLC-TDC/HELICS/archive/v2.0.0.tar.gz"
  sha256 "aa1a7be9032d1e7ad886bced08b4e0e8d3ffaf13fa21d1239e91c47e8a9dd677"
  head "https://github.com/GMLC-TDC/HELICS.git", :branch => "develop"

  bottle do
    cellar :any
  end

  option 'with-python', 'Compile Python extension'
  option "with-gcc", "Force compiling with gcc"

  depends_on "cmake" => :build
  depends_on 'swig' => :build if build.include? 'with-python'
  depends_on 'python' if build.include? 'with-python'

  if build.with?("gcc")
      depends_on "gcc" => :build
  end

  depends_on "boost"
  depends_on "zeromq"

  def install

    mkdir "build" do
      args = std_cmake_args

      if build.with?('python')
        args << "-DBUILD_PYTHON_INTERFACE=ON"
      end

      system "cmake", "..", *args
      system "make", "-j8", "install"
    end
  end

  test do
    system "false"
  end
end



