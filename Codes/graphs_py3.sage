import itertools

def symdiff(a, b):
    # function takes in two vertices (perfect matchings represented as list of unordered pairs) and returns the symmetric difference of the two vertices
    temp = []
    temp1 = b[:]
    for i in a:
        temp1.remove(i) if i in temp1 else temp.append(i)
    for j in temp1:
        temp.append(j)
    return temp

def reverse_string(string):
    # function takes in a string and returns the string, reversed 
    return string[::-1]

def reversal_graph_adjacency(a, b):
    # checks if two vertices are connected in the reversal graph
    # the vertices are permutations of [n]
    n = len(a)
    for j in range(0, n):
        for i in range(2, n-j+1):
            if b == a[0:j] + reverse_string(a[j:i+j]) + a[i+j::]:
                return 1
    return 0

def signed_reversal_graph_adjacency(a, b):
    # checks if two vertices are connected in the signed reversal graph
    # the vertices are represented as an ordered list of two strings, with the zero-th element being a permutation of [n] and the first element being a 01-string corresponding to the zero-th element    
    n = len(a[0])
    for j in range(0, n):
        for i in range(1, n-j+1):
            if b[0] == a[0][0:j] + reverse_string(a[0][j:i+j]) + a[0][i+j::]:
                if b[1] == a[1][0:j] + reverse_string(a[1][j:i+j]).translate(str.maketrans("10", "01")) + a[1][i+j::]:
                    return 1
    return 0 

def cover_of_reversal_graph_adjacency(a, b):
    for j in range(0, len(a[0])):
        for i in range(2, len(a[0])-j+1):
            if b[0] == a[0][0:j] + reverse_string(a[0][j:i+j]) + a[0][i+j::]:
                if b[1] == a[1][0:j] + reverse_string(a[1][j:i+j]).translate(str.maketrans("10", "01")) + a[1][i+j::]:
                    return 1
    return 0

def pancake_graph_adjacency(a, b):
    n = len(a)
    for i in range(2, n+1):
        if b == reverse_string(a[0:i]) + a[i::]:
            return 1
    return 0

def burnt_pancake_graph_adjacency(a, b):
    for i in range(1, len(a[0])+1):
        if b[0] == reverse_string(a[0][0:i]) + a[0][i::]:
            if b[1] == reverse_string(a[1][0:i]).translate(str.maketrans("10", "01")) + a[1][i::]:
                return 1
    return 0

def cover_of_pancake_graph_adjacency(a, b):
    for i in range(2, len(a[0])+1):
        if b[0] == reverse_string(a[0][0:i]) + a[0][i::]:
            if b[1] == reverse_string(a[1][0:i]).translate(str.maketrans("10", "01")) + a[1][i::]:
                return 1
    return 0
	

def reversal_graph(n):	
    H= range(1, n+1)
    vertices=[]
    for i in itertools.permutations(H, int(n)):
        vertices.append("".join(str(x) for x in list(i)))
    Rn = Graph()
    for i in itertools.combinations(vertices, 2):
        if reversal_graph_adjacency(i[0], i[1]):
            Rn.add_edge(i[0], i[1])
    return Rn 
    
def pancake_graph(n):	
    H= range(1, n+1)
    vertices=[]
    for i in itertools.permutations(H, int(n)):
        vertices.append("".join(str(x) for x in list(i)))
    Pn=Graph()
    for i in itertools.combinations(vertices, 2):
        if pancake_graph_adjacency(i[0], i[1]):
            Pn.add_edge(i[0], i[1])
    return Pn

def signed_reversal_graph(n):
    H= range(1,n+1)
    vertices=[]
    W = Words(alphabet='01', length = n)
    for i in itertools.permutations(H, int(n)):
        i = ["".join(str(x) for x in list(i))]
        for j in W:
            vertices.append([i[0], str(j)])
    SRn = Graph()
    for i in itertools.combinations(vertices,2):
        if signed_reversal_graph_adjacency(i[0],i[1]):
            SRn.add_edge(tuple(i[0]),tuple(i[1]))
    return SRn

def burnt_pancake_graph(n):
    H= range(1,n+1)
    vertices=[]
    W = Words(alphabet='01', length = n)
    for i in itertools.permutations(H, int(n)):
        i = ["".join(str(x) for x in list(i))]
        for j in W:
            vertices.append([i[0], str(j)])
    BPn = Graph()
    for i in itertools.combinations(vertices,2):
        if burnt_pancake_graph_adjacency(i[0],i[1]):
            BPn.add_edge(tuple(i[0]),tuple(i[1]))
    return BPn    
    
def cover_of_pancake_graph(n):
    H= range(1,n+1)
    vertices=[]
    W = Words(alphabet='01', length = n)
    for i in itertools.permutations(H, int(n)):
        i = ["".join(str(x) for x in list(i))]
        for j in W:
            vertices.append([i[0], str(j)])
    CPn = Graph()
    for i in itertools.combinations(vertices,2):
        if cover_of_pancake_graph_adjacency(i[0],i[1]):
            CPn.add_edge(tuple(i[0]),tuple(i[1]))
    return CPn    

def cover_of_reversal_graph(n):
    H= range(1,n+1)
    vertices=[]
    W = Words(alphabet='01', length = n)
    for i in itertools.permutations(H, int(n)):
        i = ["".join(str(x) for x in list(i))]
        for j in W:
            vertices.append([i[0], str(j)])
    CRn = Graph()
    for i in itertools.combinations(vertices,2):
        if cover_of_reversal_graph_adjacency(i[0],i[1]):
            CRn.add_edge(tuple(i[0]),tuple(i[1]))
    return CRn
   
print('Available commands are:\n reversal_graph(n),\n cover_of_reversal_graph(n),\n signed_reversal_graph(n),\n pancake_graph(n),\n cover_of_pancake_graph(n),\n burnt_pancake_graph(n)')       