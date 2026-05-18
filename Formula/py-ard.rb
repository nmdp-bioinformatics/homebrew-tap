class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/0e/64/22b0834f0aad62a148de49cf744134b158612824d6050dd4eeecf67a5026/py_ard-2.1.1.tar.gz"
  sha256 "c37617745d1bf47587d734449896509aa001496fbba96587fa337dee6613e1cd"
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
