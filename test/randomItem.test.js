const randomItem = require('../helpers/randomItem');

test('get() uses provided random function', () => {
    const arr = ['one', 'two', 'three'];
    const actual1 = randomItem.get(arr, () => 0.1);
    const actual2 = randomItem.get(arr, () => 0.5);
    const actual3 = randomItem.get(arr, () => 0.9);
    expect(actual1).toBe('one');
    expect(actual2).toBe('two');
    expect(actual3).toBe('three');
});
