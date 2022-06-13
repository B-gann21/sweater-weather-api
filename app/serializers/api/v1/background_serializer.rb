class Api::V1::BackgroundSerializer
  def self.image_info(background)
    {
      data:  {
        id: nil,
        type: 'image', 
        attributes: {
          image: {
            location: background.location,
            image_url: background.image_url,
            credit: {
              source: background.source,
              author: background.author,
            }
          }
        }
      }
    }
  end
end
