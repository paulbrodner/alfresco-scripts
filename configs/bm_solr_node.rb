module MmSolrNode
  include DevOn

  Config.on "bm_solr_node" do
    solr do
      home "/home/bm0013/alfresco-enterprise-solr-4.1.10-b5"
      index_data "/home/solr-index-data"

      core_properties do
        archiveSpaceStore File.join(Config.bm_solr_node.tomcat.home,"archive-SpacesStore/conf/solrcore.properties")
        workspaceSpaceStore File.join(Config.bm_solr_node.tomcat.home,"workspace-SpacesStore/conf/solrcore.properties")
      end
    end

    # bind with alfresco directly or with a load balancer
    alfresco do
      host "172.29.20.19"
      port "80"
    end

    tomcat do
      home "/home/bm0013/apache-tomcat-7.0.59"
      conf File.join(Config.bm_solr_node.tomcat.home,"conf")
      catalina do
        localhost File.join(Config.bm_solr_node.tomcat.conf,"Catalina/localhost")
      end
      webapps do
        home File.join(Config.bm_solr_node.tomcat.home,"webapps")
        solr do
          web_inf File.join(Config.bm_solr_node.tomcat.webapps,"solr/WEB-INF")
        end
      end
    end
  end
end