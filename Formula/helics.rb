class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS"
  url "https://github.com/GMLC-TDC/HELICS.git", :using => :git, :tag => "v2.1.1"
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

      system "cmake", "..", *args, "-DBUILD_HELICS_TESTS=OFF"
      system "make", "-j8", "install"
    end
  end

  test do
    system "false"
  end
end



