import numpy as np

def polyphase_core(x, m, f):
    #x = input data
    #m = decimation rate
    #f = filter
    #Hack job - append zeros to match decimation rate
    if x.shape[0] % m != 0:
        x = np.append(x, np.zeros((m - x.shape[0] % m,)))
    if f.shape[0] % m != 0:
        f = np.append(f, np.zeros((m - f.shape[0] % m,)))
    polyphase = p = np.zeros((m, (x.shape[0] + f.shape[0]) // m), dtype=x.dtype)
    p[0, :-1] = np.convolve(x[::m], f[::m])
#    print("outside for loop\n x[::m], f[::m],p[0, :-1]=",x[::m], f[::m],p[0, :-1])
    #Invert the x values when applying filters
#    print("inside for loop")
    for i in range(1, m):
#        print("i=",i)
#        print("x[m - i::m]= ",x[m - i::m])
#        print("f[i::m]= ",f[i::m])
#        print(np.convolve(x[m - i::m], f[i::m]))
#        print("\n")
        p[i, 1:] = np.convolve(x[i::m], f[m-i::m])
#    print(p)    
    return p

def polyphase_single_filter(x, m, f):
    n = len(x) - (len(x) % m)
    x = np.array(x[0:n])
    f = np.array(f)
    p = polyphase_core(x, m, f)
    ans = np.zeros((1,len(p[0])))
    for i in range(len(p)):
      ans += p[i]
    return ans[0]

input_file = open("build/input_file.txt",'w')
output_file = open("build/output_file.txt",'w')

input_len = 16
taps_len = 16
num_tests = 10000

np.set_printoptions(linewidth=1000)

def StrNpArray(a):
    s=""
    for i in a:
        s += str(i) + " "
    return s[:-1] + "\n"

for i in range(num_tests):
  x  = np.random.rand(input_len) * 100
  m = 2 #np.random.randint(len(x)-3) + 2
  t = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
  y = polyphase_single_filter(x,m,t)
  input_file.writelines(StrNpArray(x))
  output_file.writelines(StrNpArray(y))

input_file.close()
output_file.close()

#t = np.random.randint(100,size=(taps_len))
