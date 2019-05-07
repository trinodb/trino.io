module Jekyll
  class YouTubeTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @video = text.strip
    end

    def render(context)
      url = "https://www.youtube.com/embed/#{@video}"
      %Q[
<div class="video-responsive">
    <iframe width="720" height="405" src="#{url}" frameborder="0" allowfullscreen></iframe>
</div>
      ]
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::YouTubeTag)
