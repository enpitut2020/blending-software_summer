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
    if @return["ans"].length == 0 then
      flash[:already_searched] = "検索結果が見つかりませんでした．別のキーワードで検索してください．"
      redirect_to action: :new
    end
  end

  def details
    id = params[:id]
    id[1] = 'U'
    @youtube = "https://www.youtube.com/embed/?list=" + params[:id]
  end

end