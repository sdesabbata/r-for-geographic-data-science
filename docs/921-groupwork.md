# Groupwork exercise {-}

## Introduction {-}

One of the key pledges that the current government of the United Kingdom made in 2019 was a commitment to *levelling up* -- that is, to address local and regional inequalities. The idea of levelling up the country has been at the centre of the political debate for the last two years, involving a wide range of socio-economic topics from education^[see, e.g., [‘Levelling up’ the UK starts with schools](https://www.ft.com/content/b4a9cac9-0c19-48cd-a6d5-1526fbae7418) by 
Justine Greening in The Financial Times, August 28th, 2020] to rail investment^[see, e.g., [Rail cuts are another sign of the Treasury’s bias against the north of England](https://www.theguardian.com/commentisfree/2021/nov/19/rail-cuts-treasury-north-england-chancellor-rish-sunak-no-10) by James Meadway in The Guardian, November 19th, 2021.].

The [Centre for Cities](https://www.centreforcities.org/) (an independent charity and research centre) has identified^[see the [Levelling up](https://www.centreforcities.org/levelling-up/) section on the [Centre for Cities](https://www.centreforcities.org/) website.] health and education as two of the key areas which should be at the core of a levelling up agenda. In conducting this groupwork, you will focus on the relationship between health, education and occupation within Leicester. The aim is to understand better how health is linked to education and occupation at the local level, with the perspective of advising the local authority about key areas that might be prioritised for support.


## Data {-}

To explore the issues outlined above, this groupwork uses data from the [2011 Output Area Classification](https://github.com/geogale/2011OAC) (2011 OAC) introduced in [Chapter 3](data-manipulation.html). The dataset includes public sector information licensed under the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) from the [Office for National Statistics](https://www.ons.gov.uk/).

The 2011 OAC is a geodemographic classification of the census Output Areas (OA) of the UK, which was created by [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) starting from an initial set of 167 prospective variables from the United Kingdom Census 2011: 86 were removed, 41 were retained as they are, and 40 were combined, leading to a final set of 60 variables. [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) finally used the k-means clustering approach to create 8 clusters or supergroups (see [map at datashine.org.uk](https://oac.datashine.org.uk)), as well as 26 groups and 76 subgroups. The dataset in the file `2011_OAC_Raw_uVariables_Leicester.csv` contains all the original 167 variables, as well as the resulting groups, for the city of Leicester. 



## Instructions {-}

Before continuing with the remainder of the groupwork, create a new project named *Leicester_health_education* and make sure it is activated. 

Download from Blackboard (or see the [data](https://github.com/sdesabbata/granolarr/tree/master/data) folder of the repository) the `2011_OAC_Raw_uVariables_Leicester.csv` file on your computer (and upload it to the RStudio Server if necessary, if not done already). The full variable names can be found in the file `2011_OAC_Raw_uVariables_Lookup.csv`. Write an RMarkdown document to be compiled into a PDF or HTML file presenting the answers to the questions listed below. You should present the answers in the same order as they are listed, each in a separate section of the document, including the code, the output and the textual component as required.

## Part 1 {-}

Conduct an **exploratory analysis** of the variables listed in Table 1. Include the code, the output (can include graphics) and a description of the findings. The latter should be up to 500 words and it can be written as a final discussion after the analysis, or as a description of each step of the analysis, or a combination of the two.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-1)Variables to be used for Part 1 and 2 of this groupwork exercise</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> VariableCode </th>
   <th style="text-align:left;"> VariableDescription </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> u104 </td>
   <td style="text-align:left;"> Day-to-day activities limited a lot or a little Standardised Illness Ratio </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u105 </td>
   <td style="text-align:left;"> Very good health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u106 </td>
   <td style="text-align:left;"> Good health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u107 </td>
   <td style="text-align:left;"> Fair health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u108 </td>
   <td style="text-align:left;"> Bad health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u109 </td>
   <td style="text-align:left;"> Very bad health </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u110 </td>
   <td style="text-align:left;"> Provides unpaid care </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u111 </td>
   <td style="text-align:left;"> No qualifications </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u112 </td>
   <td style="text-align:left;"> Highest level of qualification: Level 1, Level 2 or Apprenticeship </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u113 </td>
   <td style="text-align:left;"> Highest level of qualification: Level 3 qualifications </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u114 </td>
   <td style="text-align:left;"> Highest level of qualification: Level 4 qualifications and above </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u115 </td>
   <td style="text-align:left;"> Schoolchildren and full-time students: Age 16 and over </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u159 </td>
   <td style="text-align:left;"> Managers, directors and senior officials </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u160 </td>
   <td style="text-align:left;"> Professional occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u161 </td>
   <td style="text-align:left;"> Associate professional and technical occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u162 </td>
   <td style="text-align:left;"> Administrative and secretarial occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u163 </td>
   <td style="text-align:left;"> Skilled trades occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u164 </td>
   <td style="text-align:left;"> Caring, leisure and other service occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u165 </td>
   <td style="text-align:left;"> Sales and customer service occupations </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u166 </td>
   <td style="text-align:left;"> Process, plant and machine operatives </td>
  </tr>
  <tr>
   <td style="text-align:left;"> u167 </td>
   <td style="text-align:left;"> Elementary occupations </td>
  </tr>
</tbody>
</table>



## Part 2 {-}

Select two among the variables explored in *Part 1* (see Table 1) to create a robust (where possible), **simple linear regression** model. The model should have as outcome (dependent) variable an indicator of the health of the population and as predictors (independent) variables a variables related to occupation. The variables should be selected based on the outcome of the analysis done for *Part 1*, in order to ensure that the model is as strong and robust as possible.

$$health = occupation + error $$

Remember *"correlation does not imply causation"*. 😊


## Part 3 {-}

Use the variables explored in *Part 1* (see Table 1) to create a robust (where possible), **multiple linear regression** model. The model should have as outcome (dependent) variable an indicator of the health of the population. The indicator can be one of the variables explored in *Part 1* (see Table 1) or a combination thereof. The model should have as predictors (independent) variables a relevant set of variables related to education and occupation. 


$$health = (education + occupation) + error $$

Present the model that achieves the best fit and the process through which it has been identified. Include the code, the output (can include graphics), a discussion of the process and an interpretation of the final model. The latter two should be up to 500 words and it can be written as a final discussion after the analysis, or as a description of each step of the analysis, or a combination of the two.

Alternatively, **if no robust model or no significant model can be created** for Leicester, include the code and the output (can include graphics) that illustrate that finding, and a related discussion (still, up to 500 words). The latter could be written as a final discussion after the analysis, or as a description of each step of the analysis, or a combination of the two.

...again, remember *"correlation does not imply causation"*. 😊


---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>

