module BmClusterNode
  include DevOn
  # change this constants only
  DB_NAME           = "ACE4814"
  ALFRESCO_HOME     = "/home/#{ENV['username']}/alfresco-one-b563"
  REPLICATE_FOLDER  = "/data/nfs/replicate/ace-4814"
  INSTALLER_BIN     = "/data/nfs/software/alfresco/alfresco-5.0.2/build-00011/alfresco-enterprise-5.0.2-installer-linux-x64.bin"

  Config.on "bm_cluster_node" do
    installer do
      binary INSTALLER_BIN
      db_name DB_NAME
      jdbc_username "bm0013"
      jdbc_password "bm0013"
      jdbc_url "jdbc:mysql://db01:3306/#{Config.bm_cluster_node.installer.db_name}?useUnicode=yes&characterEncoding=UTF-8"
      enable_components "javaalfresco,alfrescosharepoint,alfrescowcmqs,libreofficecomponent"
      disable_components "postgres"
      driver "com.mysql.jdbc.Driver"
      install_as_a_service "0"
    end

    alfresco do
      home ALFRESCO_HOME
      log File.join(Config.bm_cluster_node.alfresco.home, "alfresco.log")
      share do
        log  File.join(Config.bm_cluster_node.alfresco.home, "share.log")
      end
      version File.dirname(Config.bm_cluster_node.alfresco.home)
    end

    dir do
      remote REPLICATE_FOLDER
    end

    hazelcast do
      interface "172.29.20.*"
      members "alf01,alf02,alf03,alf04"
    end

    tomcat do
      jvmRoute $connection.tomcat.jvmRoute
      home File.join(Config.bm_cluster_node.alfresco.home, "tomcat")
      lib File.join(Config.bm_cluster_node.tomcat.home, "lib")
      scripts File.join(Config.bm_cluster_node.tomcat.home, "scripts")
      conf File.join(Config.bm_cluster_node.tomcat.home, "conf")
      catalina do
        home File.join(Config.bm_cluster_node.tomcat.conf, "Catalina")
        localhost File.join(Config.bm_cluster_node.tomcat.catalina.home, "localhost")
      end
      catalina_out File.join(Config.bm_cluster_node.tomcat.home, "logs/catalina.out")
      shared do
        classes do
          home File.join(Config.bm_cluster_node.tomcat.home, "shared/classes")
          alfresco_extension File.join(Config.bm_cluster_node.tomcat.shared.classes.home, "alfresco/extension")
          alfresco_web_extension File.join(Config.bm_cluster_node.tomcat.shared.classes.home, "alfresco/web-extension")
        end
      end

      webapps do
        home File.join(Config.bm_cluster_node.tomcat.home, "webapps")
        solr4 File.join(Config.bm_cluster_node.tomcat.webapps.home, "solr4")
        solr4war File.join(Config.bm_cluster_node.tomcat.webapps.home, "solr4.war")
        alfresco do
          web_inf File.join(Config.bm_cluster_node.tomcat.webapps.home, "alfresco/WEB-INF")

          classes do
            log4j File.join(Config.bm_cluster_node.tomcat.webapps.alfresco.web_inf, "classes/log4j.properties")
          end
        end
      end
    end

    db do
      name Config.bm_cluster_node.installer.db_name
      url Config.bm_cluster_node.installer.jdbc_url
      username Config.bm_cluster_node.installer.jdbc_username
      password Config.bm_cluster_node.installer.jdbc_password
    end

    cluster do
      name "bm0013"
    end

    tcp do
      host $connection.tcp.host
      initial_hosts "alf01[7800],alf02[7800],alf03[7800],alf04[7800]"
      start_port "7800"
    end

    solr do
      host "sl01"
      port "8080"
    end

    #
    # backups old execution
    #
    backups do
      b402 do
        contentstore do
          source "/data/nfs/backup/BM-0010-20130620/data/contentstore-bm-0009/contentstore_2012_for_402.tar.gz"
          destination Config.bm_cluster_node.dir.remote
        end

        mysql do
          source "/data/nfs/backup/BM-0010-20130620/data/contentstore-bm-0009/20121119-402-backup-schema.tar.gz"
          destination "#{Config.bm_cluster_node.backups.b402.contentstore.destination}/schema/20121119-402-backup-schema.sql"
        end
      end
    end
  end

  #add compatible with this script
  Config.bm_cluster_node.add_compatibility!("update_cluster_node")
  Config.bm_cluster_node.add_compatibility!("restart_alfresco_tomcat")
  Config.bm_cluster_node.add_compatibility!("cleanup_logs")
  Config.bm_cluster_node.add_compatibility!("harvest_logs")
  Config.bm_cluster_node.add_compatibility!("stop_bm_node")
  Config.bm_cluster_node.add_compatibility!("unzip_backup")
  Config.bm_cluster_node.add_compatibility!("import_mysql_backup")
  Config.bm_cluster_node.add_compatibility!("installing_alfresco")
end
