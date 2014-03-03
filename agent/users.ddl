metadata    :name        => "users",
            :description => "Agent To Manage Users",
            :author      => "Matt Callaway",
            :license     => "ASL 2.0",
            :version     => "1.0.0",
            :url         => "http://github.com/genome/mcollective-users/wiki",
            :timeout     => 10

requires :mcollective => '2.2.1'

action "list", :description => "List Users" do
    input :pattern,
          :prompt      => "Pattern to match",
          :description => "List only users matching this patten",
          :type        => :string,
          :validation  => :shellsafe,
          :optional    => true,
          :maxlength    => 50


    output :userlist,
          :description => "User List",
          :display_as => "The User List"

    summarize do
      aggregate summary(:userlist)
    end
end
