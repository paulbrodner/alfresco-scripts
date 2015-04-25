module BmAt3
  include DevOn

  Config.on "bm_at3" do
    os OS_UNIX
    
    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end
    
    tomcat do 
      jvmRoute "alf03"
    end

    tcp do
      host Config.bm_at3.settings.hostname
    end

    tmp "/tmp"
  end
end

