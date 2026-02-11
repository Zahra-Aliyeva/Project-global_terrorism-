# Overview 📖
This project explores global terrorism patterns using the Global Terrorism Database (GTD). The raw data was first cleaned and pre-processed with Python (Pandas) to handle missing values, inconsistencies, and irrelevant records. After cleaning, SQL queries were used to analyze trends over time, regional differences, attack and target types, group activity, and incident severity.

The final, analysis-ready dataset was visualized in Power BI, creating interactive dashboards that highlight global and regional patterns, the evolution of terrorist activity, and the impact of different attack methods. 

# Project Background
The Global Terrorism Database (GTD) is one of the most comprehensive open-source datasets on terrorist events worldwide, covering incidents across countries, regions, and decades. Despite its richness, much of this data is complex, inconsistent, and underutilized.

This project focuses on cleaning, structuring, and analyzing the GTD to uncover meaningful insights into global terrorism patterns. The raw data was first processed using Python (Pandas) to handle missing values, inconsistent records, and irrelevant fields. After preparing the data, SQL queries were used to explore trends over time, identify high-risk regions, examine attack and target types, and assess incident severity.

Insights and analysis in this project cover the following key areas:
- Temporal Trends: Examining how terrorist activity has evolved over the years and detecting yearly changes in attack frequency.
- Geographical Distribution: Comparing incidents across countries and regions, including analysis of events with missing or incomplete coordinates.
- Attack Severity & Risk: Evaluating the impact of attacks using fatalities, injuries, and a custom risk score to highlight the most severe incidents.
- Group & Weapon Analysis: Assessing which terrorist groups are most active and “successful” and the types of weapons most frequently used.

Interactive Power BI dashboards were created to visualize these patterns and make the data easy to explore. SQL queries used for data cleaning, validation, and targeted analysis are included in the project to ensure reproducibility and transparency.

# Dataset Structure, Data Cleaning & Initial Checks 📑
The Global Terrorism Database (GTD) contains detailed information on terrorist incidents worldwide, with over 180,000 recorded events spanning multiple decades and regions. Each record includes information on the date, location, attack type, target, casualties, perpetrators, and weapons used.

Before starting the analysis, the dataset was thoroughly cleaned and pre-processed using Python (Pandas) to handle missing values, inconsistent fields, and irrelevant records. 
Steps taken to clean, check data quality and prep the dataset for analysis can be found [here](https://github.com/Zahra-Aliyeva/Project-global_terrorism-/blob/main/GTD%20python(pandas).ipynb).
  
SQL queries were used to perform additional quality checks, explore trends, and validate assumptions. These queries helped identify missing coordinates, group activity, attack success rates, and other key metrics.
An interactive Power BI dashboard was later built using this cleaned and structured dataset to visualize global and regional terrorism patterns, trends over time, and the severity of incidents.

# Exploratory Data Analysis 🔎
For the exploratory phase, I used SQL to dig into the Global Terrorism Database and better understand its structure and patterns. The analysis focused on yearly attack trends, country-level summaries, severity levels, weapon types, group success rates, missing geographic coordinates, and a custom risk score based on casualties.

All analytical queries were written in a single SQL script, which can be found [here](https://github.com/Zahra-Aliyeva/Project-global_terrorism-/blob/main/sql(global_terrorism).sql)

<img width="1317" height="737" alt="Screenshot power bi" src="https://github.com/user-attachments/assets/179ab7c0-47d8-4152-b79c-8609895ba6e7" />


After completing the analysis the cleaned and structured data was imported into Power BI to build an interactive dashboard. The dashboard allows users to filter by year, country, region, attack type, and severity level, making it easier to explore global and regional terrorism patterns dynamically. 
The dashboard can be found in Power BI [here](https://github.com/Zahra-Aliyeva/Project-global_terrorism-/blob/main/globalterrorism.pbix)

# Findings & Insights 💡
Overall Trends:

•	Looking at annual terrorist activity, the number of attacks shows clear peaks and troughs rather than a steady trend. Significant increases are visible in certain decades, while other periods show relative calm. This fluctuation reflects the influence of geopolitical events, conflicts, and regional instability.
•	Geographically, attacks are not evenly distributed. Certain countries and regions experience the bulk of incidents, while others see relatively few. This highlights that terrorism risk is highly concentrated in specific hotspots rather than being globally uniform.

Severity & Risk Patterns:

•	Grouping incidents by severity shows that most attacks fall into low or medium severity, yet a small number of high-severity attacks account for a disproportionately large share of total casualties. In other words, “few but extremely impactful” events drive much of the overall death and injury statistics.
•	The calculated risk scores (nkill * 2 + nwound) reveal that a handful of attacks carry extremely high impact, often occurring in major cities and involving explosives. Incidents without recorded coordinates tend to have lower average severity, likely reflecting incomplete reporting or smaller-scale events.

Weapon & Target Analysis:

•	Explosives are the most frequently used and deadliest weapon type, while firearms are common but generally less lethal in aggregate.
•	Target analysis shows that certain target types are repeatedly attacked, suggesting that many incidents are strategic rather than random. Cross-analyzing weapon and target types reveals clear patterns: some weapon-target combinations occur more frequently, indicating tactical preferences among perpetrators.

Group Activity & Success Rate:

•	Examining groups with at least 20 attacks shows that some maintain both high activity and high success rates. However, a high success rate doesn’t always correlate with high casualties, some groups carry out many low-impact attacks. This distinction highlights the difference between operational effectiveness and destructive impact.

Temporal & Seasonal Insights:

•	Monthly distribution suggests that attacks occur year-round, but spikes in specific months hint at seasonal factors or politically significant periods.
•	Looking at the deadliest incident, each year shows that the countries most affected by severe attacks vary over time, underlining how risk shifts geographically as global and regional dynamics change.
Suspicious vs Confirmed Incidents:
•	Comparing confirmed and doubtful incidents reveals that confirmed attacks generally result in higher casualties. This likely reflects better reporting for high-impact events, while minor or ambiguous events are more often classified as doubtful.



