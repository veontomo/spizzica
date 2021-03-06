# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the "home page"$/
      '/'

    when /^the (.+) page$/
     send("#{$1}s_path")

     when /^the page "Beer Styles"$/
       beerstyles_path

     when /^the page "Prenotations"$/
       new_prenotation_path


     when /^the page "Spizzicaluna One"$/
       one_path

    when /^the page "Beer"$/
       beers_path

    when /^the page "New Beer"$/
       new_beer_path

     when /^the page "Order"$/
       orders_path

     when /^the page "Sandwich"$/
       sandwiches_path

     when /^the page "Containers"$/
       containers_path


#    when /^the item page$/
#      items_path

    when /^the order page$/
      orders_path

#    when /^the user page$/
#      users_path

    when /^the page "userlogin"$/
      user_session_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
