require 'mercurial-ruby'

repo_path = ARGV[0]

repo = Mercurial::Repository.open(repo_path)

message_length = 0
commits = repo.commits.all
authors = {}

commits.each do |c|
  message_length += c.message.length
  if authors.has_key? c.author
    authors[c.author] << c
  else
    authors[c.author] = [c]
  end
end

puts "Total average commit message length: #{message_length / commits.length}"

authors.each do |k, v|
  print k
  msg_length = 0
  v.each do |v|
#    puts v
    msg_length += v.message.length
  end
  print " -- Average commit message length: #{msg_length / v.length}\n"
end

