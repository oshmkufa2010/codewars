import types
from functools import reduce

def create_number_class(alphabet):
    base = len(alphabet)
    base_numbers = {}

    for i in range(base): base_numbers[alphabet[i]] = i
       
    to_int = lambda s: reduce(lambda x, y: base*x + y, map(lambda n: base_numbers[n], s)) if len(s) > 0 else 0

    def convert_base(num, alphabet):
        if num == 0: return alphabet[0]
        base = len(alphabet)
        strs = ''
        while num:
            n = num % base
            num = int(num / base)
            strs = alphabet[n] + strs
        return strs

    def convert_to(self, cls):
        return convert_base(to_int(self.number), cls.alphabet)

    def calculate(self, obj, op):
        left, right = to_int(self.number), to_int(obj.number)
        result = op(left, right)
        return cls(convert_base(result, alphabet))

    def __init__(self, number):
        self.number = number

    cls_dict = {
        "alphabet": alphabet,
        "convert_to": convert_to,
        "__str__": lambda self: self.number if len(self.number) > 0 else alphabet[0],
        "__init__": __init__,
        "__add__": lambda self, obj: calculate(self, obj, lambda x, y: x + y),
        "__sub__": lambda self, obj: calculate(self, obj, lambda x, y: x - y),
        "__mul__": lambda self, obj: calculate(self, obj, lambda x, y: x * y),
        "__floordiv__": lambda self, obj: calculate(self, obj, lambda x, y: int(x / y))
    }
    
    cls = types.new_class(alphabet, (), {}, lambda ns: ns.update(cls_dict))
    cls.__module__ = __name__
    return cls


BinClass = create_number_class('01')
HexClass = create_number_class('0123456789ABCDEF')
x = HexClass('')
y = HexClass('AA')
print(x)
print(x+y)
print(x-y)