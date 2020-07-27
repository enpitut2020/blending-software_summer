class PostsController < ApplicationController
  def new
  end

  def search
    redirect_to action: :result,search:params[:search]
  end

  def result
    @input = params[:search]

    # SQLを実行するためにはサニタイズが必要

    res = Net::HTTP.post_form(URI.parse('https://youtuber-search-api.herokuapp.com/recommended_channels'), {'channel_name' => params[:search]})
    # responseのbody要素をJSON形式で解釈し、hashに変換
    @return = JSON.parse(res.body)
  end
end