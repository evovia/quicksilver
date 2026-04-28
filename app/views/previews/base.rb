class Previews::Base < Phlex::HTML
  def to_code
    source = File.read(Object.const_source_location(self.class.name).first)
    lines = source.lines
    start = lines.index { |l| l =~ /def view_template/ }
    return source unless start

    indent = lines[start][/^\s*/].length
    body = lines[(start + 1)..].take_while { |l| !(l.rstrip =~ /^\s{#{indent}}end$/) }
    body.map { |l| l.delete_prefix(" " * (indent + 2)) }.join.chomp
  end
end
