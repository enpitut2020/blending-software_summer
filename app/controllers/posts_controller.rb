class PostsController < ApplicationController
  def new
  end

  def search
    redirect_to action: :result,search:params[:search]
  end

  def result
    @input = params[:search]
    @return = JSON.parse('{
      "97361d18": {
        "channel_name": "兄者弟者",
        "home_url": "https://www.youtube.com/user/norunine/videos",
        "thumbnail_url": "aaa@@@",
        "rank_order": 1
      },
      "29197914": {
        "channel_name": "おついちTube",
        "home_url": "https://www.youtube.com/channel/UC6KnFuHBByTI20VENcsoNjg",
        "thumbnail_url": "bbb@@@@",
        "rank_order": 2
      },
      "a8acebac": {
        "channel_name": "SANNINSHOW",
        "home_url": "https://www.youtube.com/user/sanninshow",
        "thumbnail_url": "aaa@@@",
        "rank_order": 1
      },
      "2e2619a3": {
        "channel_name": "わがねこチャンネル",
        "home_url": "https://www.youtube.com/channel/UC2GuiBNUazRVJv4xmnlcaPA",
        "thumbnail_url": "aaa@@@",
        "rank_order": 1
      },
      "ba280b05": {
        "channel_name": "草の人",
        "home_url": "https://www.youtube.com/channel/UC9WMsQHOevJPa7tAIRAri7g",
        "thumbnail_url": "aaa@@@",
        "rank_order": 1
      }
    }')
  end

  def details
  end
  
end