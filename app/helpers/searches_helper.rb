module SearchesHelper
  def image_to_clickable_link(_image, link_path)
    link_to image_tag('black_hart.png', class: 'favorite-button'),
            link_path,
            method: :post
  end
end
