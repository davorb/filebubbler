# filebubbler (c) 2012 Davor Babic <davor@davor.se>
# This script moves all of the files in the subfolders
# up one level.

require 'fileutils'

dirpath = "D:\\tmp1"

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
end
