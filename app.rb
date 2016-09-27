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

  value = date.month.to_s.rjust(2, '0') + date.day.to_s.rjust(2, '0')

  if output[name].nil?
    output[name] = {}
    output[name]["#{date.year}"] = value
  else
    output[name]["#{date.year}"] = value
  end
end

File.open(output_path, 'w') do |f|
  f.write(JSON.pretty_generate(output))
end
