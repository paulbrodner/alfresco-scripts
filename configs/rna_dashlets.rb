module Rna_dashlets
  include DevOn

  Config.on "rna_dashlets" do
    presets_file "/opt/alfresco-5.0/tomcat/webapps/share/WEB-INF/classes/alfresco/site-data/presets/presets.xml"
  end
end
