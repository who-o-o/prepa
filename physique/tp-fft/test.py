import numpy as np
from matplotlib import pyplot as plt
from math import sqrt
f0 = 1 #fréquence du signal (Hz)
fe = 10 #fréquence d'échantillonnage
N = 1000 #nombre d'échantillons

t_continu = np.linspace(0,(N-1)/fe,50000) #tableau des dates du signal"continu"
u_continu = 2 + np.sin(2*np.pi*f0*t_continu) + 0.5*np.sin(4*np.pi*f0*t_continu) + 0.2*np.sin(6*np.pi*f0*t_continu)#tableau du signal "continu"

t_discret = np.linspace(0,(N-1)/fe,N)
u_discret = 2 + np.sin(2*np.pi*f0*t_discret) + 0.5*np.sin(4*np.pi*f0*t_discret) + 0.2*np.sin(6*np.pi*f0*t_discret)  #tableau du signal échantillonné   
#u_discret = 5*np.sign(np.sin(2*np.pi*f0*t_discret))
freq = np.linspace(0.0,(N-1)*fe/N,N)    #tableau des fréquences échantillonnées

plt.figure()
plt.subplot(121)
plt.plot(t_continu,u_continu,'k-') #graphe signal continu 
plt.plot(t_discret,u_discret,'bo')     #graphe signal échantillonné
plt.xlim(0,2)
plt.xlabel('t   (s)')
plt.ylabel('amplitude (V)')

fft = np.fft.fft(u_discret)
fig2 = plt.subplot(122)
fig2.plot(freq,fft,'r-')
plt.show()