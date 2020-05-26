# Turingův stroj

Na základě symbolu $X$, který čte hlava na pásce, a na základě stavu $q$, ve kterém se nachází řídící jednotka, se řídící jednotka Turingova stroje přesune do stavu $p$, hlava přepíše obsah čteného pole na $Y$ a přesune se buď doprava nebo doleva.

Turingův stroj je sedmice $(Q, \Sigma, \Gamma, \delta, q_0, B, F)$, kde

* $Q$ je konečná množina stavů,
* $\Sigma$ je konečná množina vstupních symbolů,
* $\Gamma$ je konečná množina páskových symbolů, přitom $\Sigma \subset \Gamma$,
* $B$ je prázdný symbol, jedná se o páskový symbol, který není vstupním symbolem, tj. $B \in \Gamma \setminus \Sigma$,
* $\delta$ je přechodová funkce, tj. parciální zobrazení (nemusí být definováno všude) z množiny $(Q \setminus F) \times \Gamma$ do množiny $Q \times \Gamma \times \{L, R \}$, (zde $L$, resp. $R$, znamená pohyb hlavy doleva, resp. doprava),
* $q_0 \in Q$ je počáteční stav a
* $F \subset Q$ je množina koncových stavů.

**Situace Turingova stroje** (též **konfigurace**) plně popisuje obsah pásky, pozici hlavy na pásce a stav, ve kterém se nachází řídící jednotka.

Na začátku práce se Turingův stroj nachází v počátečním stavu $q_0$, na pásce má na $n$ polích vstupní slovo $a_1 a_2 ... a_n (a_i \in \Sigma)$, ostatní pole obsahují blank $B$ a hlava čte pole pásky se symbolem $a_1$. Tedy formálně počáteční situaci zapisujeme $q_0 a_1 a_2 ... a_n$.

Předpokládejme, že se Turingův stroj nachází v situaci

$$X_1 \, X_2 \, ... \, X_{i - 1} \, q \, X_i \, ... \, X_k.$$

Jestliže $\delta(q, X_i) = (p, Y, R)$, TM se přesune do stavu $p$, na pásku místo symbolu $X_i$ napíše symbol $Y$ a hlavu posune o jedno pole doprava.

$$X_1 \, X_2 \, ... \, X_{i - 1} \, q \, X_i \, ... \, X_k  \quad \vdash \quad X_1 \, X_2 \, ... \, X_{i - 1} \, Y \, p \, X_{i + 1} \, ... \, X_k.$$

Jestliže $\delta(q, X_i)$ není definováno, TM se zastaví.

**Výpočet Turingova stroje** nad slovem $w = a_1 \, a_2 \, ... \, a_k$ je posloupnost jeho kroků, která začíná v počáteční situaci $q_0 \, a_1 \, ... \, a_k$. Formálně se jedná o reflexivní a tranzitivní uzávěr $\vdash^*$ relace $\vdash$ (můžu udělat žádný nebo konečný počet kroků).

Jestliže během výpočtu Turingova stroje nad slovem $w$ se Turingův stroj dostane do jednoho z koncových stavů $q' \in F$, říkáme, že se TM **úspěšně zastavil**. Obsah pásky při úspěšném zastavení je **výstupem** TM nad vstupem $w$.

Vstupní slovo $w \in \Sigma^*$ je **přijato** Turingovým strojem $M$, jestliže se Turingův stroj na slově $w$ úspěšně zastaví. Množina slov $w \in \Sigma^*$, který Turingův stroj přijímá, se nazývá **jazyk přijímaný** $m$ a značíme $L(M)$.

Je dáno zobrazení $f: \Sigma^* \rightarrow \Sigma^*$. Řekneme, že TM $M$ **realizuje zobrazení** $f$, jestliže každé $w \in \Sigma^*$, pro které je $f(w)$ definovaná, se $M$ úspěšně zastaví s výstupem $f(w)$ (tj. $q_0 w \vdash^* \alpha q_F \beta$, kde $\alpha \beta = f(w)$). Pro $w$ pro něž $f(w)$ není definováno se $M$ **zastaví neúspěšně**.

**Časová složitost Turingova stroje** je parciální zobrazení $T(n)$ z množiny všech přirozených čísel do sebe. Jestliže pro nějaký vstup délky $n$ se Turingův stroj nezastaví, $T(n)$ není definováno. V opačném případě je $T(n)$ rovno maximálnímu počtu kroků, po nichž dojde k zastavení Turingova stroje.

**Paměťová složitost Turingova stroje $S(n)$**. Jestliže pro nějaký vstup délky $n$ Turingův stroj použije nekonečnou část pásky (pak se nemůže v konečném čase zastavit), $S(n)$ není definováno. V opačném případě je $S(n)$ rovno největšímu rozdílu pořadových čísel polí, které byly během výpočtu použity, kde maximum se bere přes všechny vstupy délky $n$.

Řekneme, že jazyk $L$ je **přijímán** nějakým Turingovým strojem, jestliže existuje TM $M$ takový, že $L = L(M)$. Řekneme, že Turingův stroj **rozhoduje jazyk** $L$, jestliže tento jazyk přijímá a navíc se na každém vstupu zastaví.

Každý jazyk, který je rozhodován Turingovým strojem, je také tímto Turingovým strojem přijímán. Naopak to ale neplatí.

**Turingův stroj s $k$ páskami** se skládá z řídící jednotky, která se nachází v jednom z konečně mnoha stavů $q \in Q$, množiny vstupních symbolů $\Gamma$, přechodové funkce $\delta$, počátečního stavu $q_0$, páskového symbolu $B$ a množiny koncových stavů $F$. Dále je dáno $k$ pásek a $k$ hlav, $i$-tá hlava vždy čte jedno pole $i$-té pásky. Přechodová funkce $\delta$ je parciální zobrazení, které reaguje na stav, ve kterém se Turingův stroj nachází a na $k$-tici páskových symbolů, kterou jednotlivé hlavy snímají. Formálně je $\delta$ parciální zobrazení $\delta: (Q \setminus F) \times \Gamma^k \rightarrow Q \times \Gamma^k \times \{L, R\}^k$.

Přechodová funkce udává pohyb každé halvy nezávisle na pohybech ostatních hlav.

Ke každému Turingovu stroji $M_1$ s $k$ páskami existuje Turingův stroj $M_2$ s jednou páskou, který má stejné chování jako $M_1$. Navíc, jestliže $M_1$ potřeboval k úspěšnému zastavení $n$ kroků, pak $M_2$ potřebuje $\mathcal{O}(n^2)$ kroků. *Důkaz v přednáškách*

**Nedeterministický Turingův stroj**. Jestliže pro Turingův stroj připustíme, aby v jedné situaci mohl povést několik různých kroků, dostáváme nedeterministický Turingův stroj. Jediný rozdíl je v přechodové funkci:

* $\delta$ je přechodová funkce, tj. parciální zobrazení z množiny $(Q \setminus F) \times \Gamma$ do množiny $\mathcal{P}_f(Q \times \Gamma \times \{L, R\})$, kde $\mathcal{P}_f(X)$ je konečná podmnožina množiny $X$.

Je-li jazyk $L$ přijímán, resp. rozhodován, nedeterministickým Turingovým strojem $M$, pak existuje deterministický Turingův stroj $M_1$ s jednou páskou, který $L$ přijímá, resp. rozhoduje.
