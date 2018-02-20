class MecabIpadicNeologd < Formula
  desc "Neologism dictionary for MeCab"
  homepage "https://github.com/neologd/mecab-ipadic-neologd"
  url "https://github.com/neologd/mecab-ipadic-neologd/archive/v0.0.5.tar.gz"
  sha256 "6a16be3971bea809ae22dd9334e9f0e002e70b7c421e905a1fcd7f43be7a52d8"

  head "https://github.com/neologd/mecab-ipadic-neologd.git", :branch => "master"

  ## Options

  option "with-newest", "Update mecab-ipadic-neologd during install"
  option "with-create-user-dic", "Create an user dictionary using seed data of mecab-ipadic-neologd"
  option "without-adverb", "Do not install adverb entries of seed data of mecab-ipadic-neologd"

  ## Dependencies

  depends_on :macos => :mountain_lion
  depends_on "mecab"
  depends_on "mecab-ipadic"
  depends_on "xz"

  ## Install

  def install
    args = ["--prefix #{prefix}", '--forceyes', '--asuser']

    if build.with? "newest"
      args << '--newest'
    end

    if build.with? "create-user-dic"
      args << '--create_user_dic'
    end

    if build.without? "adverb"
      args << '--ignore_adverb'
    end

    system ["./bin/install-mecab-ipadic-neologd"].concat(args).join(" ")
  end

  ## Caveats

  def caveats; <<~EOS
    To use mecab with mecab-ipadic-neologd:
      mecab -d #{opt_prefix}
    EOS
  end

  ## Test

  test do
    cmd = ['echo "SMAP" | mecab -d', opt_prefix, '|md5'].join(' ')
    assert_equal "207e85391d12c9750352f2ea852788d0", `#{cmd}`.chomp
  end
end
