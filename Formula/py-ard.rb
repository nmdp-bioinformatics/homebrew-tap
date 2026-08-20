class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://py-ard.org"
  url "https://files.pythonhosted.org/packages/3e/8f/032e5ebc7e20d9a829d58494f1bf408837f30b0f2784f8fe62c5f61c8fc1/py_ard-2.4.0.tar.gz"
  sha256 "1889b93b26f780580ccf78886c171cd3fcfa2bf2a29a566b06d3300094c5011f"
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
