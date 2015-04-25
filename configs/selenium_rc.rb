module SeleniumRc
  include DevOn

  Config.on "selenium_rc" do
    kits do
      selenium_rc "http://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar"
    end

    jar_name File.basename(Config.selenium_rc.kits.selenium_rc)

    hub do
      heap_size do
        maximum "-Xmx1024M"
        minimum ""
      end
    end

    node do
      heap_size do
        maximum "-Xmx512m"
        minimum ""
      end
      
      max_sessions 25
    end

    location do
      unix "/tmp"
      win "C:\\"
    end
  end
  
  Config.selenium_rc.add_compatibility!("deploy_selenium_rc")
end
