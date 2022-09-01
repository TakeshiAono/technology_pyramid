import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

// 本題とは関係ないが、ページが pyramid.js を読み込む時点では
// start と end の要素が存在しないので元のコードではエラーになる。
// ページロード完了時に実行するように変える。
document.addEventListener('DOMContentLoaded', () => {
  // let technology_2 = Array.from(document.getElementsByClassName('technology-2'));
  // const array_technology_2 = [];
  // technology_2.forEach(node => array_technology_2.push(node.dataset.upperTechnologies.match(/\d+/g)));
  // console.log(array_technology_2);

  let technology_vector = {};
  let technology_nodes = new Array;
  let pyramid = new Array;

  technology_nodes = document.getElementById('hierarcky-1').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  // pyramid = Array(document.getElementById('top_technology').dataset.lowerTechnologies.match(/\d+/g));
  // pyramid = Array(document.getElementById('top_technology').dataset.lowerTechnologies.match(/\d+/g));
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
  technology_nodes = [];
  technology_vector = {};

  technology_nodes = document.getElementById('hierarcky-4').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_nodes = [];
  technology_vector = {};

  technology_nodes = document.getElementById('hierarcky-5').children;
  technology_nodes = Array.from(technology_nodes);
  technology_nodes.forEach(technology_node => technology_vector[`${technology_node.id}`] = technology_node.dataset.lowerTechnologies.match(/\d+/g));
  pyramid.push(technology_vector)
  technology_nodes = [];
  technology_vector = {};


  console.log(pyramid);

  let ends
  pyramid.forEach(hierarcky => Object.keys(hierarcky).forEach(function(start){
      console.log(start)
      ends = hierarcky[start]
      console.log(ends)
      ends.forEach(end =>
        new LeaderLine(
          document.getElementById(`${start}`),
          document.getElementById(`${end}`)
        )
      )

      // new LeaderLine(
      // document.getElementById(`${start}`),
      // document.getElementById(`${end}`))
  }));



});