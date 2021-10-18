
## This code is an alternative to the other .sage files, which do the same 
## things, but in a slightly different way.


def listIntersectionSize(l1,l2):
    lint = [x for x in l1 if x in l2]
    return len(lint)

# flip graph of $K_{2n}

def perfectMatchingGraph(n):
    g = graphs.CompleteGraph(2*n)
    pms = list(g.perfect_matchings())
    for pm in pms:
        pm.sort()
    pms.sort()
    flipGraph = Graph(len(pms))
    for x in range(len(pms)):
        for y in range(x+1,len(pms)):
            if listIntersectionSize(pms[x],pms[y]) == n-2:
                flipGraph.add_edge(x,y)
    return (pms,flipGraph)


## Signed Reversal Graph

# produces a list of signed permutations
# where all signings of a permutation
# are contiguous in the list. Here
# s denotes the signing, and p the permutation
    
def signedPermutations(n):
    signed_perms = []
    for p in Permutations(range(1,n+1)):       
        for s in range(2^n):
            pcopy = [x for x in p]
            for i in range(n):
                if ((s & 2^i) > 0):
                    pcopy[i] = -pcopy[i]
            signed_perms.append(pcopy)
    return signed_perms

# produces the permutation obtained
# from perm by reversing and sign-flipping
# the interval perm[x]..perm[y] inclusive.

def reversal(perm,x,y):
    rperm = []
    for i in range(len(perm)):
        if i < x or i > y:
            rperm.append(perm[i])
        else:
            rperm.append(-perm[y - (i-x)])
    return rperm    

# defines the entire SR graph by taking every
# reversal of every signed permutation and locating 
# it in the list of signed permutations. This could
# probably be done more quickly using suitable 
# ranking and unranking functions, but we can only 
# do small graphs anyway.

def SRGraph(n):   
    signed_perms = signedPermutations(n)
    g = Graph(len(signed_perms))
    for i in range(len(signed_perms)):
        for j in range(n):
            for k in range(j,n):
                sperm = reversal(signed_perms[i],j,k)
                g.add_edge(i,signed_perms.index(sperm))
    return g 
