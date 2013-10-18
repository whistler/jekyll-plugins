# returns the url of a random file in a given directory
# example:
#     {% assign images = filelist images %}
#     {% for image in images %}
#     <image src='{{image}}'/>
#     {% endfor %}

module Jekyll
  class FileListTag < Liquid::Tag

    def initialize(tag_name, dir, tokens)
      super
      @directory = dir.strip
    end

    def render(context)
      root = context.registers[:site].config["source"]
      dir = File.join(root, @directory)
      files = Dir[dir.to_s+"/*"]
      relfiles = files.map{|file| file.gsub(root,"")}
    end
  end
end

Liquid::Template.register_tag('file_list', Jekyll::FileListTag)