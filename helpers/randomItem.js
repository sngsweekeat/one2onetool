exports.rnd = Math.random;

exports.get = function(arr, rndFunc) {
    rndFunc = rndFunc || exports.rnd;
    return arr[Math.floor(rndFunc()*arr.length)];    
}