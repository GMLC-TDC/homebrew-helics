class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS-src"
  url "https://github.com/GMLC-TDC/HELICS-src/archive/v1.3.1.tar.gz"
  sha256 "cbe1b3be948b1963cd5adafe5fd5948bf17d906ee671c41fa86f1311f92bd1c3"
  head "https://github.com/GMLC-TDC/HELICS-src.git", :branch => "develop"

  bottle do
    cellar :any
  end

  option 'with-python', 'Compile Python extension'

  depends_on "cmake" => :build
  depends_on 'swig' if build.include? 'with-python'

  depends_on "boost"
  depends_on "zeromq"

  def install

    ENV.O0

    mkdir "build" do
      args = std_cmake_args

      if build.include? 'with-python'
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



