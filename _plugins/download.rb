module Jekyll
  class DownloadTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      (@name, @suffix) = text.strip.split(/ +/)
    end

    def render(context)
      version = context['site']['trino_version']
      base = 'https://repo.maven.apache.org/maven2/io/prestosql'
      file = "#{@name}-#{version}#{@suffix}"
      url = "#{base}/#{@name}/#{version}/#{file}"
      %Q[<a class="btn btn-pink btn-md" href="#{url}">#{file}</a>]
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::DownloadTag)
