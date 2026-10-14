# Written by cli/release/formula.mjs in yaaa-io/yaaa from yaaa 0.1.11's signed manifest. Don't edit it by hand:
# the next release replaces it.
class Yaaa < Formula
  desc "Shopping agent for your terminal and the AI agents in it"
  homepage "https://yaaa.io"
  version "0.1.11"
  license "Apache-2.0"

  # The installer's tarballs: yaaa with the Node.js it runs on, so nothing else is needed.
  on_macos do
    on_arm do
      url "https://yaaa.io/releases/0.1.11/yaaa-0.1.11-darwin-arm64.tar.gz"
      sha256 "b909e7f148a28de3c06f0b0ee1796afc65cb5d6528250bf37be8a789f305fdd8"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.11/yaaa-0.1.11-darwin-x64.tar.gz"
      sha256 "295ad0f0a64444c250ec1f1626510fbbe6b34edc04f245215018cacc0eff244e"
    end
  end

  on_linux do
    on_arm do
      url "https://yaaa.io/releases/0.1.11/yaaa-0.1.11-linux-arm64.tar.gz"
      sha256 "5e2f37999d0cb8dd2f4610b84b9b862bb91f48960b0bd1f6c571c28d428906c0"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.11/yaaa-0.1.11-linux-x64.tar.gz"
      sha256 "0733cabbe83932597c344f1fe5d979a6218ec1e8ff6f1bdcdd9ec335cd955a83"
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
