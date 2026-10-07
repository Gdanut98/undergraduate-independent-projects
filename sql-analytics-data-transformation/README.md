# SQL Analytics & Data Transformation

## Overview

This project group highlights earlier SQL work that progressed from relational querying into practical data cleaning, transformation, reusable analytical objects, and exploratory analysis.

## Methods Demonstrated

- SELECT, filtering, grouping, aggregation, and ordering
- Inner/outer joins and self-joins
- CTEs
- Window functions
- Temporary tables
- Views
- String parsing and standardization
- Date conversion and cleanup
- Missing-value remediation through relational matching
- Duplicate identification with `ROW_NUMBER()`
- Schema cleanup
- Analytical queries across multiple related datasets

## Representative Project: Nashville Housing Data Cleaning

The retained SQL source demonstrates a multi-step cleaning workflow rather than a single query. Operations include standardizing dates, filling missing property addresses using a self-join, parsing address components, standardizing categorical values, identifying duplicates with window functions, and removing obsolete fields after transformation.

### Why it matters

This work is representative of the data-preparation layer that sits upstream of dashboards, analytics, and modeling. It also provides an early foundation for the ELT and dimensional-modeling work emphasized in my more recent portfolio projects.

## Representative Project: COVID Analytical SQL

The COVID analysis uses joins, aggregate calculations, window functions, a CTE, a temporary table, and a reusable view to examine cases, deaths, population-relative measures, and cumulative vaccination metrics.

## Portfolio Interpretation

This is foundational analytical SQL work. It demonstrates increasing comfort moving from ad hoc queries toward transformations and reusable analytical structures. More recent projects in my portfolio extend this foundation into dimensional modeling, warehouse layers, marts, validation, and BigQuery-oriented workflows.

## Publication Notes

Large database dumps and raw source datasets are intentionally excluded when they add repository size without adding reviewer-relevant technical evidence. The focus is on SQL authored for analysis and transformation.
