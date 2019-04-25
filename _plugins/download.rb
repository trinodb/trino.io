module Jekyll
  class DownloadTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      (@name, @suffix) = text.strip.split(/ +/)
    end

    def render(context)
      version = context['site']['presto_version']
      base = 'https://repo1.maven.org/maven2/io/prestosql'
      file = "#{@name}-#{version}#{@suffix}"
      url = "#{base}/#{@name}/#{version}/#{file}"
      %Q[<a class="button" href="#{url}"><img src="/assets/icon-download.png" />#{file}</a>]
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::DownloadTag)
