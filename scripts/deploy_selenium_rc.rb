
module Deploy_selenium_rc
  include DevOn
  
  # Windows Deploy
  Command.upload_file(use_file($config, "selenium-hub.bat.erb"), File.join($config.location.win,"selenium-hub.bat"))
  
  provision_on $config
end
  