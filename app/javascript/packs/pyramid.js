import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

document.addEventListener('DOMContentLoaded', () => {

  let technology_vector = {};
  let technology_nodes = new Array;
  let pyramid = new Array;

  technology_nodes = document.getElementById('hierarcky-1').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_vector = {};
  technology_nodes = [];

  technology_nodes = document.getElementById('hierarcky-2').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_vector = {};
  technology_nodes = [];

  technology_nodes = document.getElementById('hierarcky-3').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_vector = {};
  technology_nodes = [];

  technology_nodes = document.getElementById('hierarcky-4').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_vector = {};
  technology_nodes = [];

  technology_nodes = document.getElementById('hierarcky-5').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_vector = {};
  technology_nodes = [];

  let ends;
  let line;
  pyramid.forEach(hierarcky => Object.keys(hierarcky).forEach(function(start){
    ends = hierarcky[start]
    ends.forEach(end =>
      line = new LeaderLine(
        document.getElementById(`${start}`),
        document.getElementById(`${end}`),
        {dash: {animation: true}, size: 4, startSocket: 'bottom', endSocket: 'top', path: 'straight' },
      )
    )
  }));
});