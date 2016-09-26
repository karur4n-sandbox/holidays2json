require 'json'
require 'yaml'

source = YAML.load_file('./source.yml')
output_path = './holidays.json'

output = {}

applys = %w(成人の日 海の日 敬老の日 秋分の日 体育の日)

source.each do |row|
  name = row[1]
  next unless applys.include?(name)

  date = row[0]

  date_hash = {"#{date.year}": "#{date.month}#{date.day}"}

  if output[name]
    output[name] << date_hash
  else
    output[name] = [date_hash]
  end
end

File.open(output_path, 'w') do |f|
  f.write(JSON.pretty_generate(output))
end
