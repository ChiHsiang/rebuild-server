module SimpleServer
  class File
    attr_accessor :root

    def initialize(root)
      @root = root
    end

    def check_path(path)
      new_dir = Dir.glob(path.split('/').join('/'))
      @root = Dir.new(new_dir) if path != "/" && !new_dir.empty?
      parse_dir_struct
    end

    def parse_dir_struct
      begin
        @root.entries.reduce({:dir => [], :file => []}) { |dir_struct, file|
          ::File.directory?(file) ? (dir_struct[:dir].push(file)) : (dir_struct[:file].push(file))
          dir_struct
        }
      rescue Exception => e
      end
    end
  end
end
