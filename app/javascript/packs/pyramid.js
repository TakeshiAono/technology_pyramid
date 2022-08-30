import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

// 本題とは関係ないが、ページが pyramid.js を読み込む時点では
// start と end の要素が存在しないので元のコードではエラーになる。
// ページロード完了時に実行するように変える。
document.addEventListener('DOMContentLoaded', () => {
  let technology_2 = Array.from(document.getElementsByClassName('technology-2'));
  const array_technology_2 = [];
  technology_2.forEach(node => array_technology_2.push(node.dataset.upperTechnologies.match(/\d+/g)));
  console.log(array_technology_2);

  [0].dataset.upperTechnologies;
  technology_2 = technology_2.match(/\d+/g);


  new LeaderLine(
  document.getElementById('element-1'),
  // document.getElementById('end');
  document.getElementById('element-2'));

  new LeaderLine(
  document.getElementById('element-2'),
  // document.getElementById('end');
  document.getElementById('element-3'));

  new LeaderLine(
  document.getElementById('element-2'),
  // document.getElementById('end');
  document.getElementById('technology1'));

  // new LeaderLine(
  // document.getElementById('element-2'),
  // document.getElementById('end');
  // document.getElementById('technology2'));

  // new LeaderLine(
  // document.getElementById('element-1'),
  // // document.getElementById('end');
  // document.getElementById('element-3'));

});