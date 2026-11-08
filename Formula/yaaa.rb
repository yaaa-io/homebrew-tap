# Written by cli/release/formula.mjs in yaaa-io/yaaa from yaaa 0.1.14's signed manifest. Don't edit it by hand:
# the next release replaces it.
class Yaaa < Formula
  desc "Shopping agent for your terminal and the AI agents in it"
  homepage "https://yaaa.io"
  version "0.1.14"
  license "Apache-2.0"

  # The installer's tarballs: yaaa with the Node.js it runs on, so nothing else is needed.
  on_macos do
    on_arm do
      url "https://yaaa.io/releases/0.1.14/yaaa-0.1.14-darwin-arm64.tar.gz"
      sha256 "b192f4b6220cbafb712b9806fda81995dfcdb8e0b33993e87e0f07b00944d0a2"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.14/yaaa-0.1.14-darwin-x64.tar.gz"
      sha256 "3880aa6e44796cdb06d432e3f3a4111808ee241071224745aa66b2b643f9b0b6"
    end
  end

  on_linux do
    on_arm do
      url "https://yaaa.io/releases/0.1.14/yaaa-0.1.14-linux-arm64.tar.gz"
      sha256 "228d5872fe9a9201357f8887c6bef41cec3b3cbdebc16ba6f6b7d7f0eb077462"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.14/yaaa-0.1.14-linux-x64.tar.gz"
      sha256 "32863ea6ef5fdc74d18c31eaa0efea2de7caefed149cdfee45ab1486595f0d14"
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
