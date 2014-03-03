module MCollective
  module Agent
    class Users<RPC::Agent

      activate_when do
        File.executable?("/usr/bin/who")
      end

      action 'list' do
        pattern = request[:pattern] || '.'
        reply[:userlist] = get_user_list(pattern)
      end

      private

      def get_user_list(pattern)
        if exe = which('who')
          output = %x(#{exe})
          users = []
          output.each do |line|
            item = line.split(/\s+/).first
            next if item !~ /#{pattern}/
            users.push(item) if not users.include?(item)
          end
        end
        return users
      end

      def which(cmd)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
          }
        end
        return nil
      end
    end
  end
end
