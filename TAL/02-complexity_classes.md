[^1]: TSP $\red_p$ HAM $\Rightarrow \mcalP = \NP$

# Třídy složitosti

## Rozhodovací úlohy

Teorie složitosti pracuje zejména s tzv. *rozhodovacími* úlohami. Rozhodovací úlohy jsou takové úlohy, jejichž řešením je buď odpověď ANO nebo NE.

* **Rozhodovací verze**: Je dán neorientovaný graf $G = (V, E)$, ohodnocení $c: E \rightarrow \mathbb{N}$ a dále celé číslo $K$. Existuje minimální kostra, jejíž cena je nejvýše $K$?
* **Vyhodnocovací verze**: Je dán neorientovaný graf $G = (V, E)$ a ohodnocení $c: E \rightarrow \mathbb{N}$. Najděte cenu minimální kostry ohodnoceného grafu.
* **Optimalizační verze**: Je dán neorietovaný graf $G = (V, E)$ a ohodnocení $c: E \rightarrow \mathbb{N}$. Najděte minimální kostru ohodnoceného grafu.

Dá se dokázat, že když je kterákoliv verze dané úlohy polynomiálně řešitelná, jsou polynomiálně řešitelné všechny tři verze.

## Třídy \mcalP a \NP

Instance libovolné rozhodovací úlohy můžeme zakódovat jako slova nad vhodnou abecedou. Protože řešením rozhodovací úlohy je buď ANO nebo NE, rozdělíme instance na tzv. ANO-instance a NE-instance. **Jazyk úlohy $\mcalU$**, značíme jej $L_\mcalU$, se skládá ze všech slov odpovídajících ANO-instancím úlohy \mcalU. Množina všech NE-instancí tvoří doplněk jazyka $\overline{L_\mcalU}$, tj. $\Sigma^* \setminus L_\mcalU$.

**Třída \mcalP.** Řekneme, že rozhodovací úloha \mcalU leží ve třídě \mcalP, jestliže existuje deterministický Turingův stroj, který rozhodne jazyk $L_\mcalU$ a pracuje v polynomiálním čase; tj. funkce $T(n)$ je $\mathcal{O}(p(n))$ pro nějaký polynom $p(n)$.

* **Minimální kostra v grafu**. Je dán neorientovaný graf $G$ s ohodnocením hran $c$. Je dáno číslo $k$. Existuje kostra grafu ceny menší nebo rovno $k$?
* **Nejkratší cesty v acyklickém grafu**. Je dán acyklický graf s ohodnocením hran $a$. Jsou dány vrcholy $r$ a $c$. Je dáno číslo $k$. Existuje orientovaná cesta z vrcholu $r$ do vrcholu $c$ délky menší nebo rovno $k$?
* **Toky v sítích**. Je dána síť s horním omezením $c$, dolním omezením $l$, se zdrojem $z$ a spotřebičem $s$. Dále je dáno číslo $k$. Existuje přípustný tok od $z$ do $s$ velikosti alespoň $k$?
* **Minimální řez**. Je dána síť s horním omezením $c$, dolním omezením $l$. Dále je dáno číslo $k$. Existuje řez, který má kapacitu menší nebo rovnu $k$?

**Třída \NP.** Řekneme, že rozhodovací úloha \mcalU leží ve třídě \NP, jestliže existuje nedeterministický Turingův stroj, který rozhodne jazyk $L_\mcalU$ a pracuje v polynomiálním čase.

* **Klika grafu**. Je dán neorientovaný graf $G$ a číslo $k$. Existuje klika v grafu $G$ o alespoň $k$ vrcholech?
* **Nejkratší cesty v obecném grafu**. Je dán orientovaný graf s ohodnocením hran $a$. Jsou dány vrcholy $r$ a $v$. Je dáno číslo $k$. Existuje orientovaná cesta z vrcholu $r$ do vrcholu $v$ délky menší nebo rovno $k$?
* **$k$-barevnost**. Je dán neorietovaný graf $G$. Je graf $G$ $k$-barevný?
* **Problém batohu**. Je dáno $n$ předmětů $1, 2, \dots, n$. Každý předmět $i$ má cenu $c_i$ a váhu $w_i$. Dále jsou dána čísla $A$ a $B$. Je možné vybrat předměty tak, aby celková váha nepřevýšila $A$ a celková cena byla alespoň $B$? Přesněji, existuje podmožina předmětů $I \subseteq \{ 1, 2, \dots, n \}$ taková, že
$$ \sum_{i \in I} w_i \leq A \quad \text{a} \quad \sum_{i \in I} c_i \geq B?$$

## Třída $\mathcal{NPC}$

**Redukce a polynomiální redukce úloh.** Jsou dány dvě rozhodovací úlohy \mcalU a \mcalV. Řekneme, že úloha \mcalU se **redukuje** na úlohu \mcalV, jestliže existuje algoritmus (program pro RAM, Turingův stroj) $M$, který pro každou instanci $I$ úlohy \mcalU zkonstruuje instanci $I'$ úlohy \mcalV a to tak, že
$$I \text{ je ANO-instance } \mcalU \text{ iff } I' \text{ je ANO-instance } \mcalV.$$
Fakt, že úloha \mcalU se redukuje na úlohy \mcalV značíme
$$\mcalU \red \mcalV.$$
Jestliže navíc algoritmus $M$ pracuje v polynomiálním čase, říkáme, že \mcalU se **polynomiálně redukuje** na \mcalV a značíme
$$\mcalU \red_p \mcalV.$$

Polynomiální redukce $\red_p$ je tranzitivní. Tedy pokud
$$\mcalU \red_p \mcalV \text{ a } \mcalV \red_p \mathcal{W}, \text{ pak } \mcalU \red_p \mathcal{W}.$$

**\NP úplné úlohy.** Řekneme, že rozhodovací úloha \mcalU je **\NP úplná**, jestliže

1. \mcalU je ve třídě \NP,
2. každá \NP úloha se polynomiálně redukuje na \mcalU.

\NP úplné úlohy jsou ty \uv{nejtěžší} mezi všemi \NP úlohami, značíme je $\mathcal{NPC}$.

* **3-barevnost**
* **ILP**
* **Problém rozkladu**: Je dána konečná množina $X$ a systém jejich podmnožin $\mathcal{S}$. Je možné z $\mathcal{S}$ vybrat prvky tak, že tvoří rozklad množiny $X$?
* **SubsetSum**: Jsou dána kladná čísla $a_1, a_2, \dots, a_n$ a číslo $K$. Lze vybrat podmnožinu čísel $a_1, a_2, \dots, a_n$ tak, aby jejich součet byl roven číslu $K$?
* **Problém kliky grafu**
* **Úloha o nezávislých množinách**: Je dán prostý neorientovaný graf $G = (V, E)$ bez smyček. Množina vrcholů $N \subseteq V$ se nazývá *nezávislá množina* v $G$, jestliže žádná hrana grafu $G$ nemá oba krajní vrcholy v $N$. Existuje v $G$ nezávislá množina o $k$ vrcholech?
* **Problém vrcholového pokrytí**: Je dán prostý neorientovaný graf bez smyček $G = (V, E)$. Podmnožina vrcholů $B \subseteq V$ se nazývá *vrcholové pokrytí* $G$, jestliže každá hrana grafu $G$ má alespoň jeden krajní vrchol v množině $B$. Existuje v grafu $G$ vrcholové pokrytí o $k$ vrcholech?
* **Problém existence hamiltonovského cyklu**
* **Problém obchodního cestujícího**
* **Problém nejdelších cest v orientovaném grafu**
* **Problém nejkratších cest v orientovaném grafu**

**\NP obtížné úlohy.** Jestliže o některé úloze \mcalU pouze víme, že se na ni polynomiálně redukuje některá \NP úplná úloha, pak říkáme, že \mcalU je \NP téžká, nebo též \NP obtížná.

**Heuristiky.** Jestliže je třeba řešit problém, který je \NP úplný, musíme pro větší instance opustit myšlenku přesného nebo optimálního řešení a smířit se s tím, že získáme \uv{dostatečně přesné} nebo \uv{dostatečně kvalitní} řešení. K tomu se používají heuristické algoritmy pracující v polynomiálním čase.

**Aproximační algoritmus.** Uvažujme optimalizační problém \mcalU. Polynomiální algoritmus $\mathcal{A}$ se nazývá **$R$ aproximační algoritmus**, jestliže existuje reálné číslo $R$ takové, že pro každou instanci algoritmu $\mathcal{A}$ najde přípustné řešení ne horší než $R$-krát hodnota optimálního řešení.

Ne pro všechny úlohy, jejichž rozhodovací verze jsou \NP úplné, aproximační algoritmy existují[^1].

## Třída co-\NP

Je-li jazyk $L$ ve třídě \mcalP, pak i jeho doplněk $\overline{L}$ patří do třídy \mcalP. Obdobné tvrzení se pro jazyky třídy \NP neumí dokázat.

Jazyk $L$ patří do třídy co-\NP, jestliže jeho doplněk patří do třídy \NP.

* Jazyk USAT, který je doplňkem jazyka SAT, se skládá ze všech nesplnitelných booleovských formulí a ze všech slov, která neodpovídají booleovské formuli.
* Jazyk TAUT, který se skládá ze všech slov odpovídajících tautologii výrokové logiky.

Mějme dva jazyky $L_1$ a $L_2$, pro které platí $L_1 \red_p L_2$. Pak platí také $\overline{L_1} \red_p \overline{L_2}$.

Platí co-$\NP = \NP$ právě tehdy, když existuje \NP úplný jazyk, jehož doplněk je ve třídě \NP.

## Třídy \pspace a \npspace

**Třída \pspace.** Jazyk $L$ patří do třídy \pspace, jestliže existuje deterministický Turingův stroj $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí. Platí
$$\mcalP \subseteq \pspace.$$

**Třída \npspace.** Jazyk $L$ patří do třídy \npspace, jestliže existuje nedeterministický Turingův stroj $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí. Platí
$$\NP \subseteq \npspace.$$

**Savitchova věta.** Platí
$$\pspace = \npspace.$$

Platí
$$\mcalP \subseteq \NP \subseteq \pspace.$$

![Třídy obtížnosti](assets/complexity-classes.png){width=400px}

## Testování prvočíselnosti

**Jazyky $L_p$ a $L_s$.** Jazyk $L_p$ obsahuje všechna prvočísla, jazyk $L_s$ obsahuje všechna složená čísla, přesněji
\begin{align*}
L_p &= \{w \ | \ w \text{ je binární zápis prvočísla} \} \\
L_s &= \{ w \ | \ w \text{ je binární zápis složeného čísla} \}
\end{align*}
Jazyk $L_s$ je (až na číslo 1, protože číslo 1 není ani prvočíslo ani složené číslo) doplňkem jazyka $L_p$; přidáme-li 1 do jazyka $L_s$, pak dostáváme
$$L_s = \overline{L_p}, \quad L_p = \overline{L_s}.$$

Jazyky $L_p$ a $L_s$ patří do průniku tříd \NP a co-\NP.

**Millerův test prvočíselnosti.**

* Vstup: velké liché přirozené číslo $n$
* Výstup: \uv{prvočíslo} nebo \uv{složené}

1. Spočítáme $n - 1 = 2^lm$, kde $m$ je liché číslo.
2. Náhodně vybereme $a \in \{ 1, 2, \dots, n - 1 \}$.
3. Spočítáme $a^m \modn$, jestliže $a^m \equiv 1 \modn$, stop, výstup \uv{prvočíslo}.
4. Opakovaným umocňováním počítáme
$$a^{2m} \modn, \quad a^{2^2m} \modn, \quad \dots, \quad a^{2^lm} \modn.$$
5. Jestliže $a^{2^lm} \not\equiv 1 \modn$, stop, výstup \uv{složené}.
6. Vezmeme $k$ takové, že $a^{2^km} \not\equiv 1 \modn$ a $a^{2{k + 1}m} \equiv 1 \modn$. \
Jestliže $a^{2^km} \equiv -1 \modn$, stop, výstup \uv{prvočíslo}. \
Jestliže $a^{2^km} \not\equiv -1 \modn$, stop, výstup \uv{složené}.

**Věta.**

1. Jestliže pro vstup $n$ dá Millerův test prvočíselnosti odpověď \uv{složené}, pak je číslo $n$ složené.
2. Jestliže pro vstup $n$  dá Millerův test prvočíselnosti odpověď \uv{prvočíslo}, pak $n$ je prvočíslo s pravděpodobností větší než $\frac{1}{2}$.

**Randomizovaný Turingův stroj.** RTM je, zhruba řečeno, Turingův stroj $M$ se dvěma páskami, kde první páska má stejnou roli jako u deterministického Turingova stroje, ale druhá páska obsahuje náhodnou posloupnost 0 a 1, tj. na každém políčku se 0 objeví s pravděpodobností $\frac{1}{2}$ a 1 také s pravděpodobností $\frac{1}{2}$.

Na začátku práce:

* stroj $M$ se nachází v počátečním stavu $q_0$,
* první páska obsahuje vstupní slovo $w$, zbytek pásky obsahuje $B$,
* druhá páska obsahuje náhodnou posloupnost 0 a 1,
* případné další pásky obsahují $B$,
* všechny hlavy jsou nastaveny na prvním políčku dané pásky.

Na základě stavu $q$, ve kterém se stroj $M$ nachází, a na základě obsahu políček, které jednotlivé hlavy čtou, přechodová funkce $\delta$ určuje, zda se $M$ zastaví nebo přejde do nového stavu $p$, přepíše obsah první pásky (**nikoli ale obsah druhé pásky**) a hlavy posune doprava, doleva nebo zůstanou stát (posuny hlav jsou nezávislé).

Formálně, je-li $M$ ve stavu $q$, hlava na první pásce čte symbol $X$, na druhé pásce je číslo $a$ a
$$\delta(q, X, a) = (p, Y, D_1, D_2), \quad q, p \in Q, \quad a \in \{0, 1\}, \quad X, Y \in \Gamma, \quad D_1, D_2 \in \{L, R, S \},$$
pak $M$ se přesune do stavu $p$, na první pásku napíše $Y$ a $i$-tá hlava se posune doprava pro $D_i = R$, doleva pro $D_i = L$ nebo zůstane na místě pro $D_i = S$.

Jestliže $\delta(q, X, a)$ není definováno, $M$ se zastaví.

$M$ se úspěšně zastaví právě tehdy, když se přesune do koncového (přijímacího) stavu $q_F$.

Může se zdát, že tento model je nerealistický – nemůžeme před začátkem práce naplnit druhou pásku nekonečnou sekvencí 0 a 1. Toto je \uv{realizováno} tak, že v okamžiku, kdy druhá hlava čte dosud nenavštívené políčko druhé pásky, náhodně se vygeneruje 0 nebo 1 každé s pravděpodobností $\frac{1}{2}$ a tento symbol už se nikdy během jednoho průběhu práce TM nezmění.

**Třída \RP.** Jazyk $L$ patří do třídy \RP právě tehdy, když existuje RTM $M$ takový, že:

1. Jestliže $w \notin L$, stroj $M$ se ve stavu $q_F$ zastaví s pravděpodobností 0.
2. Jestliže $w \in L$, stroj $M$ se ve stavu $q_F$ zastaví s pravděpodobností, která je alespoň rovna $\frac{1}{2}$.
3. Existuje polynom $p(n)$ takový, že každý běh $M$ (tj. pro jakýkoliv obsah druhé pásky) trvá maximálně $p(n)$ kroků, kde $n$ je délka vstupního slova.

Miller-Rabinův test prvočíselnosti je příkladem algoritmu, který splňuje všechny tři podmínky a proto jazyk $L$, který se skládá ze všech složených čísel patří do třídy \RP.

Navíc pro každou kladnou konstantu $0 < c < \frac{1}{2}$ je možné sestrojit RTM $M$ s polynomiální složitostí takový, že pro jazyk $L \in \RP$ a slovo $w \in L$ se úspěšně zastaví s pravděpodobností $1 - c$.

**Turingův stroj typu Monte-Carlo.** RTM splňující podmínky 1 a 2 z předchozí definice se nazývá RTM typu *Monte-Carlo*. RTM typu Monte-Carlo obecně nemusí pracovat v polynomiálním čase.

**Třída \ZPP.** Jazyk $L$ patří do třídy \ZPP právě tehdy, když existuje RTM $M$ takový, že:

1. Jestliže $w \notin L$, stroj $M$ se úspěšně zastaví s pravděpodobností 0.
2. Jestliže $w \in L$, stroj $M$ se úspěšně zastaví s pravděpodobností 1.
3. Střední hodnota počtu kroků $M$ v jednom běhu je $p(n)$, kde $p(n)$ je polynom a $n$ je délka vstupního slova.

To znamená, že $M$ neudělá chybu, ale nezaručuje vždy polynomiální počet kroků při jednom běhu, pouze střední hodnota počtu kroků je polynomiální.

**Turingův stroj typu Las-Vegas.** RTM splňující podmínky z předchozí definice se nazývá typu *Las-Vegas*.

Jestliže jazyk $L$ patří do třídy \ZPP, pak i jeho doplněk $\overline{L}$ patří do třídy \ZPP.

**Třída co-\RP.** Jazyk $L$ patří do třídy co-\RP právě tehdy, když jeho doplněk $\overline{L}$ patří do třídy \RP.

Platí
$$\ZPP = \RP \cap \text{co-}\RP.$$

Platí
$$\mcalP \subseteq \ZPP, \quad \RP \subseteq \NP, \quad \text{co-}\RP \subseteq \text{co-}\NP.$$

## Nerozhodnutelnost

**Rekurzivní jazyky.** Řekneme, že jazyk $L$ je **rekurzivní**, jestliže existuje Turingův stroj $M$, který rozhoduje jazyk $L$.

**Rekurzivně spočetné jazyky.** Řekneme, že jazyk $L$ je **rekurzivně spočetný**, jestliže existuje Turingův stroj $M$, který tento jazyk přijímá.

Jazykům, které nejsou rekurzivní, také říkáme, že jsou *algoritmicky neřešitelné* nebo *nerozhodnutelné*.

Každý rekurzivní jazyk je též rekurzivně spočetný.

Jestliže jazyk $L$ i  jeho doplněk $\overline{L}$ jsou oba rekurzivně spočetné, pak $L$ je rekurzivní.

Pro jazyk $L$ může nastat jedna z následujících možností:

1. $L$ i $\overline{L}$ jsou oba rekurzivní.
2. Jeden z $L$ a $\overline{L}$ je rekurzivně spočetný a druhý není rekurzivně spočetný.
3. $L$ i $\overline{L}$ nejsou rekurzivně spočetné.

**Kód Turingova stroje.** Každý Turingův stroj $M$ lze zakódovat jako binární slovo. Mějme Turingův stroj $M$ s množinou stavů $Q = \{ q_1, q_2, \dots, q_n \}$, množinou vstupních symbolů $\Sigma = \{ 0, 1 \}$, množinou páskových symbolů $\Gamma = \{ X_1, X_2, \dots, X_m \}$, kde $X_1 = 0, X_2 = 1, X_3 = B$. Dále počáteční stav je $q_1$, koncový stav $q_2$. Označme $D_1$ pohyb hlavy doprava a $D_2$ pohyb hlavy doleva (tj. $D_1 = R$ a $D_2 = L$).

Jeden přechod stroje $M$
$$\delta(q_i, X_j) = (q_k, X_l, D_r),$$
zákodujeme slovem
$$w = 0^i10^j10^k10^l10^r.$$
*Kód Turingova stroje*, který značíme $\langle M \rangle$, je
$$\langle M \rangle = 111 w_1 11 w_2 11 \dots 11 w_p 111,$$
kde $w_1, \dots, w_p$ jsou slova odpovídající všem přechodům stroje $M$.

**Diagonální jazyk $L_d$.** Jestliže binární slovo $w$ nemá tvar $111 w_1 11 w_2 11 \dots 11 w_p 111$, považujeme ho za kód Turingova stroje, který nepřijímá žádné slovo (neudělá nikdy žádný krok), tj. $L(M) = \emptyset$.

Jazyk $L_d$ se skládá ze všech binárních slov $w$ takových, že Turingův stroj s kódem $w$ nepřijímá slovo $w$. Tedy $L_d$ obsahuje i všechna slova $w$, která neodpovídají kódům nějakého Turingova stroje, ovšem obsahuje i další binární slova.

Neexistuje Turingův stroj, který by přijímal jazyk $L_d$. Jinými slovy, $L_d \ne L(M)$ pro každý Turingův stroj $M$.

**Univerzální jazyk.** *Univerzální jazyk $L_{UN}$* je množina slov tvaru $\langle M \rangle w$, kde $\langle M \rangle$ je kód Turingova stroje a $w \in \{ 0, 1 \}^*$ je binární slovo takové, že $w \in L(M)$.

**Univerzální Turingův stroj.** *Univerzální Turingův stroj $U$* má 4 pásky. První páska obsahuje vstupní slovo $\langle M \rangle w$, druhá páska simuluje pásku Turingova stroje $M$ a třetí páska obsahuje kód stavu, ve kterém se Turingův stroj $M$ nachází. Dále má $U$ ještě čtvrtou, pomocnou pásku.

Univerzální jazyk $L_{UN}$ je rekurzivně spočetný, ale není rekurzivní.

Jsou dány dvě úlohy \mcalU a \mcalV takové, že $\mcalU \red \mcalV$. Pak platí:

1. Jestliže \mcalV je rozhodnutelná, pak i \mcalU je rozhodnutelná.
2. Jestliže \mcalU je nerozhodnutelná, pak i \mcalV je nerozhodnutelná.
3. Jestliže jazyk úlohy \mcalU není rekurzivně spočetný, pak i jazyk úlohy \mcalV není rekurzivně spočetný.

**Věta (Rice).** Jakákoli netriviální vlastnost rekurzivně spočetných jazyků je nerozhodnutelná.

Netriviální vlastností se rozumí každá vlastnost, kterou má aspoň jeden rekurzivně spočetný jazyk a nemají ho všechny rekurzivně spočetné jazyky.

## Další nerozhodnutelné úlohy

Univerzální jazyk $L_{UN}$ hraje pro nerozhodnutelné úlohy / jazyky obdobnou roli jako hrál problém splnitelnosti booleovských formulí pro \NP úplné úlohy.

Označme \mcal{UN} úlohu odpovídající univerzálnímu jazyku $L_{UN}$; tj. tuto úlohu: Instance se skládá z TM $M$ a slova $w$. Jedná se o ano instanci právě tehdy, když $w \in L(M)$.

**Postův korespondenční problém (PCP).** Jsou dány dva seznamy slov $A, B$ nad danou abecedou $\Sigma$.
$$A = (w_1, w_2, \dots, w_k), \quad B = (x_1, x_2, \dots, x_k),$$
kde $w_i, x_i \in \Sigma^*, i = 1, 2, \dots, k$. Řekneme, že dvojice $A, B$ *má řešení*, jestliže existuje posloupnost $i_1, i_2, \dots, i_r$ indexů, tj. $i_j \in \{ 1, 2, \dots, k \}$, taková, že
$$w_{i_1} w_{i_2} \dots w_{i_r} = x_{i_1} x_{i_2} \dots x_{i_r}.$$
Otázka: Existuje řešení dané instance?

**Modifikovaný Postův korespondenční problém (MPCP).** Jsou dány dva seznamy $A, B$ nad danou abecedou $\Sigma$. Řekneme, že dvojice $A, B$ *má řešení*, jestliže existuje posloupnost indexů taková, že
$$w_1 w_{i_1} w_{i_2} \dots w_{i_r} = x_1 x_{i_1} x_{i_2} \dots x_{i_r}.$$
Otázka: Existuje řešení dané instance?

Modifikovaný Postův korespondenční problém se od Postova korespondenčního problému liší tím, že v MPCP vyžadujeme, aby hledaná posloupnost indexů vždy začínala jedničkou.

Platí
$$\mcal{UN} \red \mathrm{MPCP} \red \mathrm{PCP}.$$

Postův korespondenční problém je nerozhodnutelný.

**Víceznačnost bezkontextových gramatik.** Je dána bezkontextová gramatika $\mcal{G} = (N, \Sigma, S, P)$, kde $N$ je množina neterminálních symbolů, $\Sigma$ je množina terminálních symbolů, $S$ je startovací symbol a $P$ je množina pravidel typu $X \rightarrow \alpha$ pro $X \in N, \alpha \in (N \cup \Sigma)^*$.

Otázka: Rozhodněte, zda existuje slovo $w$, které má dva různé derivační stromy?

Platí

$$\mathrm{PCP} \red \text{víceznačnost bezkontextových gramatik}.$$

Jsou dány bezkontextové gramatiky $\mcal{G}_1$ a $\mcal{G}_2$. Označme $L(\mcal{G}_1)$ a $L(\mcal{G}_2)$ jazyky generované gramatikami $\mcal{G}_1$ a $\mcal{G}_2$. Následující úlohy jsou nerozhodnutelné.

1. $L(\mcal{G}_1) \cap L(\mcal{G}_2) = \emptyset.$
2. $L(\mcal{G}_1) = L(\mcal{G}_2).$
3. $L(\mcal{G}_1) \subseteq L(\mcal{G}_2).$
4. $L(\mcal{G}_1) = \Sigma^*.$

**Tiling problém.** Jsou dány čtvercové dlaždičky velikosti 1 $\mathrm{cm}^2$ několika typů. Každá dlaždička má barevné okraje. Máme neomezený počet dlaždiček každého typu.

Otázka: Je možné dlaždičkami vydláždit každou plochu daného typu tak, aby se dlaždičky dotýkaly hranami stejné barvy, za předpokladu, že dlaždičky nesmíme rotovat?

Tiling problém je nerozhodnutelný. Tedy speciálně je nerozhodnutelné, zda každou neomezenou plochu je možné vydláždit předem danou sadou dlaždiček.
