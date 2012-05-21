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

puts "Total commits #{commits.length}"

authors.each do |k, v|
  print k
  print " - #{v.length} commits\n"
end

