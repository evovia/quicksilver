class Previews::Base < Phlex::HTML
  def self.scenarios
    public_instance_methods(false)
  end

  def with_scenario(scenario)
    @__scenario = scenario
    self
  end

  def view_template
    send(@__scenario) if @__scenario
  end

  def code_for(method_name)
    source = File.read(Object.const_source_location(self.class.name).first)
    lines = source.lines
    start = lines.index { |l| l.strip.start_with?("def #{method_name}") }
    return "" unless start

    indent = lines[start][/^\s*/].length
    body = lines[(start + 1)..].take_while { |l| !(l.rstrip =~ /^\s{#{indent}}end$/) }
    body.map { |l| l.delete_prefix(" " * (indent + 2)) }.join.chomp
  end
end
