# R Predictive & Machine Learning

## Overview

This collection represents earlier R-based statistical and machine-learning work. The surviving source files demonstrate a progression from exploratory modeling into supervised classification, model evaluation, neural networks, association-rule mining, and clustering.

## Methods Demonstrated

- Linear and logistic regression
- Train/validation partitioning
- Classification thresholds and confusion matrices
- ROC curves and AUC
- Lift analysis
- Cost-sensitive classification
- k-nearest neighbors and CART exercises
- Neural-network classification and prediction
- Feature preprocessing, dummy variables, transformations, and scaling
- Apriori association-rule mining
- k-means clustering
- Elbow-method cluster selection
- Hierarchical clustering and dendrogram interpretation
- Cluster profiling

## Representative Source Evidence

### Credit-default classification

The original R work includes logistic classification, holdout validation, ROC/AUC analysis, lift charts, confusion-matrix evaluation, alternative probability cutoffs, and a weighted misclassification-cost approach. This is useful evidence of an early focus on evaluating a model against the business consequences of classification errors rather than accuracy alone.

### Neural networks

Accident-severity and automotive examples include categorical preprocessing, dummy-variable construction, numeric scaling, train/validation samples, alternative hidden-layer structures, and out-of-sample evaluation.

### Unsupervised learning

The unsupervised-learning source combines two distinct techniques. Grocery transactions are analyzed with Apriori association rules using support, confidence, and lift. A seed dataset is then standardized and analyzed using k-means and hierarchical clustering, including elbow analysis and cluster-center interpretation.

## Portfolio Interpretation

These files are presented as **technical-foundation work**, not as production ML systems. They demonstrate hands-on implementation of statistical learning concepts that were later developed more deeply in graduate machine-learning and unstructured-analytics projects.

## Limitations

- Several exercises rely on instructional datasets and should be interpreted as learning applications.
- Not every original dataset is redistributed in this repository.
- Model results are only reported publicly when they can be traced to retained source/output evidence.
- Modern production practices such as pipelines, experiment tracking, deployment, and monitoring were outside the scope of most of this earlier work.
