require 'irb/completion'
require 'irb/ext/save-history'
# require 'map_by_method'
require 'pp'
require 'rubygems'

### IRB configuration.
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "./.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true

### Wirble
# This adds some nice features to the IRB.  The obvious change is
# coloring.
# You can also use ri from the irb:
#  >> Object.ri 'Array#map'
begin
  require 'wirble'

  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Unable to load Wirble: #{err} (maybe: gem install wirble)"
end

### Hirb
  # Hirb renders a view based on the object's class and/or ancestry
  # User.all.
begin
  require 'hirb'
  Hirb.enable
rescue LoadError => err
  warn "Unable to load Hirb: #{err} (maybe: gem install hirb)"
end

### What? method
# The Object.what? method returns the method(s) that will return
# a specific value.
# Example:
#  >> 6.what? 7
#  6.succ == 7
#  6.next == 7
#  => ["succ", "next"]
begin
  require 'what_methods'
rescue LoadError => err
  warn "Unable to load What Methods: #{err} (maybe: gem install what_methods)"
end

### ap method
# ap() is an enhanced version of pp()
# Example:
# >> ap (1..4).to_a
# [
#     [0] 1,
#     [1] 2,
#     [2] 3,
#     [3] 4
# ]
# => nil
begin
  require 'ap'
rescue LoadError => err
  warn "Unable to load Awesome Print (ap): #{err} (maybe: gem install awesome_print)"
end

## Handy shortcuts
# Yeah, I type this too often.
def ls
  %x{ls}.split("\n")
end

# reloads a file into the IRB.
# from http://themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end

# Require Sinatra application
require "./app"

## Notify us of the version and that it is ready.
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE}) #{RUBY_PLATFORM}"

# Local Variables:
# mode: ruby
# End: