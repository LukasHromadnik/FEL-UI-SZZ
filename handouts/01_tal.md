# TAL

## Turingův stroj

**Turingův stroj** je sedmice $(Q, \Sigma, \Gamma, \delta, q_0, B, F)$.

**Situace Turingova stroje** (též **konfigurace**) plně popisuje obsah pásky, poizici hlavy na pásce a stav, ve kterém se nachází řídící jednotka.

Jestliže během výpočtu TM nad slovem $w$ se TM dostane do jednoho z koncových stavů $q' \in F$, říkáme, že se TM **úspěšně zastavil**. Obsah pásky při úspěšném zastavení je **výstupem** TM nad vstupem $w$.

Vstupní slovo $w \in Sigma^*$ je **přijato** TM $M$, jestliže se TM na slově $w$ **úspěšně zastaví**. Množina slov $w \in \Sigma^*$, kterou TM přijímá, se nazývá **jazyk přijímaný $M$** a značíme $L(M)$.

Je dáno zobrazení $f: \Sigma^* \to \Sigma^*$. Řekneme, že TM $M$ **realizuje zobrazení $f$**, jestliže pro každé $w \in \Sigma^*$, pro které je $f(w)$ definované, se $M$ úspěšně zastaví s výstupem $f(w)$. Pro $w$ pro něž $f(w)$ není definováno se $M$ **zastaví neúspěšně**.

**Časová složitost Turingova stroje $T(n)$** je rovno maximálnímu počtu kroků, po nichž dojde k zastavení Turingova stroje.

**Paměťová složitost Turingova stroje $S(n)$** je rovna největšímu rozdálu pořadových čísel polí, který byla během výpočtu použita.

Řekneme, že TM **rozhoduje jazyk $L$**, jestliže tento jazyk přijímá a navíc se na každém vstupu zastaví.

**Turingův stroj s $k$ páskami.** $\delta: (Q \setminus F) \times \Gamma^k \to Q \times \Gamma^k \times \{L, R\}^k$

Ka každému TM $M_k$ s $k$ páskami existuje TM $M_1$ s jednou pásknou, který má stejné chování jako $M_k$. Navíc, jestliže $M_k$ potřebuje k úspěšnému zastavení $n$ kroků, pak $M_1$ potřebuje $\mathcal{O}(n^2)$ kroků.

**Nedeterministický Turingův stroj.** $\delta: (Q \setminus F) \times \Gamma \to \mathcal{P}_f(Q \times \Gamma \times \{L, R\})$

Je-li jazyk $L$ přijímán, resp. rozhodovoán, nedeterministickým TM $M$, pak existuje deterministický TM $M_1$ s jednou páskou, který $L$ přijímá, resp. rozhoduje.

## Třídy složitosti

Dá se dokázat, že pokud je rozhodovací, vyhodnocovací nebo optimalizační verze dané úlohy polynomiálně řešitelná, potom jsou polynomiálně řešitelné všechny tři verze.

**Jazyk úlohy $\mathcal{U}$**, značíme je $L_\mathcal{U}$, se skládá ze všech slov odpovídajících ANO-instancím úlohy $\mathcal{U}$.

**Třída $\mathcal{P}$.** Řekneme, že rozhodovací úloha $\mathcal{U}$ leží ve třídě $\mathcal{P}$, jestliže existuje deterministický TM, který rozhodne jazyk $L\mathcal{U}$ a pracuje v polynomiálním čase.

* Minimální kostra grafu
* Nejkratší cesty v acyklickém grafu
* Toky v sítích
* Minimální řez

**Třída \NP.** Řekneme, že rozhodovací úloha $\mathcal{U}$ leží ve třídě \NP, jestliže existuje nedeterministický TM, který rozhodne jazyk $L_\mathcal{U}$ a pracuje v polynomiálním čase.

* Klika grafu
* Nejkratší cesty v obecném grafu
* $k$-barevnost
* Problém batohu

**Redukce úloh.** Jsou dány dvě rozhodovací úlohy $\mathcal{U}$ a $\mathcal{V}$. Řekneme, že úloha $\mathcal{U}$ se *redukuje* na plohu $\mathcal{V}$, jestliže existuje algoritmus $m$, který pro každou instanci $I$ úlohy $\mathcal{U}$ zkonstruuje instanci $I'$ úlohy $\mathcal{V}$ a to tak, že $I$ ja ANO-instance $\mathcal{U}$ iff $I'$ je ANO-instance $\mathcal{V}$.

**$\mathcal{NPC}$.** Řekneme, že rozhodovací úloha je *\NP úplná*, jestliže

1. $\mathcal{U}$ je ve třídě \NP,
2. každá \NP úloha se polynomiálně redukuje na $\mathcal{U}$.

* 3-barevnost
* ILP
* Problém rozkladu
* SubsetSum
* Problém kliky grafu
* Úloha o nezávislých množinách
* Problém vrcholového pokrytí
* Problém existence hamiltonovského cyklu
* Problém obchodního cestujícího
* Problém nejdelších cest v orientovaném grafu
* Problém nejkratších cest v orientovaném grafu

**\NP obtížné úlohy.** Jestliže o některé úloze $\mathcal{U}$ pouze víme, že se na ni polynomiálně redukuje některá \NP úplná úloha, pak říkáme, že $\mathcal{U}$ je *\NP těžká*, nebo též *$\NP obtížná*.

**Aproximační algoritmus.** Uvažujme optimializační problém $\mathcal{U}$. Polynomiální algoritmus $\mathcal{A}$ se nazývá *$R$-approximační algoritmus*, jestliže existuje reálné číslo $R$ takové, že pro každou instanci algoritmu $\mathcal{A}$ najde přípustné řešení ne horší než $R$-krát hodnota optimálního řešení.

Je-li jazyk $L$ ve třídě $\mathcal{P}$, pak i jeho doplněk $\overline{L}$ patří do $\mathcal{P}$. Obdobné tvrzení se pro jazyky třídy \NP neumí dokázat.

Jazyk $L$ patří do třídy co-\NP, jestliže jeho doplněk patří do třídy \NP.

* USAT
* TAUT

Mějme dva jazyky $L_1$ a $L_2$, pro které platí $L_1 \triangleleft_p L_2$, potom platí $\overline{L_1} \triangleleft_p \overline{L_2}$.

Platí co-$\NP = \NP$ právě tehdy, když existuje \NP úplný jazyk, jehož doplněk je ve třídě \NP.

**Třída \pspace.** Jazyk $L$ patří do třídy \pspace, jestliže existuje deterministický TM $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí.
$$\mathcal{P} \subseteq \pspace$$

**Třída \npspace.** Jazyk $L$ patří do třídy \npspace, jestliže existuje nedeterministický TM $M$, který přijímá jazyk $L$ a pracuje s polynomiální paměťovou složitostí.
$$\NP \subseteq \npspace$$

**Savitchova věta.**
$$\pspace = \npspace$$

Platí
$$\mathcal{P} \subseteq \NP \subseteq \pspace$$

![Třídy obtížnosti](assets/complexity-classes.png){width=400px}

**Věta.**

1. Jestliže pro vstup $n$ dá Millerův test prvočíselnosti odpověď \uv{složené}, pak je číslo $n$ složené.
2. Jestliže pro vstup $n$ dá Millerův test prvočíselnosti odpověď \uv{prvočíslo}, pak $n$ je prvočíslo s pravděpodobností větší než $\frac{1}{2}$.

**Randomizovaný Turingův stroj** RTM je TM $M$ se dvěma páskami, kde první páska má stejnou roli jako u deterministického TM, ale druhá páska obsahuje náhodnou posloupnost 0 a 1, tj. na každém políčku se 0 objeví s pravděpodobností $\frac{1}{2}$ a 1 také s pravděpodobností $\frac{1}{2}$.

**Třída \RP.** Jazyk $L$ patří do třídy \RP právě tehdy, když existuje RTM $M$ takový, že

1. jestliže $w \notin L$, stroj $M$ se ve stavu $q_F$ zastaví s pravděpodobností 0,
2. jestliže $w \in L$, stroj $M$ se ve stavu $q_F$ zastaví s pravděpodobností, která je alespoň rovna $\frac{1}{2}$,
3. existuje polynom $p(n)$ takový, že každý běh $M$ trvá maximální $p(n)$ kroků, kde $n$ je délka vstupního slova.

Miller-Rabinův test prvočíselnost je příkladem algoritmu, který splňuje všechny tři podmínky a proto jazyk $L$, který se skládá ze všech složených čísel, patří do třídy \RP.

**TM typu Monte-Carlo.** RTM splňující podmíny 1 a 2 z předchozí definice se nazývá RTM typu *Monte-Carlo*. RTM typu Monte-Carlo obecně nemusí pracovat v polynomiálním čase.

**Třída \ZPP.** jazyk $L$ patří do třídy \ZPP právě tehdy, když existuje RTM $M$ takový, že

1. jestliže $w \notin L$, stroj $M$ se úspěšně zastaví s pravděpodobností 0,
2. jestliže $w \in L$, stroj $M$ se úspěšně zastaví s pravděpodobností 1,
3. střední hodnota počtu kroků $M$ v jednom běhu je $p(n)$, kde $p(n)$ je polynom a $n$ je délka vstupního slova.

Jestliže jazyk $L$ patří do \ZPP, pak i jeho doplněk $\overline{L}$ patří do třídy \ZPP.

**Třída co-\RP.** Jazyk $L$ patří do třídy co-\RP právě tehdy, když jeho doplněk $\overline{L}$ patří do třídy \RP.
$$\ZPP = \RP \cap \text{co-}\RP$$

Platí
$$\mathcal{P} \subseteq \ZPP, \quad \RP \subseteq \NP, \quad \text{co-}\RP \subseteq \text{co-}\NP$$

**Rekurzivní jazyky.** Řekneme, že jazyk $L$ je *rekurzivní*, jestliže existuje TM $M$, který rozhoduje jazyk $L$.

**Rekurzivně spočetné jazyky.** Řekneme, že jazyk $L$ je *rekurzivně spočetný*, jestliže existuje TM $M$, který tento jazyk přijímá.

Jestliže jazyk $L$ i jeho doplněk jsou oba rekurzivně spočetné, pak je $L$ rekurzivní.

Pro jazyk $L$ může nastat jedno z následujících možností:

1. $L$ i $\overline{L}$ jsou oba rekurzivní,
2. jeden z $L$ a $\overline{L}$ je rekurzivně spočetný a druhý není rekurzivně spočetný,
3. $L$ i $\overline{L}$ nejsou rekurzivně spočetné.

**Kód Turingova stroje.** Jeden přechod stroje $M, \delta(q_i, X_j) = (q_k, X_l, D_r)$ zakódujeme slovem $w = O^i 1 0^j 1 0^k 1 0^l 1 0^r$. *Kód Turingova stroje*, který značíme $\langle M \rangle$, je
$$\langle M \rangle = 111 \, w_1 \, 11 \, w_2 \, 11 \, \dots \, 11 w_p \, 111,$$
kde $w_1, \dots, w_p$ jsou slova odpovídající všem přechodům stroje $M$.

**Diagonální jazyk $L_d$.** Jestliže binární slovo $w$ nemá tvat $111 \, w_1 \, 11 \, w_2 \, 11 \, \dots \, 11 w_p \, 111$, považujeme ho za kód TM, který nepřijímá žádné slovo, tj. $L(M) = \emptyset$.

Jazyk $L_d$ se skládá ze všech binárních slov $w$ takových, že TM s kódem $w$ nepřijímá slovo $w$.

Neexistuje TM, který by přijímal jazyk $L_d$.

**Univerzální jazyk $L_{UN}$** je množina slov tvaru $\langle M \rangle w$, kde $\langle M \rangle$ je kód TM a $w \in \{0, 1\}^*$ je binární slovo takové, že $w \in L(M)$.

**Univerzální Turingův stroj $U$** má 4 pásky. První páska obsahuje vstupní slovo $\langle M \rangle w$, druhá páska simuluje pásku TM $M$ a třetí páska obsahuje kód stavu, ve kterém se TM $M$ nachází. Dále má $U$ ještě čtvrtou pomocnou pásku.

Univerzální jazyk $L_{UN}$ je rekurzivně spočetný, ale není rekurzivní.

Jsou dány dvě úlohy $\mathcal{U}$ a $\mathcal{V}$ takové, že $\mathcal{U} \triangleleft \mathcal{V}$. Pak platí:

1. jestliže $\mathcal{V}$ je rozhodnutelná, pak i $\mathcal{U}$ je rozhodnutelná,
2. jestliže $\mathcal{U}$ je nerozhodnutelná, pak i $\mathcal{V}$ je nerozhodnutelná,
3. jestliže jazyk úlohy $\mathcal{U}$ není rekurzivně spočetný, pak i jazyk úlohy $\mathcal{V}$ není rekurzivně spočetný.

**Rice.** Jakákoli netriviální vlastnost rekurzivně spočetných jazyků je neroozhodnutelná.

## Nerozhodnutelné úlohy

* Postův korespondenční problem (PCP)
* Modifikovaný Postův korespondenční problm (MPCP)
$$\mathcal{UN} \triangleleft \text{MPCP} \triangleleft \text{PCP}$$
* Víceznačnost bezkontextových gramatik
$$\text{PCP} \triangleleft \text{víceznačnost bezkontextových gramatik}$$
* Tiling problém

Jsou dány bezkontextové gramatiky $\mcal{G}_1$ a $\mcal{G}_2$. Označme $L(\mcal{G}_1)$ a $L(\mcal{G}_2)$ jazyky generované gramatikami $\mcal{G}_1$ a $\mcal{G}_2$. Následující úlohy jsou nerozhodnutelné.

1. $L(\mcal{G}_1) \cap L(\mcal{G}_2) = \emptyset.$
2. $L(\mcal{G}_1) = L(\mcal{G}_2).$
3. $L(\mcal{G}_1) \subseteq L(\mcal{G}_2).$
4. $L(\mcal{G}_1) = \Sigma^*.$
