exports.rnd = Math.random;

exports.get = function get(arr, rndFunc) {
  const random = rndFunc || exports.rnd;
  return arr[Math.floor(random() * arr.length)];
};

exports.getIndex = function getIndex(upper, rndFunc) {
  const random = rndFunc || exports.rnd;
  return Math.floor(random() * upper);
};
