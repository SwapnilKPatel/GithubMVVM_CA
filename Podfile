# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


use_frameworks!
platform :ios, '16.0'
inhibit_all_warnings!

def sharedPods
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Verifacto
  pod 'Alamofire'
  

end

target 'GithubMVVM_CA' do
  sharedPods
end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
                  config.build_settings["CODE_SIGNING_ALLOWED"] = "NO"
               end
          end
   end
end
