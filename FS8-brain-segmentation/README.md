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
Gives (after copying)
```bash
sudo cp mri_histo_atlas_segment_fast.sh /Applications/freesurfer/8.0.0-beta/bin/mri_histo_atlas_segment_fast
sudo chmod +x /Applications/freesurfer/8.0.0-beta/bin/mri_histo_atlas_segment_fast
sudo cp segment_fast.py /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation//scripts/
sudo cp atlas.nii.gz /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation/data_mni/
```
the following:
```bash
BGA_046 % mri_histo_atlas_segment_fast BGA_046_native.nii.gz Histo_atlas_segment 0 -1       
Running command:
fspython /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation//scripts/segment_fast.py --i BGA_046_native.nii.gz --i_seg Histo_atlas_segment/SynthSeg.mgz --i_field Histo_atlas_segment/atlas_registration.nii.gz --atlas_dir /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation//atlas_simplified --o Histo_atlas_segment --bf_mode dct --threads -1 --resolution 0.4 --skip 3 --synthmorph_reg 0.05 --write_bias_corrected --cpu
  
using all available threads ( 16 )
Warning: output directory exists (I will still proceed))
Using the CPU
Current Time = 10:58:27
Reading input image
Running SynthSeg
....
FileNotFoundError: /Applications/freesurfer/8.0.0-beta/python/packages/ERC_bayesian_segmentation/data_mni/atlas.nii.gz is not a file
....
Current Time = 11:10:35
Reading input image
Found input synthseg segmentation
Input segmentation exists; making sure it includes parcellation!
INFO: using NIfTI-1 sform (sform_code=1)
Correcting bias field
   Trying model with polynomial basis functions
Gaussian filtering for bias field correction
  Using DCT basis functions
Bias field correction
  Iteration 1: difference is 2.076913595199585
  Iteration 2: difference is 0.032503336668014526
....
  Iteration 41: difference is 9.538921403873246e-07
  Converged
Normalizing intensities
   Running SynthMorph
/Applications/freesurfer/8.0.0-beta/python/lib/python3.8/site-packages/torch/functional.py:504: UserWarning: torch.meshgrid: in an upcoming release, it will be required to pass the indexing argument. (Triggered internally at /Users/runner/work/pytorch/pytorch/pytorch/aten/src/ATen/native/TensorShape.cpp:3527.)
  return _VF.meshgrid(tensors, **kwargs)  # type: ignore[attr-defined]
  Creating and applying mask
  Creating and applying mask
Reading in atlas
using all available threads ( 16 )
Warning: output directory exists (I will still proceed))
Using the CPU
Current Time = 11:15:40
Reading input image
Found input synthseg segmentation
Input segmentation exists; making sure it includes parcellation!
INFO: using NIfTI-1 sform (sform_code=1)
Correcting bias field
   Trying model with polynomial basis functions
Gaussian filtering for bias field correction
  Using DCT basis functions
Bias field correction
  Iteration 1: difference is 2.076913595199585
  Iteration 2: difference is 0.032503336668014526
  Iteration 3: difference is 0.00 ....
...


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



## Atlas names and labels

https://github.com/freesurfer/freesurfer/blob/dev/mri_histo_util/ERC_bayesian_segmentation/data_full/atlas_names_and_labels.yaml

```bash
Atlas Names and Labels:
- Unknown: 0
- white_matter_of_forebrain: 7
- head_of_caudate: 48
- anterior_horn_of_lateral_ventricle: 50
- septum_pellucidum: 68
- putamen: 79
- anterior_olfactory_nucleus: 99
- olfactory_tubercle: 100
- core_of_nucleus_accumbens: 101
- claustrum: 102
- medial_septal_nucleus: 103
- basal_nucleus_of_meynert: 108
- diagonal_band: 111
- lateral_olfactory_stria: 113
- optic_nerve: 114
- bed_nucleus_of_stria_terminalis: 117
- body_of_caudate: 118
- external_segment_of_globus_pallidus: 119
- ventral_pallidus: 120
- lateral_olfactory_area: 125
- substantia_innominata: 128
- anterior_commissure: 130
- preoptic_region_of_hth: 147
- lateral_preoptic_area: 149
- median_preoptic_nucleus: 150
- layer_iii_of_piriform_cortex: 157
- suprachiasmatic_nucleus: 160
- optic_chiasm: 161
- temporal_claustrum: 174
- supraoptic_region_of_hth: 181
- stria_terminalis: 184
- magnocellular_division_of_reticular_nucleus: 190
- parvocellular_division_of_reticular_nucleus_(perireticular_nucleus): 191
- medial_preoptic_nucleus: 192
- anterior_hypothalamic_nucleus: 193
- paraventricular_nucleus_of_hypothalamus: 194
- supraoptic_nucleus: 196
- fornix: 199
- stria_medullaris_of_thalamus: 201
- internal_segment_of_globus_pallidus: 206
- periventricular_nucleus__supraoptic_portion: 207
- optic_tract: 208
- supraoptic_dicussation: 209
- amygdaloid_complex: 214
- anterior_amygdaloid_area: 215
- basolateral_nucleus_(basal_nucleus): 216
- ventral_division_of_basomedial_nucleus: 217
- thalamus: 218
- anterodorsal_nucleus_of_thalamus: 219
- anteroventral_nucleus_of_thalamus: 220
- parataenial_nucleus_of_thalamus: 221
- parvocellular_division_of_va: 222
- fasciculosus_nucleus_of_thalamus: 223
- rhomboid_(central)_nucleus_of_thalamus: 224
- paraventricular_nucleus: 225
- zona_incerta: 226
- periventricular_nucleus__tuberal_portion: 227
- juxtaparaventricular_lateral_hypothalamic_area: 228
- dorsomedial_hypothalamic_nucleus: 229
- lateral_hypothalamic_area__tuberal_part: 230
- pallidohypothalamic_area: 232
- medial_corticohypothalamic_tract: 234
- ventral_subdivision_of_coa: 238
- paralaminar_nucleus: 240
- amygdalocortical_(corticoamygdaloid)_transition_area: 242
- dorsal_part_of_ventromedial_hypothalamic_nucleus: 243
- ventral_part_of_ventromedial_hypothalamic_nucleus: 244
- arcuate_nucleus_of_hypothalamus: 245
- inferior_thalamic_peduncle: 246
- anteromedial_nucleus_of_thalamus: 252
- reuniens_nucleus_(medioventral_nucleus)_of_thalamus: 253
- reticular_nucleus_of_thalamus: 254
- central_part_of_ventromedial_hypothalamic_nucleus: 255
- tuberomammillary_nucleus: 256
- lateral_tuberal_nuclei: 268
- ventral_medial_nucleus_of_thalamus: 274
- posterior_hypothalamic_nucleus: 275
- mammillothalamic_tract: 276
- medial_subdivision_of_central_nucleus: 277
- lateral_subdivision_of_central_nucleus: 278
- rostral_subdivision_of_medial_nucleus: 279
- magnocellular_(medial)_division_of_md: 282
- magnocellular_division_of_va: 283
- central_medial_nucleus_of_thalamus: 284
- paracentral_nucleus_of_thalamus: 285
- intermediodorsal__nucleus_of_thalamus: 286
- amygdalostriatal_transition_area: 295
- lateral__hypothalamic_area__posterior_part: 297
- mammillary_peduncle: 298
- amygdalohippocampal_area: 301
- central_dorsal_nucleus_of_thalamus: 303
- supramammillary_nucleus: 304
- lateral_part_of_medial_mammillary_nucleus: 305
- medial_part_of_medial_mammillary_nucleus: 306
- basal_division_of_medial_mammillary_nucleus: 307
- lateral_mammillary_nucleus: 308
- lenticular_fasciculus: 309
- substantia_nigra__reticular_part: 310
- central_part_of_medial_division_of_md: 312
- parvocellular_(central)_division_of_md: 313
- rostral_division_of_vl: 314
- medial_portion_of_sth: 315
- laterodorsal_portion_of_sth: 316
- amygdalohippocampal_transition_area: 320
- lateroventral_portion_of_sth: 321
- thalamic_fasciculus: 322
- uncal_subiculum: 326
- stratum_lacunosum-moleculare_of_uncal_ca1: 339
- stratum_radiatum_of_uncal_ca1: 340
- stratum_pyramidale_of_uncal_ca1: 341
- stratum_oriens_of_uncal_ca1: 342
- stratum_lacunosum-moleculare_of_rostral_ca1: 343
- stratum_radiatum_of_rostral_ca1: 344
- stratum_pyramidale_of_rostral_ca1: 345
- stratum_oriens_of_rostral_ca1: 346
- rostral_subiculum: 347
- posteroventral_putamen: 349
- dorsal_subdivision_of_vlc: 350
- substantia_nigra__compact_part: 352
- alveus: 354
- molecular_layer_of_uncal_dentate_gyrus: 364
- granular_layer_of_uncal_dentate_gyrus: 365
- polyform_layer_of_uncal_dentate_gyrus: 367
- stratum_lacunosum-moleculare_of_uncal_ca2: 368
- stratum_radiatum_of_uncal_ca2: 369
- stratum_pyramidale_of_uncal_ca2: 370
- stratum_oriens_of_uncal_ca2: 371
- stratum_lacunosum-moleculare_of_uncal_ca3: 372
- stratum_lucidum__of_uncal_ca3: 373
- stratum_pyramidale_of_uncal_ca3: 374
- stratum_oriens_of_uncal_ca3: 375
- lateral_nucleus: 377
- lateral_dorsal_nucleus_of_thalamus: 378
- densocelllular_(paralamellar)_division_of_md: 379
- multiform_(lateral)_division_of_md: 380
- ventral_subdivision_of_vlc: 381
- medial_subdivision_of_vlc_(area_x): 382
- midbrain_(mesencephalon): 384
- red_nucleus: 385
- root_of_oculomotor_nerve: 386
- tail_of_caudate: 393
- rostral_division_of_ventral_posterior_lateral_nucleus: 394
- parvocellular_division_of_vpm: 395
- lateral_division_of_centromedian_nucleus_of_thalamus: 396
- medial_division_of_centromedian_nucleus_of_thalamus: 397
- parafascicular_nucleus_of_thalamus: 398
- periventricular_area_of_thalamus: 399
- nucleus_of_the_field_of_forel: 400
- parabrachial_pigmented_nucleus: 401
- cerebellothalamic_tract: 403
- molecular_layer_of_rostral_dentate_gyrus: 404
- granular_layer_of_rostral_dentate_gyrus: 405
- polyform_layer_of_rostral_dentate_gyrus: 407
- stratum_lacunosum-moleculare_of_rostral_ca2: 408
- stratum_radiatum_of_rostral_ca2: 409
- stratum_pyramidale_of_rostral_ca2: 410
- stratum_oriens_of_rostral_ca2: 411
- fasciculus_retroflexus_(habenuno-interpeduncular_tract): 412
- pontine_nucleus: 414
- pontocerebellar_tract: 415
- stratum_lacunosum-moleculare_of_rostral_ca3: 418
- stratum_lucidum__of_rostral_ca3: 419
- stratum_pyramidale_of_rostral_ca3: 420
- stratum_oriens_of_rostral_ca3: 421
- pyramidal_cells_of_uncal_ca4: 422
- ventral_posterior_medial_nucleus: 423
- ventral_posterior_inferior_nucleus: 424
- lateral_division_of_central_lateral_nucleus: 425
- subparafascicular_nucleus_of_thalamus: 426
- lateral_habenular_nucleus: 430
- white_matter_of_midbrain: 431
- pyramidal_cells_of_rostral_ca4: 432
- parasubthalamic_nucleus: 433
- ventral_tegmental_area: 435
- interpeduncular_nucleus: 436
- lateral_posterior_nucleus_of_thalamus: 441
- basal_ventral_medial_nucleus: 442
- dorsal_division_of_central_lateral_nucleus: 443
- medial_habenular_nucleus: 444
- edinger-westphal_nucleus_(accessory_oculomotor_nucleus): 447
- interstitial_nucleus_of_cajal: 451
- anterior_nucleus_of_pulvinar: 454
- caudal_division_of_ventral_posterior_lateral_nucleus: 458
- fimbria: 461
- oculomotor_nucleus: 464
- periaqueductal_gray_substance: 465
- precommissural_nucleus: 468
- interstitial_nucleus_of_posterior_commissure: 469
- subcommissural_organ: 470
- decussation_of_superior_cerebellar_peduncle: 471
- posterior_commissure: 472
- posterior_nucleus_of_thalamus: 478
- centromedian_nucleus_of_thalamus: 479
- dorsal_lateral_geniculate_nucleus: 484
- limitans_nucleus: 492
- habenular_commissure: 493
- pretectal_region: 496
- peripeduncular_nucleus: 498
- medial_lemniscus: 499
- dorsal_medial_geniculate_nucleus: 504
- ventral_medial_geniculate_nucleus: 505
- pineal_body: 506
- superior_colliculus: 507
- medial_nucleus_of_pulvinar: 508
- magnocellular_(medial)_nucleus: 510
- suprageniculate_nucleus_of_thalamus: 512
- lateral_lemniscus: 515
- lateral_nucleus_of_pulvinar: 517
- inferior_nucleus_of_pulvinar: 519
- trochlear_nucleus: 520
- dorsal_raphe_nucleus: 521
- brachium_of_inferior_colliculus: 525
- brachium_of_superior_colliculus: 526
- pontine_reticular_formation: 527
- medial_longitudinal_fasciculus: 528
- superior_cerebellar_peduncle_(brachium_conjunctivum): 531
- root_of_trochlear_nerve: 535
- central_nucleus_of_inferior_colliculus: 541
- parabigeminal_nucleus: 542
- middle_cerebellar_peduncle: 543
- lateral_parabrachial_nucleus: 546
- molecular_layer_of_caudal_dentate_gyrus: 558
- granular_layer_of_caudal_dentate_gyrus: 559
- polyform_layer_of_caudal_dentate_gyrus: 561
- stratum_lacunosum-moleculare_of_caudal_ca1: 562
- stratum_radiatum_of_caudal_ca1: 563
- stratum_pyramidale_of_caudal_ca1: 564
- stratum_oriens_of_caudal_ca1: 565
- stratum_lacunosum-moleculare_of_caudal_ca2: 566
- stratum_radiatum_of_caudal_ca2: 567
- stratum_pyramidale_of_caudal_ca2: 568
- stratum_oriens_of_caudal_ca2: 569
- stratum_lacunosum-moleculare_of_caudal_ca3: 571
- stratum_lucidum__of_caudal_ca3: 572
- stratum_pyramidale_of_caudal_ca3: 573
- stratum_oriens_of_caudal_ca3: 574
- pyramidal_cells_of_caudal_ca4: 575
- caudal_subiculum: 576
- pulvinar_of_thalamus: 578
- pons: 580
- medial_parabrachial_nucleus: 581
- commissure_of_inferior_colliculus: 586
- nucleus_coeruleus: 589
- central_tegmental_tract: 591
- spinal_lemniscus_in_hindbrain: 592
- molecular_layer_of_pva: 595
- granular_cell_layer_of_pva: 597
- dorsal_nucleus_of_lateral_lemniscus: 598
- ventral_nucleus_of_lateral_lemniscus: 599
- mesencephalic_trigeminal_tract: 600
- central_gray_of_pons: 610
- white_matter_of_hindbrain: 611
- rostral_(anterior)_medullary_velum: 617
- root_of_facial_nerve: 624
- motor_nucleus_of_trigeminal_nerve: 630
- mesencephalic_trigeminal_nucleus: 645
- nucleus_of_trapezoid_body: 647
- medial_superior_olive: 649
- inferior_olive__principal_nucleus: 654
- amiculum_of_the_olive: 655
- principal_sensory_nucleus_of_trigeminal_nerve: 659
- lateral_superior_olivary_nucleus: 660
- myelencephalon_(medulla_oblongata): 662
- facial_nucleus: 666
- spinal_trigeminal_nucleus: 669
- inferior_olive__medial_nucleus: 671
- spinal_trigeminal_tract: 677
- abducens_nucleus: 682
- superior_vestibular_nucleus: 683
- inferior_olive__dorsal_nucleus: 685
- solitary_tract: 687
- ventral_cochlear_nucleus: 689
- lateral_vestibular_nucleus: 690
- ambiguus_nucleus: 693
- medial_vestibular_nucleus: 694
- medullary_reticular_formation: 695
- inferior_cerebellar_peduncle: 697
- spinal_(inferior)_vestibular_nucleus: 703
- fastigial_(medial)_nucleus: 715
- solitary_nucleus: 717
- dentate_(lateral)_nucleus: 721
- hypoglossal_nucleus: 724
- dorsal_motor_nucleus_of_the_vagus_(vagal_nucleus): 725
- external_(accessory/lateral)_cuneate_nucleus: 726
- dorsal_cochlear_nucleus: 731
- medial_interpositus_(globose)_nucleus: 751
- lateral_interpositus_(emboliform)_nucleus: 752
- cuneate_nucleus: 755
- gracile_nucleus: 756
- central_gray_of_medulla_oblongata: 765
- spinal_accessory_(supraspinal)_nucleus: 771
- corticospinal_tract: 779
- superficial_pulvinar_nucleus: 811
- diffuse_pulvinar_nucleus: 813
- parietotemporopontine_tract: 827
- corticonuclear_tract: 828
- frontopontine_tract: 829
- decussation_of_trochlear_nerve_fibres: 842
- infundibular_stalk: 843
- reticular_formation_/_cuneiform_area: 844
- ctx-rh-bankssts: 2001
- ctx-rh-caudalanteriorcingulate: 2002
- ctx-rh-caudalmiddlefrontal: 2003
- ctx-rh-cuneus: 2005
- ctx-rh-entorhinal: 2006
- ctx-rh-fusiform: 2007
- ctx-rh-inferiorparietal: 2008
- ctx-rh-inferiortemporal: 2009
- ctx-rh-isthmuscingulate: 2010
- ctx-rh-lateraloccipital: 2011
- ctx-rh-lateralorbitofrontal: 2012
- ctx-rh-lingual: 2013
- ctx-rh-medialorbitofrontal: 2014
- ctx-rh-middletemporal: 2015
- ctx-rh-parahippocampal: 2016
- ctx-rh-paracentral: 2017
- ctx-rh-parsopercularis: 2018
- ctx-rh-parsorbitalis: 2019
- ctx-rh-parstriangularis: 2020
- ctx-rh-pericalcarine: 2021
- ctx-rh-postcentral: 2022
- ctx-rh-posteriorcingulate: 2023
- ctx-rh-precentral: 2024
- ctx-rh-precuneus: 2025
- ctx-rh-rostralanteriorcingulate: 2026
- ctx-rh-rostralmiddlefrontal: 2027
- ctx-rh-superiorfrontal: 2028
- ctx-rh-superiorparietal: 2029
- ctx-rh-superiortemporal: 2030
- ctx-rh-supramarginal: 2031
- ctx-rh-frontalpole: 2032
- ctx-rh-temporalpole: 2033
- ctx-rh-transversetemporal: 2034
- ctx-rh-insula: 2035
```
