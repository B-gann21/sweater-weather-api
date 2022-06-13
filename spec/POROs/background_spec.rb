require 'rails_helper'

RSpec.describe Background do
  before :each do
    @image_data = {
      "id": "zSm5JPgNeuc",
      "created_at": "2021-08-16T21:22:29-04:00",
      "updated_at": "2022-06-12T12:22:25-04:00",
      "promoted_at": "2022-02-24T20:24:02-05:00",
      "width": 4392,
      "height": 6588,
      "color": "#d9c0c0",
      "blur_hash": "LaJ@:y%2%fWB~q%2IoaxE1f7M{WV",
      "description": "Boho Girl\n\nModel : @peanutphysique",
      "alt_description": "woman in white tank top sitting on brown wooden chair",
      "urls": {
        "raw": "https://images.unsplash.com/photo-1629163330223-c183571735a1?ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1",
        "full": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1&q=80",
        "regular": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1&q=80&w=1080",
        "small": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1&q=80&w=400",
        "thumb": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1&q=80&w=200",
        "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1629163330223-c183571735a1"
      },
      "links": {
        "self": "https://api.unsplash.com/photos/zSm5JPgNeuc",
        "html": "https://unsplash.com/photos/zSm5JPgNeuc",
        "download": "https://unsplash.com/photos/zSm5JPgNeuc/download?ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI",
        "download_location": "https://api.unsplash.com/photos/zSm5JPgNeuc/download?ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI"
      },
      "categories": [],
      "likes": 91,
      "liked_by_user": false,
      "current_user_collections": [],
      "sponsorship": nil,
      "topic_submissions": {
        "fashion": {
          "status": "approved",
          "approved_on": "2022-05-26T05:35:25-04:00"
        },
        "spirituality": {
          "status": "approved",
          "approved_on": "2022-02-25T12:59:43-05:00"
        }
      },
      "user": {
        "id": "FZ9entlYhv0",
        "updated_at": "2022-06-13T08:24:03-04:00",
        "username": "tayloradaugherty",
        "name": "Taylor Daugherty",
        "first_name": "Taylor",
        "last_name": "Daugherty",
        "twitter_username": nil,
        "portfolio_url": "http://taylordaugherty.com",
        "bio": "IG: Tayloradaugherty\r\n Buy My Presets! https://td-digital-assets.sellfy.store/p/lightroom-fitness-presets/",
        "location": "Saint Petersburg, Florida",
        "links": {
          "self": "https://api.unsplash.com/users/tayloradaugherty",
          "html": "https://unsplash.com/@tayloradaugherty",
          "photos": "https://api.unsplash.com/users/tayloradaugherty/photos",
          "likes": "https://api.unsplash.com/users/tayloradaugherty/likes",
          "portfolio": "https://api.unsplash.com/users/tayloradaugherty/portfolio",
          "following": "https://api.unsplash.com/users/tayloradaugherty/following",
          "followers": "https://api.unsplash.com/users/tayloradaugherty/followers"
        },
        "profile_image": {
          "small": "https://images.unsplash.com/profile-1629165748557-ebeca78a15c3image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=32&h=32",
          "medium": "https://images.unsplash.com/profile-1629165748557-ebeca78a15c3image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=64&h=64",
          "large": "https://images.unsplash.com/profile-1629165748557-ebeca78a15c3image?ixlib=rb-1.2.1&crop=faces&fit=crop&w=128&h=128"
        },
        "instagram_username": "tayloradaugherty",
        "total_collections": 0,
        "total_likes": 0,
        "total_photos": 69,
        "accepted_tos": true,
        "for_hire": true,
        "social": {
          "instagram_username": "tayloradaugherty",
          "portfolio_url": "http://taylordaugherty.com",
          "twitter_username": nil,
          "paypal_email": nil
        }
      },
      "tags": [
        {
          "type": "search",
          "title": "usa"
        },
        {
          "type": "search",
          "title": "co"
        },
        {
          "type": "search",
          "title": "denver"
        }
      ]
    }
  end

  it 'can be initialized with a hash' do
    result = Background.new(@image_data, 'denver,co')

    expect(result).to be_a Background
  end

  it 'has readable attributes' do
    background = Background.new(@image_data, 'denver,co')

    expect(background.location).to eq 'denver,co'
    expect(background.image_url).to eq 'https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzY2Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NTUxMzE4MzI&ixlib=rb-1.2.1&q=80' 
    expect(background.source).to eq 'unsplash.com'
    expect(background.author).to eq 'Taylor Daugherty'
  end
end
