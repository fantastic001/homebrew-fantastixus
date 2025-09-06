class Gtd < Formula
  include Language::Python::Virtualenv

  desc "Task management and reporting tool"
  homepage "https://github.com/fantastic001/gtd"
  license "MIT"
  head "https://github.com/fantastic001/gtd.git", branch: "master"

  bottle do
    rebuild 2
  end

  depends_on "python@3.9"

  def install
    # virtualenv_install_with_resources
    venv = virtualenv_create(libexec, "python3.9")
    venv.pip_install "pip", "setuptools", "wheel"
    # ↓ No --no-deps: pip resolves deps from pyproject.toml
    venv.pip_install buildpath
    venv.pip_install_and_link buildpath
  end

  test do
    output = ""
    begin
      output = shell_output("#{bin}/gtd --help")
    rescue => e
      raise "gtd --help failed to run: #{e.message}"
    end
    assert_match "usage:", output
  end
end
