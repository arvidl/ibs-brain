# FreeSurfer recon-all Help Documentation

## USAGE
`recon-all`

### Required Arguments
- `-subjid <subjid>`
- `-<process directive>`

### Fully-Automated Directive
- `-all`: performs all stages of cortical reconstruction
- `-autorecon-all`: same as `-all`

### Manual-Intervention Workflow Directives
- `-autorecon1`: process stages 1-5 (see below)
- `-autorecon2`: process stages 6-23
  - after autorecon2, check white surfaces:
    - a. if wm edit was required, then run `-autorecon2-wm`
    - b. if control points added, then run `-autorecon2-cp`
    - c. proceed to run `-autorecon3`
- `-autorecon2-cp`: process stages 12-23 (uses -f w/ mri_normalize, -keep w/ mri_seg)
- `-autorecon2-wm`: process stages 15-23
- `-autorecon2-inflate1`: 6-18
- `-autorecon2-perhemi`: tess, sm1, inf1, q, fix, sm2, inf2, finalsurf, ribbon
- `-autorecon3`: process stages 24-34
  - if edits made to correct pial, then run `-autorecon-pial`
- `-hemi ?h`: just do lh or rh (default is to do both)

### Autorecon Processing Stages
1. Motion Correction and Conform
2. NU (Non-Uniform intensity normalization)
3. Talairach transform computation
4. Intensity Normalization 1
5. Skull Strip
6. EM Register (linear volumetric registration)
7. CA Intensity Normalization
8. CA Non-linear Volumetric Registration 
9. Remove neck
10. EM Register, with skull
11. CA Label (Aseg: Volumetric Labeling) and Statistics
12. Intensity Normalization 2 (start here for control points)
13. White matter segmentation
14. Edit WM With ASeg
15. Fill (start here for wm edits)
16. Tessellation (begins per-hemisphere operations)
17. Smooth1
18. Inflate1
19. QSphere
20. Automatic Topology Fixer
21. White Surfs (start here for brain edits for pial surf)
22. Smooth2
23. Inflate2
24. Spherical Mapping
25. Spherical Registration 
26. Spherical Registration, Contralater hemisphere
27. Map average curvature to subject
28. Cortical Parcellation (Labeling)
29. Cortical Parcellation Statistics
30. Pial Surfs
31. WM/GM Contrast
32. Cortical Ribbon Mask
33. Cortical Parcellation mapped to ASeg
34. Brodmann and exvio EC labels

## Expert Preferences
- `-pons-crs C R S`: col, row, slice of seed point for pons, used in fill
- `-cc-crs C R S`: col, row, slice of seed point for corpus callosum, used in fill
- `-lh-crs C R S`: col, row, slice of seed point for left hemisphere, used in fill
- `-rh-crs C R S`: col, row, slice of seed point for right hemisphere, used in fill
- `-nofill`: do not use the automatic subcort seg to fill
- `-watershed cmd`: control skull stripping/watershed program
- `-xmask file`: custom external brain mask to replace automated skullstripping
- `-wsless`: decrease watershed threshold (leaves less skull, but can strip more brain)
- `-wsmore`: increase watershed threshold (leaves more skull, but can strip less brain)
- `-wsatlas`: use atlas when skull stripping
- `-no-wsatlas`: do not use atlas when skull stripping
- `-no-wsgcaatlas`: do not use GCA atlas when skull stripping
- `-wsthresh pct`: explicity set watershed threshold
- `-wsseed C R S`: identify an index (C, R, S) point in the skull

### Advanced Normalization Options
- `-norm3diters niters`: number of 3d iterations for mri_normalize
- `-normmaxgrad maxgrad`: max grad (-g) for mri_normalize. Default is 1.
- `-norm1-b N`: in first usage of mri_normalize, use control point with intensity N below target (default=10.0)
- `-norm2-b N`: in second usage of mri_normalize, use control point with intensity N below target (default=10.0)
- `-norm1-n N`: in first usage of mri_normalize, do N number of iterations
- `-norm2-n N`: in second usage of mri_normalize, do N number of iterations

### Other Expert Options
- `-cm`: conform volumes to the min voxel size
- `-no-fix-with-ga`: do not use genetic algorithm when fixing topology
- `-fix-diag-only`: topology fixer runs until ?h.defect_labels files are created, then stops
- `-seg-wlo wlo`: set wlo value for mri_segment and mris_make_surfaces
- `-seg-ghi ghi`: set ghi value for mri_segment and mris_make_surfaces
- `-nothicken`: pass '-thicken 0' to mri_segment
- `-no-ca-align-after`: turn off -align-after with mri_ca_register
- `-no-ca-align`: turn off -align with mri_ca_label
- `-deface`: deface subject, written to orig_defaced.mgz

### Expert File Options
- `-expert file`: read-in expert options file
- `-xopts-use`: use pre-existing expert options file
- `-xopts-clean`: delete pre-existing expert options file
- `-xopts-overwrite`: overwrite pre-existing expert options file
- `-termscript script`: run script before exiting (multiple -termscript flags possible)

### Scanner-Specific Options
- `-mprage`: assume scan parameters are MGH MP-RAGE protocol
- `-washu_mprage`: assume scan parameters are Wash.U. MP-RAGE protocol
- `-schwartzya3t-atlas`: for tal reg, use special young adult 3T atlas

### Performance Options
- `-threads num`: set number of threads to use

## Notification Files (Optional)
- `-waitfor file`: wait for file to appear before beginning
- `-notify file`: create this file after finishing

## Status and Log Files (Optional)
- `-log file`: default is scripts/recon-all.log
- `-status file`: default is scripts/recon-all-status.log
- `-noappend`: start new log and status files instead of appending
- `-no-isrunning`: do not check whether this subject is currently being processed

## Segmentation of Substructures
### Hippocampus and Brainstem Segmentation
(These are deprecated; please see segmentHA_T1.sh, segmentHA_T2.sh, segmentHA_T1_long.sh, segmentBS.sh)
- `-hippocampal-subfields-T1`: segmentation of hippocampal subfields using input T1 scan
- `-hippocampal-subfields-T2 file ID`: segmentation using an additional scan
- `-hippocampal-subfields-T1T2 file ID`: segmentation using additional scan and input T1
- `-brainstem-structures`: segmentation of brainstem structures

## Other Arguments (Optional)
- `-sd subjectsdir`: specify subjects dir (default env SUBJECTS_DIR)
- `-mail username`: mail user when done
- `-umask umask`: set unix file permission mask (default 002)
- `-grp groupid`: check that current group is alpha groupid
- `-onlyversions`: print version of each binary and exit
- `-debug`: print out lots of info
- `-allowcoredump`: set coredump limit to unlimited
- `-dontrun`: do everything but execute each command
- `-version`: print version of this script and exit
- `-help`: voluminous bits of wisdom

Version: 8.0.0-beta (freesurfer-macOS-darwin_x86_64-8.0.0-beta-20241103-b8aacdc)

## Basic Usage

### 1. When Subject Directory Does Not Exist
```bash
recon-all -subject subjectname -i invol1 <-i invol2> -all
```
Creates analysis directory `$SUBJECTS_DIR/subjectname`, converts input volumes to MGZ format in subjectname/mri/orig, and runs all processing steps.

### 2. Manual Conversion into MGZ
```bash
mkdir -p $SUBJECTS_DIR/subjectname/mri/orig
mri_convert invol1 $SUBJECTS_DIR/subjectname/mri/orig/001.mgz
mri_convert invol2 $SUBJECTS_DIR/subjectname/mri/orig/002.mgz
recon-all -subject subjectname -all
```

## Subject Identification String
- `-s subjectname`
- `-sid subjectname`
- `-subjid subjectname`
- `-subject subjectname`

## Directives Usage
Directives instruct recon-all which part(s) of the reconstruction stream to run. While possible to do everything at once with `-all`, there can be benefits to customizing the stream for manual editing and parallelization.

### Clustered Directives
- `-all` or `-autorecon-all`: Perform all reconstruction steps
- `-autorecon1`: Motion correction through skull strip
- `-autorecon2`: Subcortical segmentation through white surfaces
- `-autorecon2-cp`: Normalization2 through final surfaces
- `-autorecon2-wm`: Fill through white surfaces
- `-autorecon-pial`: Makes final surfaces (white and pial)
- `-autorecon3`: Spherical morph, automatic cortical parcellation, pial surf and ribbon mask

## Step-wise Directives
Approximate run times on Intel Xeon E5-2643 64bit 3.4GHz processor:

| Step | Time |
|------|------|
| `-motioncor` | 2 min |
| `-talairach` | < 1 min |
| `-normalization` | 2 min |
| `-skullstrip` | 15 min |
| `-nuintensitycor` | 1 min |
| `-gcareg` | 15 min |
| `-canorm` | 1 min |
| `-careg` | 1 hour |
| `-rmneck` | 1 min |
| `-skull-lta` | 12 min |
| `-calabel` | 34 min |
| `-normalization2` | 3 min |
| `-maskbfs` | < 1 min |
| `-segmentation` | 1 min |
| `-fill` | 1 min |
| `-tessellate` | < 1 min per hemisphere |
| `-smooth1` | < 1 min per hemisphere |
| `-inflate1` | 1 min per hemisphere |
| `-qsphere` | 3 min per hemisphere |
| `-fix` | 15 min per hemisphere |
| `-white` | 3 min per hemisphere |
| `-smooth2` | < 1 min per hemisphere |
| `-inflate2` | < 1 min per hemisphere |
| `-all` | 7 hours both hemispheres |

Note: With `-parallel`, runtime is reduced to 3 hours.

## Longitudinal Processing
The longitudinal processing scheme incorporates subject-wise correlation of longitudinal data to increase sensitivity and repeatability.

### Workflow
1. Cross-sectionally process timepoints:
```bash
recon-all -s tp1 -i path_to_tp1_dicom -all
recon-all -s tp2 -i path_to_tp2_dicom -all
```

2. Create and process unbiased base:
```bash
recon-all -base longbase -tp tp1 -tp tp2 -all
```

3. Longitudinally process timepoints:
```bash
recon-all -long tp1 longbase -all
recon-all -long tp2 longbase -all
```

### Additional Longitudinal Options
- `-uselongbasectrlvol`: Use control-points from base in long runs
- `-uselongbasewmedits`: Transfer WM edits from base/template
- `-no-orig-pial`: Skip orig pial surface data if unavailable
- `-noasegfusion`: Do not create 'fused' aseg from longbase timepoints
- `-addtp`: Add new timepoint to existing longitudinal run

## Using 3T Scanner Images
The `-3T` flag enables:
- 3T-specific NU intensity correction parameters
- Schwartz 3T atlas for Talairach alignment

## T2 or FLAIR Integration
Improve pial surfaces using T2 or FLAIR images:

### Options
- `-T2 <input T2 volume>` or `-FLAIR <input FLAIR volume>`
- `-T2pial` or `-FLAIRpial`

### Example Usage
```bash
# New processing with T2
recon-all -s subjectname -i /path/to/input -T2 /path/to/T2_input -T2pial -all

# Add T2 to existing subject
recon-all -s subjectname -T2 /path/to/T2_volume -T2pial -autorecon3
```

## Manual Checking and Editing
1. Edit segmentation:
```bash
tkmedit subjid wm.mgz -aux T1.mgz
```

2. View inflated surface with volume:
```bash
tksurfer subjid lh inflated
```

For detailed tutorials, visit: https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial

## Flattening Process
1. Load surface:
```bash
tksurfer subjid lh inflated
```

2. Flatten the patch:
```bash
mris_flatten -w N -distances Size Radius lh.patch.3d lh.patch.flat
```

## Getting Help
- Website: https://surfer.nmr.mgh.harvard.edu
- Email: freesurfer@nmr.mgh.harvard.edu

## References
For a complete list of references, see: https://www.zotero.org/freesurfer

Key references include:
1. Collins et al. (1994) - Automatic 3D Inter-Subject Registration
2. Dale et al. (1999) - Cortical Surface-Based Analysis I
3. Fischl et al. (1999) - Cortical Surface-Based Analysis II
4. Fischl et al. (2002) - Whole Brain Segmentation
5. Reuter et al. (2010) - Highly Accurate Inverse Consistent Registration
6. Iglesias et al. (2015) - Computational Atlas of Hippocampal Formation
7. Saygin & Kliemann et al. (2017) - High-resolution MRI of Human Amygdala




REFERENCES

See https://www.zotero.org/freesurfer

[1] Collins, DL, Neelin, P., Peters, TM, and Evans, AC. (1994)
Automatic 3D Inter-Subject Registration of MR Volumetric Data in
Standardized Talairach Space, Journal of Computer Assisted Tomography,
18(2) p192-205, 1994 PMID: 8126267; UI: 94172121

[2] Cortical Surface-Based Analysis I: Segmentation and Surface
Reconstruction Dale, A.M., Fischl, Bruce, Sereno, M.I.,
(1999). Cortical Surface-Based Analysis I: Segmentation and Surface
Reconstruction.  NeuroImage 9(2):179-194

[3] Fischl, B.R., Sereno, M.I.,Dale, A. M.  (1999) Cortical
Surface-Based Analysis II: Inflation, Flattening, and Surface-Based
Coordinate System. NeuroImage, 9, 195-207.

[4] Fischl, Bruce, Sereno, M.I., Tootell, R.B.H., and Dale, A.M.,
(1999). High-resolution inter-subject averaging and a coordinate
system for the cortical surface. Human Brain Mapping, 8(4): 272-284

[5] Fischl, Bruce, and Dale, A.M., (2000).  Measuring the Thickness of
the Human Cerebral Cortex from Magnetic Resonance Images.  Proceedings
of the National Academy of Sciences, 97:11044-11049.

[6] Fischl, Bruce, Liu, Arthur, and Dale, A.M., (2001). Automated
Manifold Surgery: Constructing Geometrically Accurate and
Topologically Correct Models of the Human Cerebral Cortex. IEEE
Transactions on Medical Imaging, 20(1):70-80

[7] Non-Uniform Intensity Correction.
http://www.nitrc.org/projects/nu_correct/

[8] Fischl B, Salat DH, Busa E, Albert M, Dieterich M, Haselgrove C,
van der Kouwe A, Killiany R, Kennedy D, Klaveness S, Montillo A,
Makris N, Rosen B, Dale AM. Whole brain segmentation: automated
labeling of neuroanatomical structures in the human
brain. Neuron. 2002 Jan 31;33(3):341-55.

[9] Bruce Fischl, Andre van der Kouwe, Christophe Destrieux, Eric
Halgren, Florent Segonne, David H. Salat, Evelina Busa, Larry
J. Seidman, Jill Goldstein, David Kennedy, Verne Caviness, Nikos
Makris, Bruce Rosen, and Anders M. Dale.  Automatically Parcellating
the Human Cerebral Cortex. Cerebral Cortex January 2004; 14:11-22.

[10] Fischl B, Salat DH, van der Kouwe AJW, Makris N, Ségonne F, Dale
AM. Sequence-Independent  Segmentation of Magnetic Resonance Images.
NeuroImage 23 Suppl 1, S69-84.

[11] Segonne F, Dale, AM, Busa E, Glessner M, Salvolini U, Hahn HK,
Fischl B, A Hybrid Approach to the Skull-Stripping Problem in MRI.
NeuroImage, 22,  pp. 1160-1075, 2004

[12] Han et al.,  Reliability of MRI-derived measurements of human
cerebral cortical thickness: The effects of field strength, scanner
upgrade and manufacturer, (2006) NeuroImage, 32(1):180-194.

[13] Schaer et al., A Surface-based Approach to Quantify Local Cortical
Gyrification (2007) IEEE Transactions on Medical Imaging.

[14] Martin Reuter, H Diana Rosas, Bruce Fischl.
Highly Accurate Inverse Consistent Registration: A Robust Approach.
NeuroImage 53(4), 1181-1196, 2010. http://dx.doi.org/10.1016/j.neuroimage.2010.07.020

[15] Martin Reuter, Bruce Fischl.
Avoiding Asymmetry-Induced Bias in Longitudinal Image Processing.
NeuroImage 51(1), 19-21, 2011. http://dx.doi.org/10.1016/j.neuroimage.2011.02.076

[16] Martin Reuter, Nicholas J Schmansky, H Diana Rosas, Bruce Fischl.
Within-Subject Template Estimation for Unbiased Longitudinal Image Analysis.
NeuroImage 61(4), 1402-1418, 2012. http://dx.doi.org/10.1016/j.neuroimage.2012.02.084

[17] Iglesias, J.E., Augustinack, J.C., Nguyen, K., Player, C.M., Player, A., Wright,
M., Roy, N., Frosch, M.P., McKee, A.C., Wald, L.L., Fischl, B., and Van Leemput, K.,
A computational atlas of the hippocampal formation using ex vivo, ultra-high resolution
MRI: Application to adaptive segmentation of in vivo MRI.  Neuroimage 115, 2015, 117-137. 
http://dx.doi.org/10.1016/j.neuroimage.2015.04.042

[18] Iglesias, J.E., Van Leemput, K., Bhatt, P., Casillas, C., Dutt, S., Schuff, N.,
Truran-Sacrey, D., Boxer, A., and Fischl, B., Bayesian segmentation of brainstem 
structures in MRI. Neuroimage 113, 2015, 184-195.
http://dx.doi.org/10.1016/j.neuroimage.2015.02.065

[19] Saygin, Z.M. & Kliemann, D. (joint 1st authors), Iglesias, J.E., van der Kouwe, A.J.W.,
Boyd, E., Reuter, M., Stevens, A., Van Leemput, K., McKee, A., Frosch, M.P., Fischl, B.,
and Augustinack, J.C., High-resolution magnetic resonance imaging reveals nuclei of the 
human amygdala: manual segmentation to automatic atlas. Neuroimage 155, 2017, 370-382.
http://doi.org/10.1016/j.neuroimage.2017.04.046

[20] Iglesias, J.E., Van Leemput, K., Augustinack, J., Insausti, R., Fischl, B., 
and Reuter, M., Bayesian longitudinal segmentation of hippocampal substructures in brain MRI
using subject-specific atlases. Neuroimage 141, 2016, 542-555. 
http://doi.org/10.1016/j.neuroimage.2016.07.020

