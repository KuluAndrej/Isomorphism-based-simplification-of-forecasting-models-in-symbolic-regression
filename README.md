# Isomorphism-based-simplification-of-forecasting-models-in-symbolic-regression

In this project I implemented a genetic algorithm of the inductive model generation and model selection. A model is the superposition of primitive functions and represented as a directed labeled tree. Some of generated superpositions could be simplified so that their maps remain unchanged. A procedure performing this simplification is coded. This procedure is based on a search algorithm that finds all isomorphic subtrees in a tree. As a result, some subtrees are substituted with another subtrees of lesser structural complexity. The proposed procedure reduces both structural complexity and dimensionality of the parameter space of a superposition. European stock options trading data is used to illustrate the procedure. 

The project is a part of teh scientific paper of the same name.

# Computational expertiment

This project contains the files allowing to reproduce the results reflected in the paper.
These files are

- analysis_random_superpositions.m
- analysis_hists.m
- analysis_final_models_MVR.m
- plot_builder.m

... according to the chronological order followed in the paper. For futher explanations see comments in corresponging files.
