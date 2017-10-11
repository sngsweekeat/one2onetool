exports.rnd = Math.random;

exports.get = function(arr, rndFunc) {
    var rndFunc = rndFunc || exports.rnd;
    return arr[Math.floor(rndFunc()*arr.length)];    
}

exports.getIndex = function(upper) {
    var rndFunc = rndFunc || exports.rnd;
    return Math.floor(rndFunc()*upper);
}