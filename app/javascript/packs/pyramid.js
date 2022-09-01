import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

// 本題とは関係ないが、ページが pyramid.js を読み込む時点では
// start と end の要素が存在しないので元のコードではエラーになる。
// ページロード完了時に実行するように変える。
document.addEventListener('DOMContentLoaded', () => {
  // let technology_2 = Array.from(document.getElementsByClassName('technology-2'));
  // const array_technology_2 = [];
  // technology_2.forEach(node => array_technology_2.push(node.dataset.upperTechnologies.match(/\d+/g)));
  // console.log(array_technology_2);

  let pyramid = Array(document.getElementById('top_technology').dataset.lowerTechnologies.match(/\d+/g));

  let technology_array = new Array;
  let technology_nodes = new Array;

  technology_nodes = document.getElementById('hierarcky-2').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_array.push(technology_node.dataset.lowerTechnologies.match(/\d+/g)));
  pyramid.push(technology_array)
  technology_nodes = [];
  technology_array = [];

  technology_nodes = document.getElementById('hierarcky-3').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => 
    technology_array.push(technology_node.dataset.lowerTechnologies.match(/\d+/g)));
  pyramid.push(technology_array)
  technology_nodes = [];
  technology_array = [];

  technology_nodes = document.getElementById('hierarcky-4').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => 
    technology_array.push(technology_node.dataset.lowerTechnologies.match(/\d+/g)));
  pyramid.push(technology_array)
  technology_nodes = [];
  technology_array = [];

  technology_nodes = document.getElementById('hierarcky-5').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => 
    technology_array.push(technology_node.dataset.lowerTechnologies.match(/\d+/g)));
  pyramid.push(technology_array)
  technology_nodes = [];
  technology_array = [];


  console.log(pyramid);





  new LeaderLine(
  document.getElementById('top_technology'),
  document.getElementById('element2-1'));
  });