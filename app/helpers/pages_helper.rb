module PagesHelper
  # Generates a list of name/link pairs that may be used to build a navigational breadcrumb trail.
  def breadcrumb(object, trail)
    if object.is_a? Bunkai
      breadcrumb(object.kata, trail)
      if object.title.length > 20
        description = object.title[0..19] + '...'
      else
        description = object.title
      end
      trail << [description, bunkai_path(object)]
    elsif object.is_a? Kata
      breadcrumb(object.style, trail)
      trail << [object.name, kata_path(object)]
    elsif object.is_a? Style
      trail << [object.name, style_path(object)]
    else
      # No op.
    end
  end

  
  # Enable pagniation for arrays.
  require 'will_paginate/collection'
  Array.class_eval do
    def paginate(options = {})
      raise ArgumentError, "parameter hash expected (got #{options.inspect})" unless Hash === options
 
      WillPaginate::Collection.create(
        options[:page] || 1,
        options[:per_page] || 30,
        options[:total_entries] || self.length
      ) { |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      }
    end
  end
end
