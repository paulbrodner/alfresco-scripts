module Simple
  include DevOn
  Config.on "simple" do
    shell "ls -la /vagrant"   
  end

  f = use_file Config.simple, "sample"
  puts Template.from_file f
  Config.simple.add_compatibility!("install") #will be executed only on install script
end
