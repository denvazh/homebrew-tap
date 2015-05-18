cask :v1 => 'intellij-idea-custom-jdk-bundled' do
  version '14.1.3'
  sha256 '7e5f463573b635a647337a6b61ebeae15cedd1829eabb0e2339d865325083976'

  url "http://download.jetbrains.com/idea/ideaIU-#{version}-custom-jdk-bundled.dmg"
  name 'IntelliJ IDEA'
  homepage 'https://www.jetbrains.com/idea/'
  license :commercial

  app 'IntelliJ IDEA 14.app'

  zap :delete => [
                  '~/Library/Application Support/IntelliJIdea14',
                  '~/Library/Preferences/IntelliJIdea14',
                 ]

  caveats <<-EOS.undent
    #{token} includes bundled JRE 1.8u40 custom build.

    The vendor (JetBrains) doesn't support newer versions of Java (yet)
    due to several critical issues, see details at
    https://intellij-support.jetbrains.com/entries/27854363
  EOS
end