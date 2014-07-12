require 'yaml'

module Ruboty
  module Handlers
    class Sushiyuki < Base
      @@map = nil
      def self.map
        unless @@map
          map_file = "#{File.dirname(__FILE__)}/../../../data/map.yml"
          @@map = YAML.load_file(map_file)
        end
        @@map
      end

      on /sushi( me)? ?(?<keyword>.+)?/, name: 'sushi', description: 'Generate sushiyuki image matching with the keyword'

      def sushi(message = {})
        keyword = message[:keyword] || 'wat'
        url = generate(keyword)
        message.reply(url) if url
      end

      private
      def generate(query)
        s = Sushiyuki.map[query]
        "https://raw.githubusercontent.com/chiastolite/ruboty-sushiyuki/resources/images/%02d.png" % s
      end
    end
  end
end
