# Architecture

* **Simple reactive agent** chooses the next action on the basis of the current percept only.
* **Model-based agent** keeps the track of the world by extracting relevant information from percepts and storing it in its memory.
* **Goal-based agent**, goals are not necesarily achivable by a single action, thus there is a need for searching and planning.
* **Utility-based agent** uses the utility function to choose the most desirable action / course of actions to take.

## BDI agent-oriented systems

Practical way to implement **goal-oriented** agents.

### Key features

* **Beliefs:** information about the world.
* **Events:** goals / desires to resolve; internal or external.
* **Plan library:** recipes for handling goal-events.
* **Intentions:** partially uninstantiated programs with commitment.

### Practical reasoning

Theoretical reasoning is reasoning directed towards beliefs – concerned with deciding **what to believe**. On the other hand practical reasoning is reasoning directed towards actions – concerned with deciding **what to do**.

* **Deliberation:** deciding **what** state of affairs we want to achieve.
    * considering preferences, choosing goals
    * balancing alternatives (decision-theory)
    * the outputs of deliberation are **intentions**
* **Means-ends reasoning:** deciding **how** to achieve these states of affairs.
    * thinking about suitable actions, resources and how to "organize" activity
    * building courses of actions (planning)
    * the ouputs of means-ends reasoning are **plans**

### Desires

Desires describe the states of affairs that are considered for achievement, i.e. basic preferences of the agent.

Desires are much weaker then intentions; not directly related to activity.

### Intentions

Agent's intentions are determined **dynamically** by the agent at **runtime** based on its known facts, current goals and available plans.

An intention is just a **partially executed strategy** that comes from the plan library when resolving events.

An intention represents a **focus of an attention**, something the agent is currently working on. Action / behavior arises as a consequence of executing intentions.

A new intention is created when an external event is addressed.

### Key points of BDI programming

* Flexible and responsible to the environment: **reactive programming**
* Relies on **context sensitive** subgoals expansion: "act as you go"
* Leave for **as late as possbile** the choice of which plans to commit to as the chosen course of action to achieve (sub)goals
* **Modular** and **incremental** programming
* Nondeterminism on **choosing** plans and bindings

### Structuring Plans and Goals

* Make each plan **complete** at a particular **abstraction level**
* Use a **subgoal** – even if only one plan choice for now
* Modular and easy to **add other plan choices** later
* Think in terms of **subgoals**, not function calls
* Learn to **pass information** between subgoals
