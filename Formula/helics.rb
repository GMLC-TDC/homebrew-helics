class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS-src"
  url "https://github.com/GMLC-TDC/HELICS-src/archive/v1.2.1.tar.gz"
  sha256 "6a2bfd9a43b63e83f561133d07a48172cb9077d2cf7769f8b52e8bb9a3da79ac"
  head "https://github.com/GMLC-TDC/HELICS-src.git", :branch => "develop"

  bottle do
    cellar :any
  end

  option 'with-python', 'Compile Python extension'
  option 'with-python-include-dir=', 'Path for Python include directory'

  depends_on "cmake" => :build
  depends_on 'swig' if build.include? 'with-python'

  depends_on "boost"
  depends_on "zeromq"

  def install

    ENV.O0

    mkdir "build" do
      args = std_cmake_args

      if build.include? 'with-python'
        python_include_dir = ARGV.value('with-python-include-dir')
        if python_include_dir.to_s.empty?
          odie "Option 'with-python' requires 'with-python-include-dir' to be passed as well. Try adding '--with-python-include-dir=$(python-config --prefix)/include/python2.7/' OR '--with-python-include-dir=$(python3-config --prefix)/include/python3.6m/'"
        end
        args << "-DBUILD_PYTHON_INTERFACE=ON"
        args << "-DPYTHON_INCLUDE_DIR='#{python_include_dir}'"
      end

      system "cmake", "..", *args
      system "make", "-j8", "install"
    end
  end

  test do
    system "false"
  end
end



