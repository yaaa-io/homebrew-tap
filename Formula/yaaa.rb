# Written by cli/release/formula.mjs in yaaa-io/yaaa from yaaa 0.1.12's signed manifest. Don't edit it by hand:
# the next release replaces it.
class Yaaa < Formula
  desc "Shopping agent for your terminal and the AI agents in it"
  homepage "https://yaaa.io"
  version "0.1.12"
  license "Apache-2.0"

  # The installer's tarballs: yaaa with the Node.js it runs on, so nothing else is needed.
  on_macos do
    on_arm do
      url "https://yaaa.io/releases/0.1.12/yaaa-0.1.12-darwin-arm64.tar.gz"
      sha256 "94bc3800aff65a952a4ccd3123a4b98a04c2fd65420c72f5782a7cbaa976500b"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.12/yaaa-0.1.12-darwin-x64.tar.gz"
      sha256 "fed26ff4e440342433f4494c970a3d8cd63c547acbbf7a8ac181e36f03587ead"
    end
  end

  on_linux do
    on_arm do
      url "https://yaaa.io/releases/0.1.12/yaaa-0.1.12-linux-arm64.tar.gz"
      sha256 "c91a1f9ef73cab33777265883fb44a9e4ac3242399785c429616826b17c07364"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.12/yaaa-0.1.12-linux-x64.tar.gz"
      sha256 "a29cf5fc33833df972cfda17edcda81b8e7540fd0d08150d9996c1474ec30382"
    end
  end

  def install
    libexec.install Dir["*"]
    # YAAA_INSTALLED_BY: yaaa update says to run brew upgrade. YAAA_LAUNCHER: desktop notifications run this path,
    # which survives upgrades.
    (bin/"yaaa").write_env_script libexec/"bin/yaaa",
      YAAA_INSTALLED_BY: "homebrew",
      YAAA_LAUNCHER:     opt_bin/"yaaa"
  end

  def caveats
    <<~EOS
      Set up your account (no sign-up) and the skills for your AI agents:
        yaaa init
    EOS
  end

  test do
    ENV["YAAA_HOME"] = (testpath/".yaaa").to_s
    ENV["YAAA_NO_UPDATE_CHECK"] = "1"
    assert_equal version.to_s, shell_output("#{bin}/yaaa --version").strip
  end
end
