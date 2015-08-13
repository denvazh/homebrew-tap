class MecabIpadicNeologd < Formula
  desc "Neologism dictionary for MeCab"
  homepage "https://github.com/neologd/mecab-ipadic-neologd"
  url "https://github.com/neologd/mecab-ipadic-neologd/archive/v0.0.2.tar.gz"
  sha256 "8490c8e0871464830c902c95a48fb50760c81f379e96186ab09f55a63873e354"

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
    args = %W[
      --forceyes
      --asuser
    ]

    if build.with? "newest"
      args << '--newest'
    end

    if build.with? "create-user-dic"
      args << '--create_user_dic'
    end

    if build.without? "adverb"
      args << '--ignore_adverb'
    end

    system "./bin/install-mecab-ipadic-neologd", *args
  end

  ## Caveats

  def caveats; <<-EOS.undent
    To use mecab with mecab-ipadic-neologd:
      mecab -d #{File.join(HOMEBREW_PREFIX, 'opt/mecab/lib/mecab/dic/mecab-ipadic-neologd')}
    EOS
  end

  ## Test

  test do
    cmd = ['echo "SMAP" | mecab -d',
      File.join(HOMEBREW_PREFIX, 'opt/mecab/lib/mecab/dic/mecab-ipadic-neologd'),
      '|md5'].join(' ')
    assert_equal "8fffab379d688faa56f2e1e9bb907db9", `#{cmd}`.chomp
  end
end
