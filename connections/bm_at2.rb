module BmAt2
  include DevOn

  Config.on "bm_at2" do
    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end

    tomcat do
      jvmRoute "alf02"
    end
    
    tcp do
      host Config.bm_at2.settings.hostname
    end

    tmp "/tmp"
  end
end

