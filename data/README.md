# Data

*[Stefano De Sabbata](https://stefanodesabbata.com)*

[This work](https://github.com/sdesabbata/granolarr) is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html) except where specified. 

The data used in these materials are derived from data released by the [Office for National Statistics](https://geoportal.statistics.gov.uk/), [Chris Gale](http://geogale.github.io/2011OAC/) ([Office for National Statistics](https://geoportal.statistics.gov.uk/)), the [ESRC Consumer Data Research Centre](https://data.cdrc.ac.uk/), the [Ministry of Housing, Communities & Local Government](https://opendatacommunities.org/home) and the [UK Data Service](https://ukdataservice.ac.uk/), licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/); contains National Statistics data Crown copyright and database right 2015; contains Ordnance Survey data Crown copyright and database right 2015 and 2016.

## Get the data

Please create a `storage` folder in the main repository folder before following the instructions below.

- [OA11_LSOA11_MSOA11_LAD11_EW_LU.zip](https://borders.ukdataservice.ac.uk/lut_download_data.html?data=oa11_lsoa11_msoa11_lad11_ew_lu)
    - Source: [UK Data Service](https://ukdataservice.ac.uk/) licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
    - Pre-processing:
        - download in the `storage` folder.
- [2011 OAC Variables - 167 Initial.zip](http://tiny.cc/OAC-Var-167)
    - Source: [Chris Gale](http://geogale.github.io/2011OAC/) ([Office for National Statistics](https://geoportal.statistics.gov.uk/)), licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
    - Pre-processing:
        - download in the `storage` folder;
        - run the `src/utils/Create_2011OAC_Leicester_dataset.R` script.
- [Indexes of Multiple deprivation 2015](https://opendatacommunities.org/resource?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fimd%2Findices)
    - Source: [Ministry of Housing, Communities & Local Government](https://opendatacommunities.org/home) licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
    - Pre-processing:
        - download in the `storage` folder;
        - rename the column `Indices of Deprivation` as `IndicesOfDeprivation`;
        - run: `src/utils/Create_IMD2015_Leicester_dataset.R`.
- CDRC's [Census Residential Data Pack 2011: Leicester](https://data.cdrc.ac.uk/system/files/Census_Residential_Data_Pack_2011/Census_Residential_Data_Pack_2011_E06000016.zip)
    - Source: [ESRC Consumer Data Research Centre](https://data.cdrc.ac.uk/) licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/); Contains National Statistics data Crown copyright and database right 2015; Contains Ordnance Survey data Crown copyright and database right 2015.
    - Pre-processing:
        - download in the `data` folder.
- [Rural Urban Classification (2011) of Output Areas in England and Wales](https://geoportal.statistics.gov.uk/datasets/3ce248e9651f4dc094f84a4c5de18655/about)
    - Source: [Office for National Statistics](https://geoportal.statistics.gov.uk/) licensed under the [Open Government Licence v.3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/); Contains OS data © Crown copyright and database right 2016.
    - Pre-processing:
        - download in the `data` folder.
