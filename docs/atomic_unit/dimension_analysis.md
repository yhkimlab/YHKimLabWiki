# Theorytical Background : Atomic unit

The atomic units are a system of natural units of measurement that is especially convenient for calculations in atomic physics and related scientific fields, such as computational chemistry and atomic spectroscopy. They were originally suggested and named by the physicist Douglas Hartree.
[[1]][link]

[link]: https://www.semanticscholar.org/paper/The-Wave-Mechanics-of-an-Atom-with-a-Non-Coulomb-I.-Hartree/e2def6250815e08d752fce10740dbbfb7cd5c779

Atomic units are often abbreviated "a.u." or "au"

`atomic unit`은 원자 세계의 계산에 아주 유용한 `natural unit system`이다. 즉 수식에 붙는 갖가지 상수들을 단위로 옮김으로써 (dimension analysis) 수식을 단순화하여 표현 대상이 따르는 물리법칙을 파악하는 데에 도움을 준다.  또한 여러 불필요한 자릿수 계산(e.g. 
$10^{-11} \times 10^{-20} \times10^{8} \times10^{32} \times m/sec$
 ) 등의 연산량을 줄이며, 코딩을 통해 수식을 작성할 때에도 용이하게 해준다.



각종 문헌에서 `a.u.` 또는 `au` 라 표시되는데, 다른 표현(e.g. absorbancee units, arbitrary units, etc) 과 혼동하지 않도록 유의하자.

이외에, 고체 내에서 전자의 이동 속도는 effective velocity로 모델링하며 그 질량 또한 effective mass로 해석하므로 `effective mass unnit (e.u.)`도 흔하게 사용한다.
<br><br>

## 1. Example : Hamiltonian operator


In the context of atomic physics, using the atomic units system can be a convenient shortcut, eliminating unnecessary symbols and numbers with very small orders of magnitude. For example, the Hamiltonian operator in the Schrödinger equation for the helium atom with standard quantities, such as when using SI units, is

$ \hat{H} = -\frac{\hbar^2}{2m_e}{\nabla_1}^2 -\frac{\hbar^2}{2m_e}{\nabla_2}^2 -\frac{2e^2}{4\pi \epsilon_0 r_1} -\frac{2e^2}{4\pi \epsilon_0 r_2} +\frac{e^2}{4\pi \epsilon_0 r_{12}} $

where the kinetic energy is 
$-\frac{\hbar^2}{2m_e}{\nabla}^2$,
and the potential energy (by Coulomb force) term is 
$-\frac{e^2}{4\pi \epsilon_0 r}$.

참고로, 중복되는 potential energy term을 제외해주기 위해 $\frac{e^2}{4\pi \epsilon_0 r_{12}}$을 사용해주었다.

<br>

이 식에서 <br><br>
$m = m_e = 9.109 \times 10^{-31}$

$r = \lambda r'$ 
$(\lambda = \frac{4\pi \epsilon_0 \hbar^2}{m_e{e}^2} = a_0 =  1 Bohr = 5.292 \times 10^{-11}m) , $

$ E = E_a \times E'$
$(E_a = \frac{\hbar}{m_e{a_0}^2} = 2 Rydberg = 1 Hartree )$

이라 하면 해밀토니안에 대한 표현식은 <br><br>
$ \hat{H} = -\frac{1}{2}{\nabla_1}^2 -\frac{1}{2}{\nabla_2}^2 -\frac{2}{r_1'} -\frac{2}{r_2'} +\frac{1}{r_{12}'} $
<br><br>
과 같이 간단하게 표현할 수 있다.


<br><br><br>

## 2. Example : 1-Dimensional Infinite Quantum Well (Time-independent)



길이가 $100 \AA$ 이고 background potential이 0 $eV$  인 1차원 무한 양자 우물에서의 슈뢰딩거 방정식을 풀게 되면
그 Eigenstate와 Eigenvalue는 (간격은 $a = 1 \AA$)

$ \phi _\alpha (x) = \sin( k_\alpha x ) ,$

$ E_\alpha = \hbar^2 {k_\alpha}^2/2m $ where $ k_\alpha = \alpha \pi / L \ \  (\alpha = 1, 2, 3, ...) $
라 쓸 수 있다.

이때 finite difference approximation을 사용하면 Hamiltonian에서 

$  ( \frac{\partial^2 \psi }{\partial x^2} ) _{x=x_n} $
$ = \frac{1}{a^2} [ \ \psi(x_{n+1}) -2\psi(x_{n}) + \psi(x_{n-1}) \  ] $
이므로
<br><br>

$$ [H_{op} \psi] _{x=x_n} $$
$$ = - \frac{\hbar^2 }{2m} ( \frac{\partial^2 \psi }{\partial x^2} ) _{x=x_n} $$
$$ = t_0 [ \ 2\psi(x_{n}) - \psi(x_{n+1})  - \psi(x_{n-1}) \  ] $$

$$ = \displaystyle\sum_{m}^{} t_0 [ \ 2 \delta _{n,m} - \delta _{n+1,m}  - \delta _{n-1,m} \  ] \psi _m $$
$$ \left( = 2 t_0 (1-\cos k_\alpha a) \psi (x_n) \right) $$
이라 쓸 수 있다. $ (t_0 = \frac{\hbar^2 }{2m a^2}) $

이를 `dimension analysis`를 통해 나타내면 
$$ {t_0}' = \frac{1 }{2a^2}$$
$$ [H_{op} \psi] _{x'=x_n'} $$
$$ = -  \frac{1 }{2}( \frac{\partial^2 \psi }{\partial x^2} ) _{x'=x_n'} $$
$$ = {t_0}' [ \ 2\psi(x_{n}') - \psi(x_{n+1}')  - \psi(x_{n-1}') \  ] $$

$$ = \displaystyle\sum_{m}^{} {t_0}' [ \ 2 \delta _{n,m} - \delta _{n+1,m}  - \delta _{n-1,m} \  ] \psi _m $$




아래 코드는 Eigenvalue number $\alpha$ 에 따른 Eigenvalue의 그래프를 그리는 코드이다.

```python
#1d_well.py
import numpy as np
from numpy import linalg as LA 
import matplotlib.pyplot as plt

# from Atomic units to MKS units
AU2Ang = 0.529177210903 #0.5291772083
AU2eV = 27.211386245988 #27.21138344

# Effective mass atomic units
## 현재 시스템은 vacuum에서 free electron이 놓여 있으므로 
## effective mass = free electron mass
meff = 1.   # effective mass 
eps = 1.   # permittivity 
EU2Ang = AU2Ang * eps / meff
EU2eV = AU2eV * meff / eps**2
Ang2EU = 1/EU2Ang
eV2EU = 1/EU2eV

# Input (in EU)
xmin = 0.; xmax = 100.*Ang2EU  # X range [Ang]
nx = 100 # Num. of grid points - 1 

# X lattice
L = xmax - xmin
dx = L/nx   # a
print('L = %.1f [Ang]' % (L*EU2Ang))
print('dx= %.1f [Ang]' % (dx*EU2Ang))
X = dx * np.linspace(0,nx,nx+1)
X = X[1:-1] # Perform calculations only for the box inside region. 
nx = X.size

# Hamiltonian
t0 = 1/(2*dx**2)
T = 2*t0*np.eye(nx) - t0*np.eye(nx,k=+1) - t0*np.eye(nx,k=-1) 

# Diagonalization
E,V   = LA.eigh(T)  # Return the eigenvalues and eigenvectors of a (symmetric real) Hermitian matrix


# Analysis (Visualization)
ieig1 = 1 # index for the 1st eigenvalue/eigenstate to be analyzed
ieig2 = 10 # index for the 2nd eigenvalue/eigenstate to be analyzed 
E1 = E[ieig1-1]; psi1 = V[:,ieig1-1]; P1 = psi1*np.conj(psi1)
E2 = E[ieig2-1]; psi2 = V[:,ieig2-1]; P2 = psi2*np.conj(psi2)
print('Numerical eigenvalue %3i = %.5f [eV]' % (ieig1, E[ieig1-1]*EU2eV))
print('Numerical eigenvalue %3i = %.5f [eV]' % (ieig2, E[ieig2-1]*EU2eV))
#print(sum(P1)); print(sum(P1)) # Check normalization

# Analytical eigenvalues 
Ean = 1/2 * (np.pi/L)**2 * np.arange(1,nx+1)**2
print('Analytic eigenvalue %3i = %.5f [eV]' % (ieig1, Ean[ieig1-1]*EU2eV))
print('Analytic eigenvalue %3i = %.5f [eV]' % (ieig2, Ean[ieig2-1]*EU2eV))

# Analytical eigenstates
nXan = 1000 # Number of grid points for displaying eigenstates
dXan = L/nXan 
Xan = dXan*np.linspace(0,nXan,nXan+1) # Grid stencil **including** box boundary points


psian1 = np.sqrt(2/L) * np.sin(ieig1*np.pi/L*Xan); Pan1 = psian1*np.conj(psian1)
psian2 = np.sqrt(2/L) * np.sin(ieig2*np.pi/L*Xan); Pan2 = psian2*np.conj(psian2)
#print(sum(Pan1)*dXan); print(sum(Pan2)*dXan) # Check normalization



### Visualize
# Numerical vs. Analytical: Check both eigenvalues & eigenstates
fig = plt.figure(figsize=[7,12])
ax1 = fig.add_subplot(3,1,1)
ax2 = fig.add_subplot(3,1,2)
ax3 = fig.add_subplot(3,1,3)

# Numerical vs. Analytical: Eigenvalues
ax1.plot(Ean*EU2eV,'r')
ax1.plot(E*EU2eV,'bx')
ax1.set_xlabel('Eigenvalue number',fontsize = 14)
ax1.set_ylabel('$E$ (eV)',fontsize = 14)
ax1.set_xlim(0,100)
ax1.set_ylim(0,40)
ax1.tick_params(axis='both',which='major',labelsize=15,direction='in')
ax1.text(49,20,'Analytical',fontsize=15)
ax1.text(65,7,'Numerical',fontsize=15)
ax1.grid(color='b', alpha=0.5, ls='--',lw=0.5)

# Numerical vs. Analytical: Eigenstate 1
ax2.plot(Xan*EU2Ang,Pan1*dx,'r') #"dx" is necessary to compare with numerical results. See Eq. (2.3.2).
ax2.plot(X*EU2Ang,P1,'bx-')
ax2.set_xlabel('x [$\AA$]',fontsize = 14)
ax2.set_ylabel('Probability',fontsize = 14)
plt.xlim(0,100)
ax2.tick_params(axis='both',which='major',labelsize=15,direction='in')
ax2.grid(color='b', alpha=0.5, ls='--',lw=0.5)

# Numerical vs. Analytical: Eigenstate 2
ax3.plot(Xan*EU2Ang,Pan2*dx,'r') #"dx" is necessary to compare with numerical results. See Eq. (2.3.2).
ax3.plot(X*EU2Ang,P2,'bx-')
ax3.set_xlabel('x [$\AA$]',fontsize = 14)
ax3.set_ylabel('Probability',fontsize = 14)
plt.xlim(0,100)
ax3.tick_params(axis='both',which='major',labelsize=15,direction='in')
ax3.grid(color='b', alpha=0.5, ls='--',lw=0.5)

```


















<br><br><br>
참고자료 : 

Quantum transport: Atom to Transistor, S. Data, CAMBRIDGE, p41

https://en.wikipedia.org/wiki/Atomic_units

https://en.wikipedia.org/wiki/Natural_units

[마크다운 특수문자][link_makrdown0]

[link_makrdown0]: https://tomoyo.ivyro.net/123/wiki.php/TeX_%EB%B0%8F_LaTeX_%EC%88%98%EC%8B%9D_%EB%AC%B8%EB%B2%95

[마크다운 사용법][link_makrdown]

[link_makrdown]: https://gist.github.com/ihoneymon/652be052a0727ad59601

[마크다운 수식][link_makrdown2]

[link_makrdown2]: https://khw11044.github.io/blog/blog-etc/2020-12-21-markdown-tutorial2/
