class MCollective::Application::Users<MCollective::Application

  def validate_configuration(configuration)
    #raise "Please specify a check name" unless configuration.include?(:command)
  end

  description 'Distributed User Management'
  usage 'mco users <action> [--pattern=.]'

  option :pattern,
    :description => 'Show users matching pattern',
    :arguments   => ['--pattern'],
    :type        => :string

  def handle_message(action, message, *args)
    messages = {1 => 'Please provide an action',
                #2 => "'%s' specified as process field. Valid options are %s",
                2 => "Invalid action. Valid action is 'list'"}

    send(action, messages[message] % args)
  end

  def post_option_parser(configuration)
    handle_message(:raise, 1) if ARGV.size == 0
    configuration[:action] = ARGV.shift
    handle_message(:raise, 2) unless configuration[:action] == 'list'
    configuration[:pattern] = ARGV.shift || '.'
  end

  def main
    who = rpcclient('users')
    raise "No Users RPC client found" if who.nil?
    who_result = who.send(configuration[:action], :pattern => configuration[:pattern])
    final_output = {}

    who_result.each do |result|
      if result[:statuscode] == 0

        next if result[:data][:userlist].empty?

        final_output[result[:sender]] = []

        result[:data][:userlist].each do |user|
          final_output[result[:sender]] << user
        end

      else
        puts "   %-10s%20s" % [result[:sender], result[:statuscode]]
      end
    end

    final_output.each do |sender,users|
      puts "   %s %s" % [sender, users]
    end

    puts

    printrpcstats(:summarize => true, :caption => "%s Users results" % configuration[:action])
  end
end
