# Deep Neural Networks

## Parameter initialization

It's not good idea too set all weights to zero. All neurons would behave the same: the same $\delta$s are backpropagated.

Initialization using samples from a Gaussian distributioon with zero mean works well for shallow networks, but for deep networks we might get into trouble.

**Xavier initialization.** We need to pick the weights from a Gaussian distribution with zero mean and variance $\frac{1}{(N_{in} + N_{out}) / 2}$ where $N_{in}$ is the number of incoming neurons and $N_{out}$ is the number of outgoing neurons.

## Processing image

Fully connected network needs $32^2 \times (32^2 + 1) \approx 1\mathrm{M}$ number of parameters.

**Locally connected layer.** Each neuron has a receptive field of $3 \times 3$ pixels. It is fully connected only to the corresponding set of 9 inputs $\Rightarrow 9k$ parameters.

**Sharing Parameters.** Use the same set of weights and bias for all outputs, define a *filter* $\Rightarrow$ 28$ parameters.

**Multiple Output Channels.** Use multiple *filters* to get more feature maps. This is the **convolutional layer**.

**Stride.** $3 \times 3 \to 1 \times 1$, plus shift of the "window"

**Zero padding.** Convolutional layer reduces the spatial size of the output w.r.t. the input. For mayn layers this might be a problem.

**Max Pooling.** Maximum of the input values.
