# TSO500R 0.2.0 "Bubo Scandiacus"

*Initial public release - December 2025*

## Features

### 📥 Data Import
- Parse `MetricsOutput.tsv` quality control files
- Process `CombinedVariantOutput.tsv` variant analysis outputs
- Support for DRAGEN pipeline, LocalApp, and ctDNA workflows
- Extract small variants, CNVs, fusions, and splice variants

### 🔧 Data Processing
- Automated filtering and processing pipeline
- Filter by variant consequence, depth, germline databases, COSMIC IDs
- Parse P Dot notation for protein information
- Integrate TMB and amplification data

### 📊 Visualization
- Allele frequency plots (distributions, KDE, histograms)
- OncoPrint data preparation
- QC summary tables
- Consistent plotting themes

### 💾 Export
- DRAGEN-compatible sample sheets
- RData objects
- Excel workbooks

### ✅ Quality Control
- DNA and RNA QC metrics extraction
- CNV, TMB, and MSI metrics
- Data validation functions

## Documentation
- Comprehensive README and function documentation
- GitHub Pages site: https://boehringer-ingelheim.github.io/TSO500R/
- Example workflows

## Installation

```r
# Install from GitHub
pak::pak("Boehringer-Ingelheim/TSO500R")
```

## Getting Help
- Report bugs: https://github.com/Boehringer-Ingelheim/TSO500R/issues
- Contact: @christopher-mohr