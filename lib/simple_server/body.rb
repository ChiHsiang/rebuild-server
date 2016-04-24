module SimpleServer
  class Body
    attr_accessor :body

    def initialize
      @body = "<ul>\r\n"
    end

    def render_node(base_dir)
      base_dir[:dir].each { |dir| 
        @body += "<li>" + "<a href=http://127.0.0.1:3000/#{dir}>#{dir}</a>" + "</li>\r\n"
      }
      base_dir[:file].each { |file| 
        @body += "<li>#{file}</li>\r\n"
      }
      @body += "</ul>"

      return @body
    end

  end
end
