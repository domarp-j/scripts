#!/usr/bin/env ruby

# Renames files in directories into snake_case
# Place script inside desired directory & execute

Dir.foreach(".") do |old_name|
  new_name = old_name.downcase.gsub(/\s/, '_')
  next if old_name == __FILE__.to_s[2..-1] || old_name == '.' || old_name == '..'
  File.rename("./#{old_name}", "./#{new_name}")
end

