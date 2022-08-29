import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

// 本題とは関係ないが、ページが pyramid.js を読み込む時点では
// start と end の要素が存在しないので元のコードではエラーになる。
// ページロード完了時に実行するように変える。
document.addEventListener('DOMContentLoaded', () => {
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