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

This project demonstrates a complete end-to-end data analytics workflow, turning a complex and sensitive dataset into actionable insights that can support research, risk assessment, and informed discussions on global security trends.

# Dataset Structure, Data Cleaning & Initial Checks 📑
The Global Terrorism Database (GTD) contains detailed information on terrorist incidents worldwide, with over 180,000 recorded events spanning multiple decades and regions. Each record includes information on the date, location, attack type, target, casualties, perpetrators, and weapons used.

Before starting the analysis, the dataset was thoroughly cleaned and pre-processed using Python (Pandas) to handle missing values, inconsistent fields, and irrelevant records. 
Key steps included:
- Dropping unnecessary columns and filling missing values for critical fields like summary, motive, city, provstate, nkill, nwound, and attacktype1_txt.
- Creating derived columns such as date_quality (to indicate whether the full date, year-month, or only year is known) and severity_level (to categorize incidents based on fatalities).
- Identifying invalid or negative casualty counts and ensuring data consistency.
- Preparing the dataset for SQL-based analysis and Power BI visualization.
  
SQL queries were used to perform additional quality checks, explore trends, and validate assumptions. These queries helped identify missing coordinates, group activity, attack success rates, and other key metrics.
An interactive Power BI dashboard was later built using this cleaned and structured dataset to visualize global and regional terrorism patterns, trends over time, and the severity of incidents.
