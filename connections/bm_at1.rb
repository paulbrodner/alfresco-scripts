module BmAt1
  include DevOn

  Config.on "bm_at1" do
    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end
    
    tomcat do
      jvmRoute "alf01"
    end
    
    tcp do
      host Config.bm_at1.settings.hostname
    end

    tmp "/tmp"
  end
end

