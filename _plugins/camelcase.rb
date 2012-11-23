module Jekyll
  class CamelCase < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      text = context[@text]
      text.split(/(?=[A-Z])/).map do |s|
        s.slice(0,1).capitalize + s.slice(1..-1)
      end.join(' ')
    end
  end
end

Liquid::Template.register_tag 'format_camelcase', Jekyll::CamelCase