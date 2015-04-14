module Simple
  include DevOn
  Config.on "simple" do
    shell "ls -la /vagrant"   
  end
  
  Config.simple.add_compatibility!("connect") #will be executed only on install script
end
