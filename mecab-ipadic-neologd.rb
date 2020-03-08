class MecabIpadicNeologd < Formula
  desc "Neologism dictionary for MeCab"
  homepage "https://github.com/neologd/mecab-ipadic-neologd"
  url "https://github.com/neologd/mecab-ipadic-neologd/archive/v0.0.5.tar.gz"
  sha256 "6a16be3971bea809ae22dd9334e9f0e002e70b7c421e905a1fcd7f43be7a52d8"

  head "https://github.com/neologd/mecab-ipadic-neologd.git", :branch => "master"

  ## Options

  option "with-newest", "Update mecab-ipadic-neologd during install"
  option "with-create-user-dic", "Create an user dictionary using seed data of mecab-ipadic-neologd"
  option "with-install_all_seed_files", "If you want to install all seed files(seed/neologd-*.xz)"
  option "with-eliminate-redundant-entry", "If you want to eliminate the redundant entries"

  option "with-install_only_patched_ipadic", "If you want to install only patched IPADIC"
  option "without-adverb", "Do not install adverb entries of seed data of mecab-ipadic-neologd"
  option "without-interject",
    "If you would not like to install entries of orthographic variant of an interjection as seed data of mecab-ipadic-neologd"
  option "without-noun_ortho",
    "If you would not like to install entries of orthographic variant of a common noun as seed data of mecab-ipadic-neologd"
  option "without-noun_sahen_conn_ortho",
    "If you would not like to install entries of orthographic variant of a noun used as verb form(Sahen-setsuzoku) as seed data of mecab-ipadic-neologd"
  option "without-adjective_std",
    "If you would not like to install entries of frequent orthographic variant of an adjective as seed data of mecab-ipadic-neologd"
  option "with-adjective_exp",
    "If you would like to install entries of infrequent orthographic variant of an adjective as seed data of mecab-ipadic-neologd"
  option "without-adjective_verb",
    "If you would not like to install entries of orthographic variant of an adjective verb as seed data of mecab-ipadic-neologd"

  option "with-infreq_datetime",
    "If you would like to install infrequent entries of datetime representation type of named entity as seed data of mecab-ipadic-neologd"
  option "with-infreq_quantity",
    "If you would like to install infrequent entries of quantity representation type of named entity as seed data of mecab-ipadic-neologd"

  option "without-ill_formed_words",
    "If you would not like to install entries of ill formed words as seed data of mecab-ipadic-neologd"


  ## Dependencies

  depends_on :macos => :mojave
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

    if build.with? "install_all_seed_files"
      args << '--install_all_seed_files'
    end

    if build.with? "install_only_patched_ipadic"
      args << '--install_only_patched_ipadic'
    end

    if build.with? "eliminate-redundant-entry"
      args << '--eliminate-redundant-entry'
    end

    if build.without? "adverb"
      args << '--ignore_adverb'
    end

    if build.without? "interject"
      args << '--ignore_interject'
    end

    if build.without? "noun_ortho"
      args << '--ignore_noun_ortho'
    end

    if build.without? "noun_sahen_conn_ortho"
      args << '--ignore_noun_sahen_conn_ortho'
    end

    if build.without? "adjective_std"
      args << '--ignore_adjective_std'
    end

    if build.with? "adjective_exp"
      args << '--install_adjective_exp'
    end

    if build.without? "adjective_verb"
      args << '--ignore_adjective_verb'
    end

    if build.with? "infreq_datetime"
      args << '--install_infreq_datetime'
    end

    if build.with? "infreq_quantity"
      args << '--install_infreq_quantity'
    end

    if build.without? "ill_formed_words"
      args << '--ignore_ill_formed_words'
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
