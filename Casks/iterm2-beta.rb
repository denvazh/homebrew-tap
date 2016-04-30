cask 'iterm2-beta' do
  # note: "2" is not a version number, but indicates a different vendor
  version '2.9.20150830'
  sha256 '3248adc0281c03d5d367e042bcc373ae673bf5eea55fe181169e5824c8379e42'

  url "https://iterm2.com/downloads/beta/iTerm2-#{version.gsub('.','_')}.zip"
  name 'iTerm2'
  homepage 'https://www.iterm2.com/'
  # appcast 'https://iterm2.com/appcasts/final.xml',
  #         :sha256 => 'c9d0c5800f6851fc55c07d95109f4cb8ef8dfc12a2c1713c1a4dcc5505fba100'
  license :gpl

  app 'iTerm.app'

  zap :delete => '~/Library/Preferences/com.googlecode.iterm2.plist'
end
