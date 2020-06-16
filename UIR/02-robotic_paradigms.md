# Robotic Paradigms

## Robot

A robot perceive an environment using **sensors** to **control** its **actuators**.

The main parts of the robot correspond to the primitives of robotics: **sense**, **plan** and **act**.

**Robotic Paradigms.** Define relationship between the primitives.

## Hierarchical Paradigm

The robot senses the environment and create the "world model". The world model contains everything the robot needs to know. Then the robot plans its action and executes it.

Disadvantages are related to planning – computation requirements.

The "global world" representation has to be up to date. The world model used by the planner has to be frequently updated to achieve a sufficient accuracy for the particular task.

**Frame problem.** A problem of representing the real-world situations to be computationally tractable.

The robot control is decomposed into functional modules that are sequentially executed.

## Reactive Paradigm

**Behaviors.** The mapping of sensory inputs to the pattern of motor actions

* Reflexive behaviors – "hardwired" stimulus-response
    * Reflexes – the response lasts only as long as the stimules
    * Taxes – the response to stimulus results in a movement towards or away of the stimulus
    * Fixed-Action Patterns – the response continues for a longer duration than the stimulus
* Reactive behaviors – learned and then executed without conscious thought
* Conscious behaviors – deliberative as a sequence of the previously developed behaviors

Four ways to acquire a behavior

* Innate – be born with a behavior
* Sequence of innate behaviors
* Innate with memory – be born with behaviors that need initialization
* Learn

## Hybrid Paradigm
