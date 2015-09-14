# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
page = agent.get('http://web1.ncaa.org/stats/StatsSrv/pdf/rankings?statSeq=21&div=11&sportCode=MFB&rptType=HTML&doWhat=showrankings')
#
# # Find somehing on the page using css selectors
page.search('//tr[position()>1]').each do |row|
  name = row.search('td[2]').text.strip # Name
  g = row.search('td[3]').text.strip # G
  yds = row.search('td[6]').text.strip # YDS

  next if name.to_s == ''

#
# # Write out to the sqlite database using scraperwiki library
  pp ScraperWiki.save_sqlite([:name], {:name => name, :g => g, :yds => yds})

end
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
