module BM
  include DevOn

  Config.on "aws_benched" do
    settings do
      hostname ENV['hostname']
      username ENV['username']
      key_data "~/.ssh/reporting-qa.pem"
      port ENV['port']
    end
    
    tmp "/tmp"
  end
end

