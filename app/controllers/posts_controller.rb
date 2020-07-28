class PostsController < ApplicationController
  def new
    ret = {"edge":[[{"channel_id":"AAA","channel_name":"case1","home_url":"https://www.youtube.com/1" },{"channel_id":"BBB","channel_name":"case2","home_url":"https://www.youtube.com/2" }],[{"channel_id":"AAA","channel_name":"case1","home_url":"https://www.youtube.com/1" },{"channel_id":"CCC","channel_name":"case3","home_url":"https://www.youtube.com/3" }],[{"channel_id":"CCC","channel_name":"case3","home_url":"https://www.youtube.com/3 "},{"channel_id":"BBB","channel_name":"case2","home_url":"https://www.youtube.com/2" }],[{"channel_id":"CCC","channel_name":"case3","home_url":"https://www.youtube.com/3 "},{"channel_id":"DDD","channel_name":"case4","home_url":"https://www.youtube.com/4 "}]]}

    node_seed = {}
    node_full_seed = {}
    edge = []
    ret[:edge].each do |n|
      node_seed[n[0][:channel_id]] = n[0][:channel_name]
      node_seed[n[1][:channel_id]] = n[1][:channel_name]
      node_full_seed[n[0][:channel_id]] = n[0]
      node_full_seed[n[1][:channel_id]] = n[1]
      edge.push({:from=>n[0][:channel_id], :to=>n[1][:channel_id]})
    end
    node = []
    node_seed.each do |k,v|
      node.push({:id=>k,:label=>v,color:'#4285F4'})
    end

    gon.edge = edge
    gon.node = node
    gon.node_full = node_full_seed
  end

  def search
    redirect_to action: :result,search:params[:search]
  end

  def result
    # @input = params[:search]

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
    id = params[:channel]["channel_id"]
    id[1] = 'U'
    @youtube = "https://www.youtube.com/embed/?list=" + id
    @channel = params[:channel]
    @channel["channel_description"] = @channel["channel_description"].gsub('"', '').gsub('\n', '<br>')
    @channel["subscriberCount"] = @channel["subscriberCount"].to_i.to_s(:delimited)
    @channel["videoCount"] = @channel["videoCount"].to_i.to_s(:delimited)
    @channel["viewCount"] = @channel["viewCount"].to_i.to_s(:delimited)
  end

end