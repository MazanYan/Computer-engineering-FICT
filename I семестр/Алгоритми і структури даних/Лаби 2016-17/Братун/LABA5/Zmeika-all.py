def output(a,n):
    """Output of the matrix"""
    for i in range(n):
        print("(", end="")
        for j in range(n):
            print("{:3}".format(a[i][j]), end="")
        print(")")

n=int(input("Input the size of the matrix: "))
a=[]
for i in range(n):
    a.append([])
    for j in range(n):
        a[i].append(0)
p=n-1

a[0][0]=1
i=2
for k in range(p):
    for j in range(k+2):
        if k%2==0:
            a[k+1-j][j]=i
            i+=1
        else:
            a[j][k+1-j]=i
            i+=1

for b in range(k-1,-1,-1):
    for j in range(b+2):
        if b%2==0:
            a[n-1-j][j+k-b]=i
            i+=1
        else:
            a[j+k-b][n-1-j]=i
            i+=1
a[n-1][n-1]=i
output(a,n)
