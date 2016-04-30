cask 'intellij-idea-15-eap-custom-jdk-bundled' do
  version '143.379.11' # since its EAP it is actually a build number
  sha256 '6cf8fc266ca5405806bb43af4e4552beab49b26d1cf21c868512dc54871f6e56'

  url "https://download.jetbrains.com/idea/ideaIU-#{version}-custom-jdk-bundled.dmg"
  name 'IntelliJ IDEA 15 EAP'
  homepage 'https://www.jetbrains.com/idea/'
  license :commercial

  app 'IntelliJ IDEA 15 EAP.app'

  zap :delete => [
                  '~/Library/Application Support/IntelliJIdea15',
                  '~/Library/Preferences/IntelliJIdea15',
                 ]

  caveats <<-EOS.undent
    #{token} includes bundled JRE 1.8u40 custom build.
  EOS
end