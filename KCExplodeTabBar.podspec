Pod::Spec.new do |s|
  s.name             = "KCExplodeTabBar"
  s.version          = "0.1.0"
  s.summary          = "An explode circular design for UITabBar."

  s.description      = <<-DESC
                       KCExplodeTabBar could be a really nice alternative for the standard UITabBar if you found that too boring.
                       Instead of static squares, tabs are now circular with expand/collapse animations. 
                       DESC

  s.homepage         = "https://github.com/Kev1nChen/KCExplodeTabBar"
  s.license          = 'MIT'
  s.author           = 'Kevin Yufei Chen'
  s.source           = { :git => "https://github.com/Kev1nChen/KCExplodeTabBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'KCExplodeTabBar' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
