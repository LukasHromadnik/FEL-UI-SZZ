\newcommand{\NP}{\ensuremath{\mathcal{NP}}}
\newcommand{\red}{\vartriangleleft}
\newcommand{\calP}{\ensuremath{\mathcal{P}}}
\newcommand{\calU}{\ensuremath{\mathcal{U}}}
\newcommand{\calV}{\ensuremath{\mathcal{V}}}
\newcommand{\pspace}{\calP\texttt{SPACE}}
\newcommand{\npspace}{\NP\texttt{SPACE}}

[^1]: TSP $\red_p$ HAM $\Rightarrow \calP = \NP$

# Třídy složitosti

## Rozhodovací úlohy

Teorie složitosti pracuje zejména s tzv. *rozhodovacími* úlohami. Rozhodovací úlohy jsou takové úlohy, jejichž řešením je buď odpověď ANO nebo NE.

* **Rozhodovací verze**: Je dán orientovaný graf $G = (V, E)$, ohodnocení $c: E \rightarrow \mathbb{N}$ a dále celé číslo $K$. Existuje minimální kostra, jejíž cena je nejvýše $K$?
* **Vyhodnocovací verze**: Je dán neorientovaný graf $G = (V, E)$ a $c: E \rightarrow \mathbb{N}$. Najděte cenu minimální kostry ohodnoceného grafu.
* **Optimalizační verze**: Je dán neorietovaný graf $G = (V, E)$ a $c: E \rightarrow \mathbb{N}$. Najděte minimální kostru ohodnoceného grafu.

Dá se dokázat, že když je kterákoliv verze dané úlohy polynomiálně řešitelná, jsou polynomiálně řešitelné všechny tři verze.

## Třídy \calP a \NP

Instance libovolné rozhodovací úlohy můžeme zakódovat jako slova nad vhodnou abecedou. Protože řešením rozhodovací úlohy je buď ANO nebo NE, rozdělíme instance na tzv. ANO-instance a NE-instance. **Jazyk úlohy $\calU$**, značíme jej $L_\calU$, se skládá ze všech slov odpovídajících ANO-instancím úlohy \calU. Množina všech NE-instancí tvoří doplněk jazyka $\overline{L_\calU}$, tj. $\Sigma^* \setminus L_\calU$.

**Třída \calP.** Řekneme, že rozhodovací úloha \calU leží ve třídě \calP, jestliže existuje deterministický Turingův stroj, který rozhodne jazyk $L_\calU$ a pracuje v polynomiálním čase; tj. funkce $T(n)$ je $\mathcal{O}(p(n))$ pro nějaký polynom $p(n)$.

* **Minimální kostra v grafu**. Je dán neorientovaný graf $G$ s ohodnocením hran $c$. Je dáno číslo $k$. Existuje kostra grafu ceny menší nebo rovno $k$?
* **Nejkratší cesty v acyklickém grafu**. Je dán acyklický graf s ohodnocením hran $a$. Jsou dány vrcholy $r$ a $c$. Je dáno číslo $k$. Existuje orientovaná cesta z vrcholu $r$ do vrcholu $cč délky menší nebo rovno $k$?
* **Toky v sítích**. Je dána síť s horním omezením $c$, dolním omezením $l$, se zdrojem $z$ a spotřebičem $s$. Dále je dáno číslo $k$. Existuje přípustný tok od $z$ do $s$ velikosti alespoň $k$?
* **Minimální řez**. Je dána síť s horním omezením $c$, dolním omezením $l$. Dále je dáno číslo $k$. Existuje řez, který má kapacitu menší nebo rovnu $k$?

**Třída \NP.** Řekneme, že rozhodovací úloha \calU leží ve třídě \NP, jestliže existuje nedeterministický Turingův stroj, který rozhodne jazky $L_\calU$ a pracuje v poylnomiálním čase.

* **Kliky v grafu**. Je dán neorientovaný graf $G$ a číslo $k$. Existuje klika v grafu $G$ o alespoň $k$ vrcholech?
* **Nejkratší cesty v obecném grafu**. Je dán orientovaný graf s ohodnocením hran $a$. Jsou dány vrcholy $r$ a $v$. Je dáno číslo $k$. Existuje orientovaná cesta z vrcholu $r$ do vrcholu $v$ délky menší nebo rovno $k$?
* **$k$-barevnost**. Je dán neorietovaný graf $G$. Je graf $G$ $k$-barevný?
* **Problém batohu**. Je dáno $n$ předmětů $1, 2, ..., n$. Každý předmět $i$ má cenu $c_i$ a váhu $w_i$. Dále jsou dána čísla $A$ a $B$. Je možné vybrat předměty tak, aby celková váha nepřevýšila $A$ a celková cena byla alespoň $B$? Přesněji, existuje podmožina předmětů $I \subseteq \{ 1, 2, ..., n \}$ taková, že
$$ \sum_{i \in I} w_i \leq A \quad \text{a} \quad \sum_{i \in I} c_i \geq B?$$

## Třída $\mathcal{NPC}$

**Redukce a polynomiální redukce úloh.** Jsou dány dvě rozhodovací úlohy \calU a \calV. Řekneme, že úloha \calU se **redukuje** na úlohu \calV, jestliže existuje algoritmus (program pro RAM, Turingův stroj) $M$, který pro každou instanci $I$ úlohy \calU zkonstruuje instanci $I'$ úlohy \calV a to tak, že
$$I \text{ je ANO-instance } \calU \text{ iff } I' \text{ je ANO-instance } \calV.$$
Fakt, že úloha \calU se redukuje na úlohy \calV značíme
$$\calU \red \calV.$$
Jestliže navíc algoritmus $M$ pracuje v polynomiálním čase, říkáme, že \calU se **polynomiálně redukuje** na \calV a značíme
$$\calU \red_p \calV.$$

Polynomiální redukce $\red_p$ je tranzitivní. Tedy pokud
$$\calU \red_p \calV \text{ a } \calV \red_p \mathcal{W}, \text{ pak } \calU \red_p \mathcal{W}.$$

**\NP úplné úlohy.** Řekneme, že rozhodovací úloha \calU je **\NP úplná**, jestliže

1. \calU je ve třídě \NP,
2. každá \NP úloha se polynomiálně redukuje na \calU.

\NP úplné úlohy jsou ty \uv{nejtěžší} mezi všemi \NP úlohami, značíme ji $\mathcal{NPC}$.

* 3-barevnost
* ILP
* Problém rozkladu: Je dána konečná množina $X$ a systém jejich podmnožin $\mathcal{S}$. Je možné z $\mathcal{S}$ vybrat prvky tak, že tvoří rozklad množiny $X$?
* SubsetSum: Jsou dána kladná čísla $a_1, a_2, ..., a_n$ a číslo $K$. Lze vybrat podmnožinu čísel $a_1, a_2, ..., a_n$ tak, aby jejich součet byl roven číslu $K$?
* Problém kliky grafu
* Úloha o nezávislých množinách: Je dán prostý neorientovaný graf $G = (V, E)$ bez smyček. Množina vrcholů $N \subseteq V$ se nazývá *nezávislá množina* v $G$, jestliže žádná hrana grafu $G$ nemá oba krajní vrcholy v $N$. Existuje v $G$ nezávislá množina o $k$ vrcholech?
* Problém vrcholového pokrytí: Je dán prostý neorientovaný graf bez smyček $G = (V, E)$. Podmnožina vrcholů $B \subseteq V$ se nazývá *vrcholové pokrytí* $G$, jestliže každá hrana grafu $G$ má alespoň jeden krajní vrchol v množině $B$. Existuje v grafu $G$ vrcholové pokrytí o $k$ vrcholech?
* Problém existence hamiltonovského cyklu
* Problém obchodního cestujícího
* Problém nejdelších cest v orientovaném grafu
* Problém nejkratších cest v orientovaném grafu

**\NP obtížné úlohy.** Jestliže o některé úloze \calU pouze víme, že se na ní polynomiálně redukuje některá \NP úplná úloha, pak říkáme, že \calU je \NP téžká, nebo též \NP obtížná.

**Heuristiky.** Jestliže je třeba řešit problém, který je \NP úplný, musíme pro větší instance opustit myšlenku přesného nebo optimálního řešení a smířit se s tím, že získáme \uv{dostatečně přesné} nebo \uv{dostatečně kvalitní} řešení. K tomu se používají heuristické algoritmy pracující v polynomiálním čase.

**Aproximační algoritmus.** Uvažujme optimalizační problém \calU. Polynomiální algoritmus $\mathcal{A}$ se nazývá **$R$ aproximační algoritmus**, jestliže existuje reálné číslo $R$ takové, že pro každou instanci algoritmu $\mathcal{A}$ najde přípustné řešení ne horší než $R$-krát hodnota optimálního řešení.

Ne pro všechny úlohy, jejichž rozhodovací verze jsou \NP úplné, aproximační algoritmy existují[^1].

## Třída co-\NP

Je-li jazyk $L$ ve třídě \calP, pak i jeho doplněk $\overline{L}$ patří do třídy \calP. Obdobné tvrzení se pro jazyky třídy \NP neumí dokázat.

Jazyk $L$ patří do třídy co-\NP, jestliže jeho doplněk patří do třídy \NP.

* Jazyk USAT, který je doplňkem jazyka SAT, se skládá ze všech nesplnitelných booleovských formulí a ze všech slov, které neodpovídají booleovské formuli
* Jazyk TAUT, který se skládá ze všech slov odpovídajících tautologii výrokové logiky

Mějme dva jazyky $L_1$ a $L_2$, pro které platí $L_1 \red_p L_2$. Pak platí také $\overline{L_1} \red_p \overline{L_2}$.

Platí co-$\NP = \NP$ právě tehdy, když existuje \NP úplný jazyk, jehož doplněk je ve třídě \NP.

## Třídy \pspace a \npspace

**Třída \pspace.** Jazyk $L$ patří do třídy \pspace, jestliže existuje deterministický Turingův stroj $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí. Platí
$$\calP \subseteq \pspace.$$

**Třída \npspace.** Jazyk $L$ patří do třídy \npspace, jestliže existuje nedeterministický Turingův stroj $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí. Platí
$$\NP \subseteq \npspace.$$

Platí
$$\pspace = \npspace.$$

Platí
$$\calP \subseteq \NP \subseteq \pspace.$$
