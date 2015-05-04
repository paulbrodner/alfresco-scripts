module BmAWS8
  include DevOn

  Config.on "aws_benched8" do
    os OS_UNIX

    settings do
      hostname ENV['hostname']
      username ENV['username']
      key_data "~/.ssh/reporting-qa.pem"
      port ENV['port']
    end

    tmp "/tmp"
  end
end

