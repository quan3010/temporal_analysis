![](img/solar_logo.png)

# Workshop 5: Temporal and sequential analysis  

**Instructor**: Quan Nguyen, Ph.D., Teaching Fellow, Master of Data Science  
Department of Statistics, University of British Columbia

- [GitHub Repository](https://google.com)
- [Course Jupyter Book](https://google.com)
- [Zoom link](https://google.com)

**About the workshop**:

Data in learning analytics research (e.g. SIS, clickstream, log-files) are often rich in temporal features that could allow us to explore the dynamic changes in learning behavior at different time granularities (e.g. seconds, days, weeks, semesters). This workshop will introduce participants to several common temporal/sequential analysis methods and techniques using R. During the workshop, we will discuss how temporal analysis can be applied to answer RQs in learning analytics and which learning constructs are relevant to temporal analysis. Next, we will go through techniques to explore and visualize temporal/sequential data. Participants will learn and apply two types of temporal models: a) explanatory models using statistical techniques, such as Sequence Analysis with application to identify common patterns of learning activities from log data and b) association rule mining (apriori) with application to detect courses that are frequently taken together and create association rules for course recommendations.   


**Target Audience**:

This workshop is designed for anyone interested in temporal/sequential analysis. No experience in temporal and sequential analysis is required. To get the best learning experience, participants should familiarize themselves with basic statistics and machine learning concepts (e.g. regression, variance, autocorrelation, classification, cross-validation, overfitting).  


## Environment set up 
The workshop will use R and draw on packages such as `tramineR`, `fpp3`, and `keras`. 

You can install all the dependencies you need for the course using `conda`:

```sh
conda env create -f mds574.yaml
```

## About instructor
I am a Teaching Fellow at the UBC Master of Data Science where I develop and teach data science courses. Prior to UBC, I was a Postdoctoral Research Fellow in Learning Analytics at the School of Information, University of Michigan. My research focuses on analysing digital traces in educational settings to detect temporal discrepancies between course design and student engagement, and the subsequent effects on academic performance. My second research strand is to model peer interactions and peer influence on academic choices and performance. My work employed a wide range of statistical and computational techniques, such as multilevel modeling, network analysis, time-series/temporal analysis, and machine learning. My work has received multiple best paper awards at established conferences (e.g. LAK18 and HCI International 17). 

## Agenda

| Day | Lecture                           | Lab | Readings |
|-----|-----------------------------------|-----|----------|
| 1   | Sequential analysis with tramineR |     |          |
| 2   | Time-series forecasting           |     |          |
| 3   | Time-series classification        |     |          |


## Reference Material
* [Forecasting Principles and Practice (FPP)](https://otexts.com/fpp3/), Hyndman & Athanasopoulos (2021)

* [Advanced Forecasting with Python With State-of-the-Art-Models Including LSTMs, Facebook’s Prophet, and Amazon’s DeepAR](https://link.springer.com/book/10.1007/978-1-4842-7150-6)

* [Time Series Analysis and its Application: With R Examples (TSAA)](https://www.stat.pitt.edu/stoffer/tsa4/), Shumway & Stoffer (2017)

* Knight, S., Friend Wise, A., & Chen, B. (2017). Time for Change: Why Learning Analytics Needs Temporal Analysis. Journal of Learning Analytics, 4(3), 7–17.
https://doi.org/10.18608/jla.2017.43.2

* Chen, B., Knight, S., & Wise, A. F. (2018). Critical Issues in Designing and Implementing Temporal Analytics. Journal of Learning Analytics, 5(1), 1–9. https://doi.org/10.18608/jla.2018.53.1

## License
© 2022 Quan Nguyen

Software licensed under [the MIT License](https://spdx.org/licenses/MIT.html), non-software content licensed under [the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) License](https://creativecommons.org/licenses/by-nc-sa/4.0/).