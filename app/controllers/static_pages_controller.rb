class StaticPagesController < ApplicationController
  def home
    # デモの際の高速化のためにAPI呼び出しからファイル読み込みに変更
    # res = Net::HTTP.get_response(URI.parse('https://youtuber-search-api.herokuapp.com/network_edge_data'))
    # ret = JSON.parse(res.body)

    res = ""
    File.open(File.join(Rails.root, 'db', 'demo.txt')) do |file|
      file.each_line do |l|
        res = l
      end
    end
    ret = JSON.parse(res)

    st = Time.now
    # degree = Hash.new(0)
    node_seed = {}
    node_full_seed = {}
    edge = []
    node = []
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
    node_seed.each do |k, v|
      node.push({:id => k, :label => v[1..-2], shape: "circularImage", image: node_full_seed[k]["thumbnail_url"], value: (degree[k] + 100) * 70, color: '#FFFFFF'})
    end

    gon.edge = edge
    gon.node = node
    gon.node_full = node_full_seed
  end

  def help
  end
end
