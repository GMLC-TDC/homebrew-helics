class Helics < Formula
  desc "Hierarchical Engine for Large-scale Infrastructure Co-Simulation (HELICS)"
  homepage "https://github.com/GMLC-TDC/HELICS-src"
  url "https://github.com/GMLC-TDC/HELICS-src/archive/v1.0.0a.tar.gz"
  sha256 "df5a833a7cc12caf81ef894c67443bb7db34c9f069a6de16e3bc8b343865971f"
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
        args << "-DBUILD_PYTHON=ON"
        args << "-DPYTHON_INCLUDE_DIR='#{python_include_dir}'"
      end

      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end



