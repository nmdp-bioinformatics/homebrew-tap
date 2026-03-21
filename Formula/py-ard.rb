class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/a1/aa/61e01212a8784b4b633d74ae6c254dcc4b2ba36faf3c2d8b736342223a29/py_ard-2.0.0.tar.gz"
  sha256 "dc3058bb0bf5abb2ebe9f1da58f78d54935e1bd1a025d1ade8a4a041a589a7c6"
  license "LGPL-3.0"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11", without_pip: false)
    venv.pip_install "pandas[excel,pyarrow]"
    venv.pip_install_and_link buildpath
  end

  test do
    # Do a basic test of reducing HLA-A*01:01:01
    redux_result = shell_output("#{bin}/pyard --gl 'HLA-A*01:01:01' -r lgx")
    assert_match("HLA-A*01:01", redux_result.strip)
  end
end
