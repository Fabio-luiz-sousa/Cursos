import numpy 
l=[9.3,8.8,6.8,8.7,8.5,6.7,8.0,6.5,9.2,7.0]
l2=[11.0,9.8,9.9,10.2,10.1,9.7,11.0,11.1,10.2,9.6]
media=numpy.mean(l)
print(media)

def variancia(lista,media):
    s1=0
    for num in lista:
        s1+=(num-media)**2
    s=s1/9
    print(s)

variancia(l,7.95)
variancia(l2,10.26)