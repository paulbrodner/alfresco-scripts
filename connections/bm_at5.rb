module BmAt4
  include DevOn

  Config.on "bm_at5" do
    os OS_UNIX

    settings do
      hostname ENV['hostname']
      username ENV['username']
      password ENV['password']
      port ENV['port']
    end

    tomcat do
      jvmRoute "alf05"
    end

    tcp do
      host Config.bm_at5.settings.hostname
    end

    tmp "/tmp"
  end
end

