module MmSolrNode
  include DevOn
  SOLR_HOME = "/home/bm0013/alfresco-one-20151203-SNAPSHOT-563/solr4"

  #-------------------
  Config.on "bm_solr_node" do

    tomcat do
      # wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.zip
      # unzip apache-tomcat-7.0.59.zip
      home "/home/bm0013/apache-tomcat-7.0.59"
      conf File.join(Config.bm_solr_node.tomcat.home, "conf")

      catalina do
        localhost File.join(Config.bm_solr_node.tomcat.conf, "Catalina/localhost")
      end

      webapps do
        home File.join(Config.bm_solr_node.tomcat.home, "webapps")
        solr do
          web_inf File.join(Config.bm_solr_node.tomcat.webapps.home, "solr4/WEB-INF")
        end
      end
    end

    solr do
      home SOLR_HOME
      index_data "/data/solr/solr-index-data"
      core_properties do
        archiveSpaceStore File.join(Config.bm_solr_node.solr.home, "archive-SpacesStore/conf/solrcore.properties")
        workspaceSpaceStore File.join(Config.bm_solr_node.solr.home, "workspace-SpacesStore/conf/solrcore.properties")
      end
    end

    # bind with alfresco directly or with a load balancer or a single node
    alfresco do
      host "alf01"
      port "8080"
    end

  end

  #add compatible with this script
  Config.bm_solr_node.add_compatibility!("update_solr_node")
  Config.bm_solr_node.add_compatibility!("connect")
end
