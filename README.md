# Brain morphometry and cognition as predictors of IBS

INITIATED: [Arvid Lundervold](https://www.uib.no/en/persons/Arvid.Lundervold), 2024-10-21

[Code](https://github.com/arvidl/ibs-brain/tree/main/notebooks), [data](./data), and [images](https://github.com/arvidl/ibs-brain/tree/main/data/BGA_046) accompanying the paper: <br>

Arvid Lundervold, Ben René Bjørsvik, Julie Billing, Birgitte Berentsen, Gülen Arslan Lied, Elisabeth K Steinsvik,  Trygve Hausken, Daniela M. Pfabigan, Astri J. Lundervold.
**Brain morphometry and cognitive features in prediction of irritable bowel syndrome**.
_Submitted_   [[preprint](https://www.preprints.org/manuscript/202412.2149/v1)]


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

- [01-freesurfer-freeview-t1-aseg-bga-046.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/01-freesurfer-freeview-t1-aseg-bga-046.ipynb) $\rightarrow$ {[Fig. 1](https://github.com/arvidl/ibs-brain/blob/main/figs/T1_mprage_BGA_046.png), [Fig. 2](https://github.com/arvidl/ibs-brain/blob/main/figs/ASEG_Native_cross_in_Left_Thalamus_BGA_046.png), [Fig. A2](https://github.com/arvidl/ibs-brain/blob/main/figs/Histo_atlas_segentation_fs8_BGA_046.png)}
- [02-demographics-and-clinical-characteristics.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/02-demographics-and-clinical-characteristics.ipynb) $\rightarrow$ {[Tab. 2](https://github.com/arvidl/ibs-brain/blob/main/latex/tables/demographic_characteristics_table.tex)}
- [03-replication-analysis-fs6.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/03-replication-analysis-fs6.ipynb) $\rightarrow$ {Tab. 3, Fig. 3, Fig. 4}
- [04-comparing-FS-versions-on-same-dataset.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/04-comparing-FS-versions-on-same-dataset.ipynb) $\rightarrow$ {[Fig. 5](https://github.com/arvidl/ibs-brain/blob/main/figs/fs6_cross_vs_fs7_cross_version_comparison.png), Fig. 6, Fig. 7, Fig. 8, Tab. A2, Tab. A3}
- [05-predicting-IBS-vs-HC-from-morphometric-measures.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/05-predicting-IBS-vs-HC-from-morphometric-measures.ipynb) $\rightarrow$ {Fig. 9, Fig. 10, Fig. A1}
- [06-morphometry-cognition-exploration.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/06-morphometry-cognition-exploration.ipynb) $\rightarrow$ {Tab. 4, [Fig. 11](https://github.com/arvidl/ibs-brain/blob/main/figs/spearman_correlation_matrix_RBANS_ASEG.png)}
- [07-predicting-IBS-vs-HC-from-morphometry-and-cognition.ipynb](https://github.com/arvidl/ibs-brain/blob/main/notebooks/07-predicting-IBS-vs-HC-from-morphometry-and-cognition.ipynb) $\rightarrow$ {[Fig. 12a](https://github.com/arvidl/ibs-brain/blob/main/figs/annotated_xgboost_confusion_matrix_using_ASEG_and_RBANS.png), Fig. 12b, Tab. 5, Fig. 13}


Conda environment `ibs-brain`: [environment.yml](https://github.com/arvidl/ibs-brain/blob/main/environment.yml)
  
----
Last updated: 2024-12-28
