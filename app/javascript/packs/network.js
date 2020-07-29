import vis from 'visjs-network';

var nodes = new vis.DataSet(gon.node);
var edges = new vis.DataSet(gon.edge);
var container = document.getElementById('network');
var data = { nodes: nodes, edges: edges };
var options = {
    physics: {
      forceAtlas2Based: {
        gravitationalConstant: -26,
        centralGravity: 0.005,
        springLength: 100,
        springConstant: 0.18,
      },
      maxVelocity: 146,
      solver: "forceAtlas2Based",
      timestep: 0.35,
      stabilization: { iterations: 150 },
    },
  };

var network = new vis.Network(container, data, options);
