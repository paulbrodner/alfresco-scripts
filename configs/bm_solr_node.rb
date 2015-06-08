module MmSolrNode
  include DevOn

  Config.on "bm_solr_node" do

    tomcat do
      home "/home/bm0013/apache-tomcat-7.0.59"
      conf File.join(Config.bm_solr_node.tomcat.home, "conf")

      catalina do
        localhost File.join(Config.bm_solr_node.tomcat.conf, "Catalina/localhost")
      end

      webapps do
        home File.join(Config.bm_solr_node.tomcat.home, "webapps")
        solr do
          web_inf File.join(Config.bm_solr_node.tomcat.webapps.home, "solr/WEB-INF")
        end
      end
    end

    solr do
      home "/home/bm0013/alfresco-enterprise-solr1-5.0.2-b11"
      index_data "/data/solr/solr-index-data"
      core_properties do
        archiveSpaceStore File.join(Config.bm_solr_node.solr.home, "archive-SpacesStore/conf/solrcore.properties")
        workspaceSpaceStore File.join(Config.bm_solr_node.solr.home, "workspace-SpacesStore/conf/solrcore.properties")
      end
    end

    # bind with alfresco directly or with a load balancer
    alfresco do
      host "lb01"
      port "80"
    end

  end

  #add compatible with this script
  Config.bm_solr_node.add_compatibility!("update_solr_node")
  Config.bm_solr_node.add_compatibility!("connect")
end
