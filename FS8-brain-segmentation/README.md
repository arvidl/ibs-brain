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


### mri_histo_atlas_segment

```bash
mri_histo_atlas_segment --help
``` 
Bayesian segmentation with histological whole brain atlas.
 
Next-Generation histological atlas for high-resolution segmentation of human brain MRI
Casamitjana et al. (in preparation)

#### Usage
```bash
Usage:
   mri_histo_atlas_segment INPUT_SCAN OUTPUT_DIRECTORY ATLAS_MODE GPU THREADS [BF_MODE] [GMM_MODE]
 
INPUT SCAN: scan to process, in mgz or nii(.gz) format
OUTPUT_DIRECTORY: directory with segmentations, volume files, etc
ATLAS_MODE: must be full (all 333 labels) or simplified (simpler brainstem protocol; recommended)
GPU: set to 1 to use the GPU (*highly* recommended but requires a 24GB GPU!)
THREADS: number of CPU threads to use (use -1 for all available threads)
BF_MODE (optional): bias field model: dct (default), polynomial, or hybrid
GMM_MODE (optional): must be 1mm (default) unless you define your own (see documentation)
```

For example, you can segment bert with a GPU and 8 CPU threads with:
```bash
mri_histo_atlas_segment $SUBJECTS_DIR/bert/mri/orig.mgz $SUBJECTS_DIR/bert/mri/histo_atlas_segmentation/ simplified 1 8
```

In the output directory, you will find:
```bash
bf_corrected.mgz: a bias field corrected version of the input scan.

SynthSeg.mgz: SynthSeg segmentation of the input (which we use in preprocessing and to initialize Gaussian parameters).

MNI_registration.mgz: EasyReg registration to MNI space, use in preprocessing.

seg_[left/right].mgz: segmentation into 333 ROIs of the left and right hemisphere, respectively.

vols_[left/right].csv: CSV spreadsheet with the volumes of the different ROIs, computed from the posteriors (soft segmentations).

lookup_table.txt: FreeSurfer lookup table mapping label indices to brain anatomy. You need it when visualizing the segmentations with Freeview.
```

In our case (BGA_046):
```bash
BGA_046 % mri_histo_atlas_segment BGA_046_native.nii.gz Histo_atlas_segment simplified 0 -1 
```
Gives (first time):
```bash
   Atlas files not found for mode simplified. Please download atlas from: 
      https://ftp.nmr.mgh.harvard.edu/pub/dist/lcnpublic/dist/Histo_Atlas_Iglesias_2023/atlas_simplified.zip 
   and uncompress it into:  
      /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation// 
   You only need to do this once for mode simplified. You can use the following three commands (may require root access): 
      1: cd /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation/
      2a (in Linux): wget https://ftp.nmr.mgh.harvard.edu/pub/dist/lcnpublic/dist/Histo_Atlas_Iglesias_2023/atlas_simplified.zip 
      2b (in MAC): curl -o atlas.zip https://ftp.nmr.mgh.harvard.edu/pub/dist/lcnpublic/dist/Histo_Atlas_Iglesias_2023/atlas_simplified.zip 
      3. unzip atlas_simplified.zip
 
   After correct extraction, the directory: 
      /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation//atlas_simplified 
   should contain files: size.npy, label_001.npz, label_002.npz, ...
```

### Usage (fast version)
We also distribute a fast version, where the atlas deformation is pre-computed with a neural network, and then kept constant during the optimization, such that we only need to run the EM algorithm once for the Gaussian parameters and that is it.

```bash
mri_histo_atlas_segment_fast INPUT_SCAN OUTPUT_DIRECTORY GPU THREADS [BF_MODE]
```
The options are similar to mri_histo_atlas_segment, but the atlas and gmm modes are always 'simplified' and '1mm', respectively. The output files in the output directory follow the same convention.

This faster version is particularly useful if you are running the code on the CPU rather than CPU. On a semi-modern desktop, the run time should be less than an hour (note that it segments both hemispheres in a single run, as opposed to the full Bayesian version).

In our case (BGA_046):
```bash
BGA_046 % mri_histo_atlas_segment_fast BGA_046_native.nii.gz Histo_atlas_segment 0 -1
```

#### Frequently asked questions (FAQ)
- Do I really need a GPU for the 'full' Bayesian version?

Technically, no. In practice, yes. On a modern GPU, the code runs in an hour or less. On the CPU, it depends on the number of threads, but it can easily take a whole day or more.

- Do I need a GPU for the fast version?

Certainly no! The code should run in less than an hour on any semi-modern workstation, if you allocate enough threads.

- What do the BF_MODE and GMM_MODE arguments do?

You should not need to touch these, but the BF_MODE changes the set of basis functions for bias field correction and you could potentially try tinkering with it if the bias field correction fails (i.e., if bf_corrected.mgz has noticeable bias). GMM_MODE allows you to change the grouping of ROIs into tissue classes (advanced mode!). The GMM model is crucial as it determines how different brain regions are grouped into tissue types for the purpose of image intensity modeling. This is specified though a set of files that should be found under 'data' in the atlas directory:

- data/gmm_components_[GMM_MODE].yaml: defines tissue classes and specificies the number of components of the corresponding GMM

- data/combined_aseg_labels_[GMM_MODE].yaml defines the labels that belong to each tissue class

- data/combined_atlas_labels_[GMM_MODE].yaml defines FreeSurfer ('aseg') labels that are used to initialize the parameters of each class.

Note that, in in dev versions newer than August 23 2024, these files are located under data_full and data_simplified (one directory per atlas / protocol).

We distribute a GMM_MODE named "1mm" that we have used in our experiments, and which is the default mode of the code. If you want to use your own model, you will need to create another triplet of files of your own (use the 1mm version as template).


# https://github.com/freesurfer/freesurfer/edit/dev/mri_histo_util/README.md

This is an implementation of a Bayesian segmentation method that relies on the histological atlas presented in the article:
"Next-Generation histological atlas and segmentation tool for echo "high-resolution in vivo human neuroimaging", by 
Casamitjana et al. 
-- preprint available at https://www.biorxiv.org/content/10.1101/2024.02.05.579016v1 

The code also relies on:

B Billot, DN Greve, O Puonti, A Thielscher, K Van Leemput, B Fischl, AV Dalca, and JE Iglesias. 
"SynthSeg: Segmentation of brain MRI scans of any contrast and resolution without retraining." 
Medical image analysis 86 (2023): 102789.

B Billot, C Magdamo, Y Cheng, SE Arnold, S Das, and JE Iglesias.
"Robust machine learning segmentation for large-scale analysis of heterogeneous clinical brain MRI datasets."
Proceedings of the National Academy of Sciences, 120 (2023): e2216399120.

JE Iglesias.
A ready-to-use machine learning tool for symmetric multi-modality registration of brain MRI. 
Scientific Reports, 13 (2023): 6657.

## Prerequisites:

This code requires a modern version of FreeSurfer (7.4.0 or newer), which must be sourced before running the code.

The first time you run the method, it will prompt you to download the atlas files, which are not distributed with the code.


## Usage for 'full' Bayesian version (slow):

To run the code, please use the script segment.sh as follows:

mri_histo_atlas_segment INPUT_SCAN OUTPUT_DIRECTORY ATLAS_MODE GPU THREADS [BF_MODE] [GMM_MODE]

- INPUT SCAN: scan to process, in nii(.gz) or mgz format
- OUTPUT_DIRECTORY: directory where segmentations, volume files, etc will be written (more on this below).
- ATLAS_MODE: must be full (all 333 labels) or simplified (simpler brainstem protocol; recommended)
- GPU: set to 1 to use the GPU (*highly* recommended but requires a 24GB GPU!)
- THREADS: number of CPU threads to use (use -1 for all available threads)
- BF_MODE (optional): bias field mode: dct (default), polynomial, or hybrid
- GMM_MODE (optional): gaussian mixture model (GMM) model must be 1mm unless you define your own (see documentation)

Note that the first time that you run the code, you may be prompted you to download the atlas separately.

Also, Using a GPU (minimum memory: 24GB) is highly recommended. On the GPU, the code runs in about an hour (30 mins/hemisphere).
On the CPU, the running time depends heavily on the number of threads, but it can easily take over 10 hours if you do not
use many (>10) threads! Even if you use the GPU, we recommend using a bunch of CPU threads (e.g., 8) if possible, so the CPU 
parts of the algorithm run faster.

The default bias field mode (dct) uses a set of discrete cosine transform basis functions to model the bias field. The
polynomial mode uses a set of low-order 3D polynomials. The hybrid mode uses a combination of dct and polynomials.

The GMM model is crucial as it determines how different brain regions are grouped into tissue types for the purpose of 
image intensity modeling. This is specified though a set of files that should be found under data:

- data_[full/simplified]/gmm_components_[GMM_MODE].yaml: defines tissue classes and specificies the number of components of the corresponding GMM
- data_[full/simplified]/combined_aseg_labels_[GMM_MODE].yaml: defines the labels that belong to each tissue class
- data_[full/simplified]/combined_atlas_labels_[GMM_MODE].yaml: defines FreeSurfer ("aseg") labels that are used to initialize the parameters of each class.

We distribute a GMM_MODE named "1mm" that we have used in our experiments, and which is the default mode of the code. If you 
want to use your own model, you will need to create another triplet of files of your own (use the 1mm version as template).


## Output:

The output directory will contain the following files:

- bf_corrected.mgz: bias field corrected version of the input scan
- SynthSeg.mgz: SynthSeg segmentation of the scan at the whole structure level
- MNI_registration.mgz: deformation file with registration to MNI atlas (which can be found under data/mni.nii.gz)
- seg_[left/right].mgz: segmentation files (one per hemisphere).
- vols_[left/right].csv: files with volumes of the brain regions segmented by the atlas, in CSV format.
- lookup_table.txt: the lookup table to visualize seg_[left/right].mgz, for convenience
- done: this is an empty file that gets written upon successful completion of the pipeline.

You can visualize the output by CDing into the results directory and running the command:

freeview -v bf_corrected.mgz -v seg_left.mgz:colormap=lut:lut=lookup_table.txt -v seg_right.mgz:colormap=lut:lut=lookup_table.txt
 
## Alternative 'fast' version:

We also distribute a fast version, where the atlas deformation is pre-computed with a neural network,
and then kept constant during the optimization, such that we only need to run the EM algorithm once for
the Gaussian parameters and that is it.

mri_histo_atlas_segment_fast INPUT_SCAN OUTPUT_DIRECTORY GPU THREADS [BF_MODE]

The options are similar to mri_histo_atlas_segment, but the atlas and gmm modes are always 'simplified' and '1mm', respectively. 
The output files in the output directory follow the same convention.

This faster version is particularly useful if you are running the code on the CPU rather than CPU. 
On a semi-modern desktop, the run time should be less than an hour (note that it segments both 
hemispheres in a single run, as opposed to the full Bayesian version).

