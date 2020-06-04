# Introduction

**Autonomous Agents and Multiagent Systems.** Multiagent system is a collection of multiple autonomous agents each acting towards its objectives while all interacting in a shared environment, being able to communicate and possibly coordinate their actions.

**Agent.** An agent is anything that can perceive its environment (through its sensors) and act upon that environment (throught its effectors).

**Agent behaviour.** Agent's behaviour is described by the agent function $f: \mathcal{P} \rightarrow \mathcal{A}$ that maps percept sequences to actions.

**Rational behaviour.** Rational agent chooses whichever action maximizes the expected value of the performance measure given the percept sequence to date and whatever built-in knowledge the agent has.

To design a rational agent we must specify the task environment:

1. Performace measure
2. Environment
3. Actuators
4. Sensors

## Key properties of Intelligent Agent

* **Autonomy:** Agent is fully accountable for its given state. Agent accepts requests from other agents or the environment but decides individually about its actions.
* **Reactivity:** Agent is capable of near-real-time decision with respect to changes in the environment or events in its social neighbourhood.
* **Intentionality:** Agent maintain long term intention. The agent meets the designer's objectives. It knows its purpose and executes even if not requested.
* **Rationality:** Agent is capable of intelligent rational decision making. Agent can analyze future course of actions and choose an action which maximizes his utility.
* **Social capability:** Agent is aware of the either
    * existence,
    * communication protocols,
    * capability, services provided by the other agents.
    
    Agent can reason about other agents.

## Rationality

Let us have a community of agents $A_j \in \mathcal{A}$ each choosing to play an action $a_j$, executing the lottery $l_j$ providing the agents with the utility $u(a_i)$.

* **Self-interested rational agent:** selects the action that optimizes its *individual utility*
$$a = \argmax_{l \in \mathcal{L}} \sum_{p_i: o_i \in l} p_i u(o_i)$$
* **Cooperative rational agent:** selects the action that optimizes *collective utility* of the whole team
$$a = \argmax_{l \in \mathcal{L}} \sum_{\forall a_j \in \mathcal{A} - a} \sum_{p_{i,j}: o_{i,j} \in l_j} p_{i,j} u(o_{i,j}) + \sum_{p_i: o_i \in l} p_i u(o_i)$$
