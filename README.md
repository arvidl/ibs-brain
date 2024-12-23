# Brain morphometry and cognition as predictors of IBS

INITIATED: [Arvid Lundervold](https://www.uib.no/en/persons/Arvid.Lundervold), 2024-10-21

[Code](https://github.com/arvidl/ibs-brain/tree/main/notebooks) and [data](./data) accompanying the paper: <br>

Arvid Lundervold, Ben René Bjørsvik, Julie Billing, Birgitte Berentsen, Gülen Arslan Lied, Elisabeth K Steinsvik,  Trygve Hausken, Daniela M. Pfabigan, Astri J. Lundervold.
**Brain morphometry and cognitive features in prediction of irritable bowel syndrome**.
_Submitted_


![img](https://github.com/arvidl/ibs-brain/blob/main/figs/ASEG_Native_cross_in_Left_Thalamus_BGA_046.png)

**ABSTRACT** 

_Background/Objectives_: Irritable bowel syndrome (IBS) is a gut-brain disorder characterized by abdominal pain, altered bowel habits, and psychological distress. While brain-gut interactions are recognized in IBS pathophysiology, the relationship between brain morphometry, cognitive function, and clinical features remains poorly understood. The study aims to (i) replicate previous univariate morphometric findings in IBS patients and conduct software comparisons; (ii) investigate whether multivariate analysis of brain morphometric measures and cognitive performance can distinguish IBS patients from healthy controls (HCs), and evaluate the importance of structural and cognitive features in this discrimination. 
_Methods_: We studied 49 IBS patients and 29 HCs using structural brain MRI and the Repeatable Battery for the Assessment of Neuropsychological Status (RBANS). Brain morphometry was analyzed using FreeSurfer v6.0.1 and v7.4.1, with IBS severity assessed via IBS-Severity Scoring System. We employed univariate, multivariate, and machine learning approaches with cross-validation. 
_Results_: FreeSurfer version comparison revealed substantial variations in morphometric measurements. While morphometric measures alone showed limited discrimination between groups, combining morphometric and cognitive measures achieved 93% sensitivity in identifying IBS patients (22% specificity). Feature importance analysis highlighted the role of subcortical structures (hippocampus, caudate, putamen) and cognitive domains (recall and verbal skills) in group discrimination. 
_Conclusions_: Our comprehensive open-source framework suggests that combining brain morphometry and cognitive measures improves IBS-HC discrimination compared to morphometric measures alone. The importance of subcortical structures and specific cognitive domains supports complex brain-gut interaction in IBS, emphasizing the need for multimodal approaches and rigorous methodological considerations. <br>
GitHub: https://github.com/arvidl/ibs-brain 



**Keywords**<br>
Irritable bowel syndrome; structural MRI; brain morphometry, cognition; supervised classification; machine learning; open-source



### Notebooks

Every figure and table in the manuscript is linked (in its caption) to the corresponding notebook:

- 01-freesurfer-freeview-t1-aseg-bga-046.ipynb (Fig. 1, Fig. 2, Fig. A2)
- 02-demographics-and-clinical-characteristics.ipynb (Tab. 2)
- 03-replication-analysis-fs6.ipynb (Tab. 3, Fig. 3, Fig. 4)
- 04-comparing-FS-versions-on-same-dataset.ipynb (Fig. 5, Fig. 6, Fig. 7, Fig. 8, Tab. A2, Tab. A3)
- 05-predicting-IBS-vs-HC-from-morphometric-measures.ipynb (Fig. 9, Fig. 10, Fig. A1)
- 06-morphometry-cognition-exploration.ipynb (Tab. 4, Fig. 11)
- 07-predicting-IBS-vs-HC-from-morphometry-and-cognition.ipynb (Fig. 12, Tab. 5, Fig. 13)
  
----
Last updated: 2024-12-22
