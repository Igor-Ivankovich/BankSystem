def cli_ask(ask, actions=nil)
  prompt = TTY::Prompt.new

  if actions == 'text'
    prompt.ask("#{ask}") do |q|
      q.required true
      q.modify   :capitalize
    end
  elsif actions == 'tag'
    prompt.ask("#{ask}", default: '')
  elsif actions == 'number'
    prompt.ask("#{ask}") do |q|
      q.required true
      q.validate /^\d+$/, "Invalid #{ask}"
    end
  elsif actions == 'currency'
    prompt.ask("#{ask}") do |q|
      q.required true
      q.validate /^#{PRICE_CODE}$/, "Invalid #{ask}"
    end
  elsif actions == 'sum'
    prompt.ask("#{ask}") do |q|
      q.required true
      q.validate /^[^-]\d+$/, "Invalid #{ask}"
    end
  elsif actions == 'time'
    prompt.ask("#{ask}")  do |q|
      q.validate /^\d{4}-\d{2}-\d{2}$|^$/, "Invalid #{ask}"
    end
  elsif actions == 'filter'
    prompt.ask("#{ask}")
  elsif actions == 'report_currency'
    prompt.ask("#{ask}") do |q|
      q.validate /^#{PRICE_CODE}$|^$/, "Invalid #{ask}"
    end
  elsif actions == 'output_format'
    prompt.yes?("#{ask}")
  end
end
