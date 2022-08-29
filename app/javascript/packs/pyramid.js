import { LeaderLine } from 'exports-loader?exports=LeaderLine!leader-line/leader-line.min.js';

// 本題とは関係ないが、ページが pyramid.js を読み込む時点では
// start と end の要素が存在しないので元のコードではエラーになる。
// ページロード完了時に実行するように変える。
document.addEventListener('DOMContentLoaded', () => {
  new LeaderLine(
  document.getElementById('start'),
  document.getElementById('end'));
});