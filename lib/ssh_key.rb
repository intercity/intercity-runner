require "fileutils"
class SshKey
  def initialize(key)
    @key = key
  end

  def create_key_for_connection
    File.open(key_path, "w+", 0600) do |f|
      f.write(@key)
    end
  end

  private

  def key_path
    FileUtils.mkdir_p("/root/.ssh/") unless File.directory?("/root/.ssh/")
    "/root/.ssh/id_rsa"
  end
end
