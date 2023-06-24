class PyArd < Formula
  include Language::Python::Virtualenv

  desc "Project py-ard is the swiss army knife of HLA ARD reductions in Python"
  homepage "https://github.com/nmdp-bioinformatics/py-ard"
  url "https://files.pythonhosted.org/packages/6e/2f/5b5c376f98b7399e8fc7807484d8ee35f67c3a0c09188139d5cf7deba606/py-ard-1.0.1.tar.gz"
  sha256 "5b6616328cb55ac44f75d6e5fc81ebc38fc5084d8515f3122be3b1e98af53585"
  license "LGPL-3.0"

  depends_on "python@3.10"

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/e4/a9/6704bb5e1d1d778d3a6ee1278a8d8134f0db160e09d52863a24edb58eab5/numpy-1.24.2.tar.gz"
    sha256 "003a9f530e880cb2cd177cba1af7220b9aa42def9c4afc2a2fc3ee6be7eb2b22"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/74/ee/146cab1ff6d575b54ace8a6a5994048380dc94879b0125b25e62edcb9e52/pandas-1.5.3.tar.gz"
    sha256 "74a3fd7e5a7ec052f183273dc7b0acd3a863edf7520f5d3a1765c04ffdb3b0b1"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/03/3e/dc5c793b62c60d0ca0b7e58f1fdd84d5aaa9f8df23e7589b39cc9ce20a03/pytz-2022.7.1.tar.gz"
    sha256 "01a0681c4b9684a28304615eba55d1ab31ae00bf68ec157ec3708a8182dbbcd0"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Do a basic test of reducing HLA-A*01:01:01
    redux_result = shell_output("#{bin}/pyard --gl 'HLA-A*01:01:01' -r lgx")
    assert_match("HLA-A*01:01", redux_result.strip)
  end
end
