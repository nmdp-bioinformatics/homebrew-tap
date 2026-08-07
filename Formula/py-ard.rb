class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/39/91/2ac004dff9ff709bb95f0ac2db4fbc0adb2cce5e83541abf76defa037eb8/py_ard-2.3.1.tar.gz"
  sha256 "5a522e6f1029d3a008ded519e16385db063d5bbbe39e05da51c9d7af1618cd4b"
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
