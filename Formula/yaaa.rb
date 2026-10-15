# Written by cli/release/formula.mjs in yaaa-io/yaaa from yaaa 0.1.13's signed manifest. Don't edit it by hand:
# the next release replaces it.
class Yaaa < Formula
  desc "Shopping agent for your terminal and the AI agents in it"
  homepage "https://yaaa.io"
  version "0.1.13"
  license "Apache-2.0"

  # The installer's tarballs: yaaa with the Node.js it runs on, so nothing else is needed.
  on_macos do
    on_arm do
      url "https://yaaa.io/releases/0.1.13/yaaa-0.1.13-darwin-arm64.tar.gz"
      sha256 "e89bf4603f7bbe8675d405c14b1c8c7323255907ed5b7c9306e47c1def28dbab"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.13/yaaa-0.1.13-darwin-x64.tar.gz"
      sha256 "c1978a3a67a0f4d095cf33a8c3d36886b8a727949ef54521514bfedc58629de4"
    end
  end

  on_linux do
    on_arm do
      url "https://yaaa.io/releases/0.1.13/yaaa-0.1.13-linux-arm64.tar.gz"
      sha256 "71cc38c2314a266953e9d0559a96ebfc05f80ea3003fa8e7f2bcb59760e1924b"
    end
    on_intel do
      url "https://yaaa.io/releases/0.1.13/yaaa-0.1.13-linux-x64.tar.gz"
      sha256 "e776231c30f5f9a8fc860aa9246c3ef6b4fb642aea41152ab5b4f84bc28f42bf"
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
