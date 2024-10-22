# Brain morphometry and cognition as predictors of IBS

INITIATED: [Arvid Lundervold](https://www.uib.no/en/persons/Arvid.Lundervold), 2024-10-21

[Code](https://github.com/arvidl/ibs-brain/tree/main/notebooks) and [data](./data) accompanying the paper: <br>

Julie Billing, Ben René Bjørsvik, Daniela M. Pfabigan, Birgitte Berentsen, Gülen Arslan Lied, Elisabeth K Steinsvik, Trygve Hausken, Astri J. Lundervold, and Arvid Lundervold.
**Brain morphometry and cognition as predictors of irritable bowel syndrome.**
In prep.


![img](https://github.com/arvidl/ibs-brain/blob/main/figs/ASEG_Native_cross_in_Left_Thalamus_BGA_046.png)

**ABSTRACT** (in prep.)

_Background_. Irritable bowel syndrome (IBS) is a disorder within the brain-gut-axis-related diseases, characterized by abdominal pain, bloating, and altered bowel habits. The prevalence is high, 5-10\% globally, with a female-to-male ratio of $\sim$ 2:1. A recent study (2022) by Skrobisz and collaborators reported that brain morphometric measures, in particular (eTIV-)normalized volume of the left thalamus, could distinguish between patients with IBS and healthy controls (HCs).<br> 
_Objectives_. We aim to replicate the findings of Skrobisz et al. and extend their study by including information about sex and cognitive function and incorporating multivariate statistics and prediction models in a machine-learning framework.  <br>
_Methods_. A sample of $78$ participants, $49$ with IBS and $29$ HCs underwent a multiparametric MRI examination,  
performed the Repeatable Battery for the Assessment of Neuropsychological Status (RBANS), and reported age and sex. 
An automated brain segmentation and parcellation method (Freesurfer versions FS 6.0 and 7.4.1) was executed to obtain a collection of predefined brain morphometric measures from each individual. Univariate and multivariate statistical methods, including classification models from machine learning, were then used to analyze the degree of brain differences between the IBS and the HC group and the prediction accuracy based on MRI-derived measures alone and when included together with measures of cognitive function. With the inclusion of more women than men in the current study, we also investigated the value of morphometric measures in predicting sex. Analyses of feature importance were included to investigate the relative weight of the included measures.  <br> 
_Results_. The findings reported by Skrobisz and collaborators, using FS 6.0, could not be replicated in our sample. Results produced by a more recent version of the  MRI data suggested a software-dependent bias and complex non-biological variation. The multivariate analyses confirmed poor separation between IBS and HCs in morphometric space. The memory-related RBANS scores were significantly lower in the IBS than in the HC group, and adding information about the RBANS indexes improved the prediction of IBS versus HC, with the strongest importance of left hippocampus, verbal index, putamen, and the central region of the corpus callosum. The brain morphometric patterns did also distinguish well between women and men though, with the strongest importance of eTIV, left hippocampus, and corpus callosum volumes. <br>
_Discussion_. The strong sex-related differences in specific brain regions, like the hippocampus and various white matter areas, align with existing knowledge. The improved distinction between IBS and HCs when brain morphometric measures were added by cognitive indexes calls for future studies of the brain-gut relationship in IBS that incorporate additional MRI modalities (e.g., diffusion MRI and functional MRI) and a wider range of clinical variables.  


**Keywords**<br>
Irritable bowel syndrome; structural MRI; brain morphometry, cognition; supervised classification; machine learning

----
Last updated: 2024-10-22
