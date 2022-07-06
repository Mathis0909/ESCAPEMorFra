# <div align = "center"> ESCAPE project: Spatial Analysis on *Mormopterus francoismoutoui* </div>

Table of contents 

- [<div align = "center"> ESCAPE project: Spatial Analysis on *Mormopterus francoismoutoui* </div>](#div-align--center-escape-project-spatial-analysis-on-mormopterus-francoismoutoui-div)
- [Basic Overview](#basic-overview)
- [1 Pipeline part: Shaping bearings data](#1-pipeline-part-shaping-bearings-data)
  - [Input Data Informations](#input-data-informations)
  - [Output Folders Structuration](#output-folders-structuration)

# Basic Overview 

:red_circle: This pipeline allow to convert bearings issue to transmitters signal recorded on the field to waypoints. In the second step, several spatial analysis are realised with this data.

:arrow_forward: This process is run with *makefile.R* script, but before it all parameters must to be complete into function *global_parameters.r* (see part bellow). 

:information_source: Run the code bellow to get a visual of pipeline. 

```
install.packages("targets")
targets::tar_visnetwork()
```


# 1 Pipeline part: Shaping bearings data

## Input Data Informations

Bellow you can see variables necessary to run pipeline and their description (**[Name_variable]**). It's a help to complete *global_parameters.r* script before run the pipeline.

:white_check_mark: **[BDD]**:  Database called *bear_test.txt* (.txt extension) came to field. The database format must to be like bellow.

| Columns database | Description |
| :----: |   :-------------: |
| ID             | Number. Logger number to creat correspondance to metadata (biometry)
| Date           | Date. Date of observation  |
| Observers      | Names of observers |
| Northing      | Numeric. X location of the receiver (UTM) | 
| Easting       | Numeric. Y location of the receiver (UTm) |
| Time           |??. Time of observation |
| GID          | Numeric. Observation grouping number |
| Azimuth       | Azimuth bearing toward transmitter signal |

:white_check_mark: **[output]**: Path where you want to export output files


## Output Folders Structuration

- :open_file_folder:  output

  - :page_facing_up: BDD_waypoints.csv *--(triangulation.r)--*