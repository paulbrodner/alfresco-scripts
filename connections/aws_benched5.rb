module BmAt1
  include DevOn

  Config.on "aws_benched5" do
    settings do
      hostname ENV['hostname']
      username ENV['username']
      key_data "~/.ssh/reporting-qa.pem"
      port ENV['port']
    end
    
    tmp "/tmp"
  end
end

