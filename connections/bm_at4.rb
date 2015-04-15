module BmAt4
  include DevOn

  Config.on "bm_at4" do
    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end

    tomcat do
      jvmRoute "alf04"
    end
    
    tcp do
      host Config.bm_at4.settings.hostname
    end

    tmp "/tmp"
  end
end

