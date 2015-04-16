module BmClusterNode
  include DevOn

  Config.on "bm_cluster_node" do

    alfresco do
      home "/home/bm0013/alfresco-4.1.10"
    end

    hazelcast do
      interface "172.29.20.*"
      members "172.29.20.12,172.29.20.13,172.29.20.14,172.29.20.15"
    end

    tomcat do
      jvmRoute $connection.tomcat.jvmRoute
      home File.join(Config.bm_cluster_node.alfresco.home,"tomcat")
      lib File.join(Config.bm_cluster_node.tomcat.home,"lib")
      scripts File.join(Config.bm_cluster_node.tomcat.home,"scripts")
      conf File.join(Config.bm_cluster_node.tomcat.home,"conf")

      shared do
        classes do
          home File.join(Config.bm_cluster_node.tomcat.home, "shared/classes")
          alfresco_extension File.join(Config.bm_cluster_node.tomcat.shared.classes.home, "alfresco/extension")
          alfresco_license File.join(Config.bm_cluster_node.tomcat.shared.classes.alfresco_extension, "license")
          alfresco_web_extension File.join(Config.bm_cluster_node.tomcat.shared.classes.home, "alfresco/web-extension")
        end
      end
      webapps do
        home File.join(Config.bm_cluster_node.tomcat.home,"webapps")
        alfresco do
          web_inf File.join(Config.bm_cluster_node.tomcat.webapps.home,"alfresco/WEB-INF")
        end
      end
    end

    dir do
      #remote "/data/nfs/replicate/bm0013_4110_b5"
      remote "/data/nfs/replicate/upgrade-402-411"
    end

    db do
      #name "bm0013_4110_b5_cluster"
      name "bm0013_upgrade_402_411"
      url "jdbc:mysql://db01:3306/${db.name}?useUnicode=yes&characterEncoding=UTF-8"
    end

    cluster do
      name "bm0013"
    end

    tcp do
      host $connection.tcp.host
      initial_hosts "172.29.20.12[7800],172.29.20.13[7800],172.29.20.14[7800],172.29.20.15[7800]"
      start_port "7800"
    end

    solr do
      host "172.29.20.18"
      port "8080"
    end
  end

  #add compatible with this script
  Config.bm_cluster_node.add_compatibility!("cluster_node")
  Config.bm_cluster_node.add_compatibility!("restart_alfresco_tomcat")
end
