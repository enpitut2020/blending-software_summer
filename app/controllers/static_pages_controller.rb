class StaticPagesController < ApplicationController
  def home
    ret2 = {"edge": [[{"channel_id": "AAA", "channel_name": "case1", "home_url": "https://www.youtube.com/1"}, {"channel_id": "BBB", "channel_name": "case2", "home_url": "https://www.youtube.com/2"}], [{"channel_id": "AAA", "channel_name": "case1", "home_url": "https://www.youtube.com/1"}, {"channel_id": "CCC", "channel_name": "case3", "home_url": "https://www.youtube.com/3"}], [{"channel_id": "CCC", "channel_name": "case3", "home_url": "https://www.youtube.com/3 "}, {"channel_id": "BBB", "channel_name": "case2", "home_url": "https://www.youtube.com/2"}], [{"channel_id": "CCC", "channel_name": "case3", "home_url": "https://www.youtube.com/3 "}, {"channel_id": "DDD", "channel_name": "case4", "home_url": "https://www.youtube.com/4 "}]]}

    res = Net::HTTP.get_response(URI.parse('https://youtuber-search-api.herokuapp.com/network_edge_data'))

    ret = JSON.parse(res.body)
    # degree = Hash.new(0)
    node_seed = {}
    node_full_seed = {}
    edge = []
    degree = Hash.new(0)
    ret["edge"].each do |n|
      degree[n[0]["channel_id"]] += 1
      degree[n[1]["channel_id"]] += 1
      node_seed[n[0]["channel_id"]] = n[0]["channel_name"]
      node_seed[n[1]["channel_id"]] = n[1]["channel_name"]
      node_full_seed[n[0]["channel_id"]] = n[0]
      node_full_seed[n[1]["channel_id"]] = n[1]
      edge.push({:from => n[0]["channel_id"], :to => n[1]["channel_id"]})
    end
    node = []
    node_seed.each do |k, v|
      node.push({:id => k, :label => v[1..-2], shape: "circularImage", image: node_full_seed[k]["h_thumbnail_url"], value: (degree[k] + 100) * 70, color: '#FFFFFF'})
    end

    gon.edge = edge
    gon.node = node
    gon.node_full = node_full_seed
  end

  def help
  end
end
