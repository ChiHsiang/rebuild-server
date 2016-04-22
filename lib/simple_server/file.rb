module SimpleServer
  class File
    attr_reader :root

    def initialize(root)
      @root = root
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
