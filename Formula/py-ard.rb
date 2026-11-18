class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/9e/60/0cf5cc0b17165d192dc942d888d0804ca635ea662b198856b29df4822907/py_ard-2.4.4.tar.gz"
  sha256 "12d11b3c9f501efcf46a67475a36dd0f0921bdbc229f8fb6418310912dca6ebc"
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
