# filebubbler (c) 2012 Davor Babic <davor@davor.se>
# This script moves all of the files in the subfolders
# up one level.

require 'fileutils'

# inputbox code http://snippets.dzone.com/posts/show/10261
def inputbox( message, title="Message from #{__FILE__}" )
  # returns nil if 'cancel' is clicked
  # returns a (possibly empty) string otherwise
  require 'win32ole'
  # hammer the arguments to vb-script style
  vb_msg = %Q| "#{message.gsub("\n",'"& vbcrlf &"')}"|
  vb_msg.gsub!( "\t", '"& vbtab &"' )
  vb_msg.gsub!( '&""&','&' )
  vb_title = %Q|"#{title}"|
  # go!
  sc = WIN32OLE.new( "ScriptControl" )
  sc.language = "VBScript"
  sc.eval(%Q|Inputbox(#{vb_msg}, #{vb_title})|)
end

dirpath = inputbox("Please enter the file path", "filebubbler")

dir = Dir.new dirpath
dir.each do |subdirname|
  full_subdir_path = "#{dirpath}\\#{subdirname}"
  next if subdirname == "." or subdirname == ".."
  next unless Dir.exists? full_subdir_path

  subdir = Dir.new full_subdir_path
  subdir.each do |filename|
    orig_file_path = "#{dirpath}\\#{subdirname}\\#{filename}"
    new_file_path  = "#{dirpath}\\#{filename}"
    next if filename == "." or filename == ".."

    puts "Moving #{orig_file_path} to #{new_file_path}"
    FileUtils.mv("#{orig_file_path}", "#{new_file_path}")
  end
  Dir.delete full_subdir_path
end
