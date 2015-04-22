module EnableRnaDashlets
  include DevOn

  Command.run_shell "service alfresco stop"
  
  Command.upload_file(use_file($config, "presets.xml"), "/tmp/presets.xml")
  
  Command.run_shell "sudo cp /tmp/presets.xml #{$config.presets_file}"
  
  Command.run_shell "service alfresco start"
  
  provision_on $config
end