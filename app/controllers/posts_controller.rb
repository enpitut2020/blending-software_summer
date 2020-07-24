class PostsController < ApplicationController
  def new
  end

  def search
    redirect_to action: :result,search:params[:search]
  end

  def result
    @input = params[:search]
    @return = JSON.parse('{
      "001": {
        "channel_name": "HikakinTV",
        "home_url": "www@wwww",
        "thumbnail_url": "aaa@@@",
        "rank_order": 1
      },
      "002": {
        "channel_name": "Hajime",
        "home_url": "hhh@hhhh",
        "thumbnail_url": "bbb@@@@",
        "rank_order": 2
      }
    }')
  end
end