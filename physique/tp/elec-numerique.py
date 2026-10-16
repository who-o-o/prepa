import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

#avec 200 points le signal est visiblement légèrement trapézoïde
t_e = np.linspace(0, 0.02, 2000, endpoint=False) 
t = np.linspace(0, 0.02, 200, endpoint=False)

T = 3e-3
f = 1/T
omega_c = 200
T_e = 0.02/200
H_0 = 0.5

e = signal.square(2 * np.pi * f * t_e, duty=2/3)
e = ((e+1)*4.5)/2

#e a 10x plus de points
def recurrence(s, n, res):
    return (1-omega_c*T_e)*s[n] + H_0 * T_e * omega_c * e[n*res]

def u_s(l):
    s = np.zeros(l)
    s[0] = 1
    n = 2000//l
    for i in range(0, l-1):
        s[i+1] = (1-omega_c*T_e)*s[i] + H_0 * T_e * omega_c * e[i*n]
    return s

s_1 = u_s(200)
s_2 = u_s(2000)


plt.plot(t_e, e)
plt.plot(t, s_1)
plt.plot(t_e, s_2)

plt.title("Filtrage passe-bas du signal créneau")
plt.xlabel("t (s)")
plt.ylabel("Amplitude (V)")

plt.ylim(-0.2, 5)

plt.legend(['signal entrée', 'signal filtré N = 200', 'signal filtré N = 2000'], loc="upper left") 

plt.grid()
plt.show()