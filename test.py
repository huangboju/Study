
x = 10

if x < 10:
    print("hahah")
elif x > 10:
    print("bbbb")
else:
    print("aaa")

words = ['cat', 'window', 'defenestrate']

for w in words:
    print(w, len(w))


squares = list(map(lambda x: x**2, range(10)))
squares1 = [x**2 for x in range(10)]
arr = [(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
print(squares, arr)

def fib(n):
    a = 0
    b = 1
    while a < n:
        print(a)
        a, b = b, a + b

fib(100)

def bubble_sort(array):
    while True:
        swaped = False

        for i in range(1, len(array)):
            if array[i - 1] > array[i]:
                array[i - 1], array[i] = array[i], array[i - 1]
                swaped = True

        if not swaped:
            break
    return array

print(bubble_sort([1, 6, 2, 3, 4, 11, 7]))

def insertionSort(array):
    for i in range(1, len(array)):
        y = i
        while (y > 0) and (array[y] < array[y - 1]):
            array[y - 1], array[y] = array[y], array[y - 1]
            y -= 1

    return array



def shell_sort(arr):
    step = round(len(arr) / 2)

    while step > 0:

        for i in range(0, len(arr), step):
            while i > 0 and i < len(arr) and arr[i - step] > arr[i]:
                arr[i - step], arr[i] = arr[i], arr[i - step]
                i -= step

        step = round(step / 2)
    return arr

print(shell_sort([1, 6, 2, 3, 4, 11, 7]))


def selection_sort(arr):

    for i in range(len(arr)):
        temp = i
        for j in range(i+1, len(arr)):
            if arr[i] < arr[j]:
                i = j

        if temp != i:
            arr[i], arr[j] = arr[j], arr[i]


print(selection_sort([1, 6, 2, 3, 4, 11, 7]))



class MyError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)



try:
    raise MyError(2*2)
except MyError as e:
    print('My exception occurred, value:', e.value)


class Error(Exception):
    """Base class for exceptions in this module."""
    pass


class InputError(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression, message):
        self.expression = expression
        self.message = message


class TransitionError(Error):
    """Raised when an operation attempts a state transition that's not
    allowed.

    Attributes:
        previous -- state at beginning of transition
        next -- attempted new state
        message -- explanation of why the specific transition is not allowed
    """

    def __init__(self, previous, next, message):
        self.previous = previous
        self.next = next
        self.message = message



# try:
#     raise KeyboardInterrupt
# finally:
#     print('Goodbye, world!')


def scope_test():
    def do_local():
        spam = "local spam"
    def do_nonlocal():
        nonlocal spam
        spam = "nonlocal spam"
    def do_global():
        global spam
        spam = "global spam"
    spam = "test spam"
    do_local()
    print("After local assignment:", spam)
    do_nonlocal()
    print("After nonlocal assignment:", spam)
    do_global()
    print("After global assignment:", spam)

scope_test()
print("In global scope:", spam)


class ClassName(object):
    """My first class"""
    i = 12345
    def f():
        return 'hello world'

    def __init__(self, a, b):
        print("hahah")
        self.a = a
        self.b = b

print(ClassName.i, ClassName.f(), ClassName.__doc__)

myclass = ClassName(1, 2)
print(myclass.a, myclass.b)


myclass.counter = 1
while myclass.counter < 10:
    myclass.counter = myclass.counter * 2
print(myclass.counter)
del myclass.counter



import os
print(os.getcwd())
print(os.system('mkdir today'))
