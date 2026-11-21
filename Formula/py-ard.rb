class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/61/8c/0c7356a2252e319944f9fa8217efb591f379f7c370651ee9425988aaabe6/py_ard-2.4.6.tar.gz"
  sha256 "80cb8fb0bac7d8fff07eb8dc01e9903c0f3f9b7e21d88fcbe6c26b3b8e37cc27"
  license "LGPL-3.0"

  depends_on "python@3.15"

  def install
    venv = virtualenv_create(libexec, "python3.15")
    # pandas/pyarrow have no Homebrew formulae; install prebuilt wheels instead of
    # the source builds that venv.pip_install forces (--no-binary :all:).
    system libexec/"bin/python", "-m", "pip", "install", "--prefer-binary",
           "pandas[excel,pyarrow]"
    venv.pip_install_and_link buildpath
  end

  test do
    # Do a basic test of reducing HLA-A*01:01:01
    redux_result = shell_output("#{bin}/pyard --gl 'HLA-A*01:01:01' -r lgx")
    assert_match("HLA-A*01:01", redux_result.strip)
  end
end
