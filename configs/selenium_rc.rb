module SeleniumRc
  include DevOn

  Config.on "selenium_rc" do
    url do
      selenium_jar "http://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar"
    end

    jar_name File.basename(Config.selenium_rc.url.selenium_jar)

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
      unix "/grid"
      win "c:\\grid"
    end
  end

  Config.selenium_rc.add_compatibility!("deploy_selenium_rc")
end
