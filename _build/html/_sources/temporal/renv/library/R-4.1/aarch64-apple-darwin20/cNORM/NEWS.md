# cNORM:news and change-log
This file documents the development of the package as well as open issues or points for further improvements.



### Version in 3.0.1
Date: 2022.04.11


Changes:

*    t parameter added to data preparation in the shiny GUI
*    default paremeters in cnorm now k = 5 and t = 3
*    error in shiny GUI corrected: Download data
*    WeigtedRegression vignette extended
*    Additional descriptive information in modeling when using weights
*    Vignette cNORM-Demo revised




### Version in 3.0.0
Date: 2022.03.28


Changes:

*    Major version: Includes weighting functions to overcome biased norm samples,
     by providing marginal means factor levels of stratification variables in the 
     population as a data frame
     New function: computeWeights()
*    Newly developed, highly performant and biasless weighted ranking procedure
*    New vignette: 'WeightedRanking'
*    Modelling returns info on range of weights if post stratification is used
*    automatically remove  cases with missings in 'cnorm' function
*    ppvt dataset exchanged with unstratified sample with additional background
     variables (migration, region, sex)
*    Documentation updated
*    Author sequence changed. Alex is now first and corresponding author. Please
     direct questions to lenhard@psychometrica.de
*    minor changes: if(class(x) == "cnorm") exchanged with if(inherts(x, "cnorm"))
     throughout package




### Version in 2.1.1
Date: 2021.10.13


Changes:

*    normList parameter in plotNormCurves not working in non T score scales fixed 
*    lower CI not reported correctly in normTable and rawTable corrected
*    documentation in normTable and rawTable extended
*    internal prettyPrint function corrected; now it displays interval in the middle of the tables
     correctly in rawTable and normTable function



### Version in 2.1.0
Date: 2021.08.10


Changes:

*    add remarks on decrease of age power parameter in computePowers when R2 is low
*    add parameter for powers of a in computePowers, prepareData, bestModel and cnorm
*    predictNorm is now able to handle NA
*    count, how often terms had been selected in cnorm.cv
*    pretty print option added to normTable and rawTable to collapse intervals and round
     to meaningful precision
*    Bug corrected in normTable when using age vector to compute series of norm tables     



### Version in 2.0.4
Date: 2021.07.24


Changes:

*    Fixed bug in setting getNormScoreSE and added option to calculate RMSE (now default)
*    Corrected y axis label in plotDerivative
*    changes header in plotNorm from SE to RMSE
*    exceptions catched in predictNorm 



### Version in 2.0.3 
Date: 2021.04.10


Changes:

*    Fixed bug in setting minNorm and maxNorm in predictNorm, if attribute is missing
*    Aligned function in predictNorm for single scores and vectors
*    Code simplification
*    suboptimal model selection when leaps.setups dependencies found; bug fixed



### Version in 2.0.2
Date: 2021.01.30


Changes:

*    Fixed bug in rankBySlidingWindow due to ranking
*    New function for building groups and assign group means: getGroups
*    display errors fixed in plotPercentiles, function optimized
*    Fixed regression: Clipping of minRaw and maxRaw in predictRaw



### Version in 2.0.1
Date: 2021.01.05


Changes:

*    Fixing errors in the context of weighted percentile modelling
*    Code change of weighted rank estimation from https://aakinshin.net/posts/weighted-quantiles/
     code by Andrey Akinshin
*    Additional message for plotting, when weighted percentiles are used
*    Use weighted percentiles in plotPercentiles
*    automatic weighting deactivated in bestModel, since it is already applied in ranking
*    suppressWarnings in weighted ranking



### Version in 2.0.0 (release)
Date: 2020.12.04
Version 2.0.0 features many fundamental improvements both relating to the procedure but as well to the
package itself. It introduces weighted percentiles and thus helps in correcting violations of 
representativeness in the norm sample. There is a new main function 'cnorm()' that returns a
cnorm object. Most functions now accept this cnorm object and do not require separate data objects and
statistical models. And finally S3 methods plot(), summary() and print() have been introduced.


Changes:

*    Preparing for next major release with complete redesign of S3 method structure and weighting
*    New function cnorm() that does all the data preparation and modelling in one step
     It returns a cnorm object, which can be used in all model check, plotting and prediction functions
*    New S3 functions: print, plot, summary
*    Vignette revised
*    All functions have been extended to accept a cnorm object instead of data and / or model
*    prepareData, rankByGroup and rankBySlidingWindow no have the option to provide a
     weighting parameter to compensate for imbalances. The percentiles are weighted
     accordingly. The weighted ranking is based on an adaption of wtd.rank of the Hmisc
     package, provided by the courtesy of Frank Harrell
*    bestModel automatically uses the weighting parameter from the ranking (if applied)
*    prepareData, rankByGroup and rankBySlidingWindow can now directly handle vectors
     instead of a data frame, e. g.
     rankByGroup(raw = elfe$raw, group = elfe$group)
*    If no group is provided and only a raw vector is present e.g. ranByGroup(raw=elfe$raw),
     traditional ranking of a single group is done
*    Power parameter k added to prepareData
*    New convenience function modelSummary
*    New method getNormScoreSE added: Compute SE for regression based norm scores sensu Oosterhuis
     van der Ark & Sijtsma (2016)



### Version in 1.2.4 (release)
Date: 2020.10.14


Changes:

*    Improvements in Shiny GUI: download buttons for data and model, introduction page, CI for norm tables
*    Descending order bugs corrected in Shiny GUI
*    Option to automatically compute confidence intervalls in rawTable() and normTable() via CI and reliability parameters
*    repeated cross validation cnorm.cv now calculates RMSE for norm scores
*    repeated cross validation cnorm.cv can now use a prespecified formula
*    data cleaning in output of cnorm.cv



### Version in 1.2.3 (release)
Date: 2020.06.18

Changes:

*    Error in citation fixed
*    Improved explanations in the Shiny GUI
*    Additional 'Update'-Buttons in norm and raw scores plot in visualization tab of shiny gui
*    removed unnecessary import askYesNo
*    spell checking in diverse function descriptions
*    correction for monotonicity in rawTable and normTable (now default)
*    predictRaw can now return matrices for list of norm x age
*    new dataset added on the basis of the EPM paper
*    Bug in plotPercentiles fixed for datasets with descending ranking order
*    'descend' parameter added to prepareData
*    rawTable can now return matrices


### Version in 1.2.2 (fifth release)
Date: 2019.09.18

Changes:

*    Error in rankByGroup and rankBySlidingWindow when covariate variable name was used
*    warning added to rankBySlidingWindow in case, age and group do not correspond
*    rankBySlidingWindow accepts age variable in addition to age variable name
*    plotPercentiles now allows plotting both degrees of binary covariate
*    code cleaning in plotPercentiles
*    bestModel automatically does plotPercentiles if parameter plot set to TRUE
*    Citation file added





### Version in 1.2.1
Date: 2019.08.01

Changes:

*    prepareDate issues warnings if age and group values do not relate
*    modified message in bestModel function if R2 is not reached
*    if R2 and terms are not specified in bestModel function, fall back to model 5
     in case R2 does not reach .99 in most complex model
*    Additional message in bestModel in case of high number of terms     
*    Code simplification in computePowers by using 'poly' function
*    Performance improvement and code cleaning in checkConsistency
*    Multiple R2 output added to computePowers
*    new option to add index labels to data points in plotSubset
*    cnorm.cv now respects sliding window ranking
*    silent parameter added to prepareData and computePowers
*    rankBySlidingWindo and rankByGroup add width parameter to data preparation
*    pCutoff in cnorm.cv now adjusts for sample size



### Version in 1.2.0 (fourth release)
Date: 2019.07.26

Changes:

*   Preparing for the inclusion of a binary covariate. The package is been
    rewritten by larger parts
    NOTE: The inclusion of a covariate is currently still experimental and not
    optimized. Please use carefully! If covariates are central for your research
    question, consider packages like GAMLSS or quantreg
*   Entering systematic testing
*   BUG fixed: retrieving normtables and norm scores in large datasets could
    produce outlier (hashing function to remove duplicates was flawed)
*   Corrected keywords for datasets




### Version in 1.1.9
Date: 2019.07.07

Changes:

*   weighting added to bestModel-function
*   cast to data.frame in prepareData method to prevent SPSS import failing
*   Ordering of raw table when using descending values
*   Warning message added to computePowers function in case the multiple R2 between the explanatory variable
    and the raw score is below .05; modelling norm scores in dependence of age is questionable in that case
*   prepareData, rankByGroup and rankBySlidingWindow now accept variables instead of variable names as well
*   rankByGroup and rankBySlidingWindow display warning in case of small groups



### Version in 1.1.8 (Third release to CRAN)
Date: 2019.03.15 (mainly testing and cleaning minor errors)

Changes:

*   fixing exceptions
*   group and age can now be deactivated, resulting in conventional norming procedure, based in ranking + regression over powers of L



### Version in 1.1.7
Date: 2019.02.28

Changes:

*   bestModel function now accepts a formula as a predictors object
*   plotPercentile now accepts descending ranking
*   rawTable and normTable adapted for descending values
*   rangeCheck prints additional information
*   Leaner GUI with more options
*   predictNorm now much faster through using lookup tables, large speed gains as well for depending functions
*   Setting age = FALSE in computePowers prevents computation of powers of age and interactions. All plotting and modelling functions changed accordingly. cNORM in this case models norm score tables simply based on regression without computing different groups
*    normTable automatically chooses default values for minNorm, maxNorm and step



### Version in 1.1.6
Date: 2019.02.07, third release on CRAN

Changes:

*   Improvement to cv function in GUI and in package



### Version in 1.1.5
Date: 2019.02.06, third release on CRAN

Changes:

*   Cross Validation added to shiny GUI
*   cnorm.cv documentation improved
*   added information to BestModel output




### Version in 1.1.4
Date: 2018.12.18

Changes:

*   scale parameter added to prepareData function
*   fix for plotNorm by group with missing values



### Version in 1.1.3 - Second release on CRAN
Date: 2018.12.09

Changes:

*   rmarkdown moved from imports to suggests
*   cnorm.cv info added to README



### Version in 1.1.2
Date: 2018.12.08

Changes:

*   deleted code in vignette needing to much build time
*   removed UTF-8 attributes from ppvt dataset and cleared all datasets from non ASCII signs
*   deleted code in vignette needing to much build time
*   additional tests run on R-hub
*   added rmarkdown to imports



### Version in 1.1.1
Date: 2018.12.01

Changes:

*    Parameters added to cv.norm: Significance level for stratification process
*    Additional plot in cv.norm: delta R2 in norm score validation
*    Example in readme improved
*    CDC data: group variable set to center of interval
*    descend parameter removed from plotPercentileSeries, plotPercentiles, checkConsistency,
     rawTable & normTable; instead take default from model; vignette updated accordingly
*    stop criterion added to data sampling in cnorm.cv  
*    cv.norm: lines added to R2 delta plot
*    normTable and rawTable can now produce list of tables



### Version in 1.1.0
Date: 2018.11.23

Changes:

*    Cross validation added: new function: cnorm.cv() for assessing RMSE for raw data and R2 and CROSSFIT for norm data
*    Data table output for cnorm.cv
*    rankBySlidingWindow now accessible via prepareData()
*    group, raw, age and width can now be provided in cnorm.cv
*    parameter for full cross validation (separate ranking for train and validation)
*    Additional NA checks and warning messages
*    plotPercentiles now with R2adjr in title



### Version in 1.0.3
Date: 2018.11.16

Changes:

*    Additional instruction on series section of visualization tab in Shiny GUI
*    Code cleanup in bestModel function
*    SE added to plotNorm based on Oosterhuis, van der Ark & Sijtsma (2016)
*    RMSE added to model object (m$subsets), to plotRaw and to plotSubset
*    additional plotting options added to GUI:
     +    plotting of differences in raw and norm plot
     +    RMSE in model selection information function



### Version in 1.0.2
Date: 2018.11.16

Changes:

*    Improvements in precision of plotPercentiles
*    error corrected in ppvt dataset: groups did not represent group means
*    function description in 'ranBySlidingWindow' updated
*    checking for missing packages in shiny GUI improved
*    user menu asking to install missing packages added
*    derive-function: more general approach with "order" parameter
*    plotDerivative function can now plot derivatives of higher order
*    exclude cases with missing values in rankByX functions
*    percentile columns added to rawTable and normTable
*    additional data cleansing for data objects imported from Excel file format



### Version in 1.0.1  - First release on CRAN
Date: 2018.11.03

Changes:

*   Improvements in the GUI: Waiting circle shown to indicate ongoing computation
*   Additional help texts on best model in GUI
*   Additional plotting options in cNORM.GUI(): Raw Score and Norm Score plots
*   User input asking for missing suggested packages to install



### Version in 1.0.0
Date: 2018.10.26

Changes:

*   Final polishing finished; releasing first major version



### Version in 0.9.20
Date: 2018.10.24

Changes:

*   GUI with Shiny finished
*   ... now working on finally releasing the package



### Version in 0.9.19
Date: 2018.10.20

Changes:

*   API changed: predictNormValue renamed to predictNorm
*   Shiny GUI enhanced
*   Additional plotting options in plotNorm and plotRaw
*   less strict warning messages in predictNormValue function and checkConsistency



### Version in 0.9.18
Date: 2018.10.08

Changes:

*   First shiny prototype (many thanks to Sebastian Gary); please use cNORM.GUI() to start user interface


### Version in 0.9.17
Date: 2018.10.01

Changes:

*   predictNormValue fixed and optimized (many thanks to Sebastian Gary)
*   API change with respect to predictNormValue, rawTable and plotNorm
*   plotNorm: norm score boundaries guessed by min and max score from modelling 



### Version in 0.9.16
Date: 2018.09.21

Changes:

*   bug in predictNormValue partly fixed (further optimization necessary)
*   API change: plotValues renamed to plotRaw
*   new function: plotNorm



### Version in 0.9.15
Date: 2018.09.18

Changes:

*   plotDensity function added
*   attributes added to data.frame to increase usability



### Version in 0.9.13
Date: 2018.09.16

Changes:

*   predictNormValue with higher precision and effectivity
*   rawTableQuick removed from source code



### Version in 0.9.12
Date: 2018.09.11

Changes:

*   'simulateRasch' to simulate test data was added
*   old sim functions removed
*   documentation improved
*   new parameters to bestModel in order to force covariates into regression
*   additional checks in box cox functions



### Version in 0.9.9
Date: 2018.09.06

Changes:

*   Enhancements to the 'prepareData' function



### Version in 0.9.8
Date: 2018.09.05

Changes:

*   Life expectancy dataset of the World Bank added
*   Mortality of infants per 1000 life birth from 1960 to 2017 added
*   Minor changes in functions to check data integrity and exceptions
*   Vignette updated



### Version in 0.9.7
Date: 2018.08.31

Changes:

*   License changed to AGPL
*   Capitalizations in labels of plots
*   min and max renamed to minRaw and maxRaw (where appropriate)
*   terminology: standard or normal score instead of norm; score instead of value
*   new function for model validation: plotPercentileSeries
*   many functions now draw the default values from the model (plotting and predicting)



### Version in 0.9.6
Date: 2018.08.28

Changes:

*   Minor improvements in function descriptions
*   API of plotSubset changed due to new plotting options



### Version in 0.9.5
Date: 2018.08.25

Changes:

*   New, large dataset for BMI centile estimation from CDC included, type ?CDC for explanation
*   Extensive documentation available via https://www.psychometrica.de/cNorm_en.html (in progress)



### Version in 0.9.4
Date: 2018.08.23

Changes:

*   Generating group variable in rankBySlidingWindow
*   parameters in plotPercentile to restrict age range
*   ppvt dataset restricted



### Version in 0.9.3
Date: 2018.08.20

Changes:

*   plotNormCurves enhanced (Thanks to Sebastian Gary)
*   new function to plot semi parametric analyses via box cox power transformation: plotBoxCox
*   variable "explanatoryVariable" and "normVariable" in computePowers function renamed for easier API



### Version in 0.9.2
Date: 2018.08.18

Changes:

*   Additional dataset: vocabulary development (PPVT4)



### Version in 0.9.1
Date: 2018.08.16

Changes:

*   Added predictRawBC and predictNormBC for computing norm and raw values based on the parametric box cox power function parameters
*   New contributor: Sebastian Gary, welcome to the team!
*   Missing raw variable definition in plotValues corrected



### Version in 0.9.0
Date: 2018.08.14

Changes:

*   Box Cox power transformation for regression model at specific age: optional parametric modelling for non-parametric regression model



### Version in 0.8.9

Date: 2018.08.13

Changes:

*   Convenience method for selection best model added: 'printSubset'
*   predictNormValue now accepts lists of values as well



### Version in 0.8.8
Date: 2018.08.12

Changes:

*   parameter checks added
*   new parameter 'descriptives' added to rankByGroup and rankBySlidingWindow added to retrieve descriptive statistics for each observation
*   improvements in the documentation
*   errors in bestModel and plotPercentiles corrected, when variable names are not as in example sample



### Version in 0.8.6
Date: 2018.08.11

Changes:

*   new function: 'rankBySlidingWindow' which can be used for data sets with continuous age variables
*   error corrected for data being loaded from SPSS files
*   improvements in the documentation



### Version in 0.8.5
Date: 2018.08.06

Changes:

*   new function for simulating data



### Version in 0.8.3
Date: 2018.08.03

Changes:

*   Code cleaning and formatting



### Version in 0.8.2
Date: 2018.08.02

Changes:

*   new internal function: rawTableQuick for speeding up generating norm tables
  Still has to be checked for working with descending values.
  Works only, if model assumptions are valid



### Version in 0.8.0
Date: 2018.08.01

Changes:

*   new function: rawTable allows creating norm tables with assignment of raw -> norm values solves inverse function of regression model with brute force



### Version in 0.7.11
Date: 2018.07.31

Changes:

*   improved 'prepareData' function



### Version in 0.7.10
Date: 2018.07.28

Changes:

*   Description for computePowers improved
*   option in plotPercentile to use percentile scale or self defined c(mean, sd)



### Version in 0.7.9
Date: 2018.07.28

Changes:

*   'descend' parameter added to consistencyCheck and normTable
*   dependency rColorBrewer removed; plotPercentiles changed accordingly
*   latticeExtra moved to 'suggests'



### Version in 0.7.8
Date: 2018.07.27

Changes:

*   'descend' parameter added to consistencyCheck and normTable



### Version in 0.7.7
Date: 2018.07.27

Changes:

*   Small changes to error messages in bestModel
*   printing of min value in plotDerivate removed



### Version in 0.7.6

Date: 2018.07.27

Changes:

*   parameter 'predictors' added to allow self defined regression functions, e. g. for the inclusion of other ranking parameters like sex
*   'type' parameter added to 'plotPercentile' to allow selection of quantile algorithm. Please consult help(quantile) for further information on 'type'



### Version in 0.7.5
Date: 2018.07.26

Changes:

*   dependency dplyr removed: rankByOrder and plotPercentiles rewritten
*   API-change: derivationPlot renamed to plotDerivate
*   small changes to vignette and readme
*   parameter "raw" added to rankByGroup to specify raw value variable
*   rawVar and groupVar in plotPercentiles renamed to raw and group to make API more coherent



### Version in 0.7.4

Date: 2018.07.25

Changes:

*   rankByOrder: ranking in descending order added



### Version in 0.7.3
Date: 2018.07.25

Changes:

*   Additional ranking algorithms: Filliben, Levenbach, Yu & Huang; API changed to index
*   scale can be specified as double vector with c(mean, sd)
*   vignette updated accordingly



### Version in 0.7.2
Date: 2018.07.24

Changes:

*   None. This is the first release
