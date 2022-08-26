# Use Sample Data with RoBERTa

Please note that our sample WikiText-103 dataset is roughly 0.1% the
size of the full Watson-English dataset used to train our provided
RoBERTa model. As such, pre-training on this dataset is a toy problem
and intended mainly as a functional test and illustrative example -
the resulting model will be highly overfitted to third-person,
descriptive language with extensive formatting, and should not be
expected to perform well as a general-purpose downstream language
model. That said, the provided code is set up to scale gracefully to
large datasets (including those used to produce our provided RoBERTa
model) and we invite users to train models using their own datasets!
We recommend at least 5GB of raw data.
